
import 'package:flutter/material.dart';
import '../../models/data_models.dart';
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';

class MainProvider with ChangeNotifier {
  List<Recipe> _recipes = [];
  List<Recipe> _filteredRecipes = [];
  List<String> _favoriteIds = [];
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();
  bool _isLoading = true;
  String _searchQuery = '';
  DishType? _selectedFilter;

  List<Recipe> get recipes => _filteredRecipes.isEmpty && _searchQuery.isEmpty && _selectedFilter == null
      ? _recipes
      : _filteredRecipes;
  List<Recipe> get allRecipes => _recipes;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  DishType? get selectedFilter => _selectedFilter;
  List<String> get favoriteIds => _favoriteIds;

  MainProvider() {
    _initRealtimeUpdates();
    _loadFavorites();
  }

  void _initRealtimeUpdates() {
    _firestoreService.getRecipesStream().listen(
      (recipes) {
        _recipes = recipes;
        _applyFilters();
        _isLoading = false;
        notifyListeners();
      },
      onError: (error) {
        _isLoading = false;
        notifyListeners();
        // Error handling - could emit error state here
      },
    );
  }

  Future<void> _loadFavorites() async {
    final user = _authService.currentUser;
    if (user != null) {
      _favoriteIds = await _firestoreService.getUserFavorites(user.uid);
      notifyListeners();
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }

  void setFilter(DishType? type) {
    _selectedFilter = type;
    _applyFilters();
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedFilter = null;
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    _filteredRecipes = _recipes.where((recipe) {
      // Search filter
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final matchesSearch = recipe.title.toLowerCase().contains(query) ||
            recipe.description.toLowerCase().contains(query) ||
            recipe.ingredients.any((ing) => ing.toLowerCase().contains(query));
        if (!matchesSearch) return false;
      }

      // Type filter
      if (_selectedFilter != null && recipe.type != _selectedFilter) {
        return false;
      }

      return true;
    }).toList();
  }

  bool isFavorite(String recipeId) {
    return _favoriteIds.contains(recipeId);
  }

  Future<void> toggleFavorite(String recipeId) async {
    final user = _authService.currentUser;
    if (user == null) return;

    try {
      if (_favoriteIds.contains(recipeId)) {
        await _firestoreService.removeFavorite(user.uid, recipeId);
        _favoriteIds.remove(recipeId);
      } else {
        await _firestoreService.addFavorite(user.uid, recipeId);
        _favoriteIds.add(recipeId);
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  List<Recipe> getFavoriteRecipes() {
    return _recipes.where((recipe) => _favoriteIds.contains(recipe.id)).toList();
  }

  Future<void> addRecipe(Recipe recipe) async {
    try {
      await _firestoreService.addRecipe(recipe);
    } catch (e) {
      rethrow;
    }
  }
  
  Future<void> seedData() async {
    try {
      await _firestoreService.seedMockData();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
      _favoriteIds.clear();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
