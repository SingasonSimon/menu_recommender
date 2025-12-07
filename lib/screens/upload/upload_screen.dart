
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../core/theme/app_theme.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _imagePath;
  String _title = '';
  String _description = '';

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        _imagePath = result.files.single.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Recipe')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.greyText.withValues(alpha: 0.5)),
                  image: _imagePath != null
                      ? DecorationImage(
                          image: AssetImage(_imagePath!), // Note: In real app use FileImage
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                alignment: Alignment.center,
                child: _imagePath == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add_a_photo, size: 48, color: AppColors.accentOrange),
                          SizedBox(height: 8),
                          Text('Tap to add photo', style: TextStyle(color: AppColors.greyText)),
                        ],
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Recipe Title',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: AppColors.cardSurface,
              ),
              style: const TextStyle(color: Colors.white),
              onSaved: (value) => _title = value ?? '',
              validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: AppColors.cardSurface,
              ),
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
              onSaved: (value) => _description = value ?? '',
            ),
             const SizedBox(height: 16),
             // Ingredients and Instructions would be dynamic lists here
             // For prototype simplicity, we skip full implementation
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Recipe "$_title" ($_description) Uploaded Successfully!')),
                  );
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentOrange,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Submit Recipe', style: TextStyle(color: Colors.white, fontSize: 18)),
            )
          ],
        ),
      ),
    );
  }
}
