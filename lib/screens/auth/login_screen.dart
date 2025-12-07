
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  
  bool _isLogin = true;
  String _email = '';
  String _password = '';
  String _errorMessage = '';
  bool _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      if (_isLogin) {
        await _auth.signInWithEmail(_email, _password);
      } else {
        await _auth.signUpWithEmail(_email, _password);
      }
      // Auth stream in main.dart will handle navigation
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().contains('firebase_auth') 
            ? e.toString().split(']').last.trim() // Simple cleanup
            : 'Authentication failed. Please try again.';
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _googleSignIn() async {
    setState(() => _isLoading = true);
    try {
      final user = await _auth.signInWithGoogle();
      if (user == null && mounted) {
        // Cancelled
         setState(() => _isLoading = false);
      }
    } catch (e) {
      if(mounted) {
        setState(() {
          _errorMessage = 'Google Sign-In failed: $e';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.background, Color(0xFF121212)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Menu Recommender',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.accentOrange,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _isLogin ? 'Welcome Back' : 'Create Account',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 48),
                Card(
                  color: AppColors.cardSurface.withValues(alpha: 0.8),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_errorMessage.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                _errorMessage,
                                style: const TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value) => _email = value!.trim(),
                            validator: (value) => value!.isEmpty || !value.contains('@') ? 'Invalid email' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock_outline),
                            ),
                            obscureText: true,
                            onSaved: (value) => _password = value!,
                            validator: (value) => value!.length < 6 ? 'Password too short (min 6)' : null,
                          ),
                          const SizedBox(height: 24),
                           _isLoading 
                              ? const CircularProgressIndicator()
                              : SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: _submit,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.accentOrange,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                    ),
                                    child: Text(
                                      _isLogin ? 'Sign In' : 'Sign Up', 
                                      style: const TextStyle(color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () => setState(() {
                              _isLogin = !_isLogin;
                              _errorMessage = '';
                            }),
                            child: Text(
                              _isLogin ? 'Need an account? Sign Up' : 'Have an account? Sign In',
                              style: const TextStyle(color: AppColors.cream),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Row(children: [
                   Expanded(child: Divider()),
                   Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('OR')),
                   Expanded(child: Divider()),
                ]),
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  onPressed: _isLoading ? null : _googleSignIn,
                  icon: const Icon(Icons.login, color: Colors.white), // Use generic icon to avoid asset dependency
                  label: const Text('Continue with Google', style: TextStyle(color: Colors.white)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
