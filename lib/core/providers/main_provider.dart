
import 'package:flutter/material.dart';
import '../../models/data_models.dart';
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';

class MainProvider with ChangeNotifier {
  List<Recipe> _recipes = [];
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();
  bool _isLoading = true;

  List<Recipe> get recipes => _recipes;
  bool get isLoading => _isLoading;

  MainProvider() {
    _initRealtimeUpdates();
  }

  void _initRealtimeUpdates() {
    _firestoreService.getRecipesStream().listen((recipes) {
      _recipes = recipes;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> addRecipe(Recipe recipe) async {
    await _firestoreService.addRecipe(recipe);
  }
  
  Future<void> seedData() async {
    await _firestoreService.seedMockData();
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
