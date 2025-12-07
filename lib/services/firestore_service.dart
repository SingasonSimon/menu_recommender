
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/data_models.dart';
import 'mock_data_service.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Recipe>> getRecipesStream() {
    return _db.collection('recipes').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Recipe.fromMap(doc.data(), doc.id)).toList();
    });
  }

  Future<void> addRecipe(Recipe recipe) async {
    // Note: We use the recipe's map but let Firestore generate ID if new
    await _db.collection('recipes').add(recipe.toMap());
  }

  Future<void> seedMockData() async {
    final recipes = MockDataService.getRecipes();
    final batch = _db.batch();
    
    for (final recipe in recipes) {
      final docRef = _db.collection('recipes').doc(); // Auto ID
      // Create a map but ignore the ID since we used a new Auto ID
      final data = recipe.toMap();
      data.remove('id'); // Remove local ID, use Firestore ID
      batch.set(docRef, data);
    }
    
    await batch.commit();
  }

  // Favorites methods
  Future<List<String>> getUserFavorites(String userId) async {
    final doc = await _db.collection('users').doc(userId).get();
    if (doc.exists) {
      final data = doc.data();
      return List<String>.from(data?['favorites'] ?? []);
    }
    return [];
  }

  Future<void> addFavorite(String userId, String recipeId) async {
    await _db.collection('users').doc(userId).set({
      'favorites': FieldValue.arrayUnion([recipeId]),
    }, SetOptions(merge: true));
  }

  Future<void> removeFavorite(String userId, String recipeId) async {
    await _db.collection('users').doc(userId).set({
      'favorites': FieldValue.arrayRemove([recipeId]),
    }, SetOptions(merge: true));
  }

  // Reviews methods
  Stream<List<Review>> getRecipeReviews(String recipeId) {
    return _db
        .collection('recipes')
        .doc(recipeId)
        .collection('reviews')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Review.fromMap(doc.data())).toList();
    });
  }

  Future<void> addReview(String recipeId, Review review) async {
    await _db
        .collection('recipes')
        .doc(recipeId)
        .collection('reviews')
        .doc(review.id)
        .set(review.toMap());

    // Update recipe rating
    await _updateRecipeRating(recipeId);
  }

  Future<void> _updateRecipeRating(String recipeId) async {
    final reviewsSnapshot = await _db
        .collection('recipes')
        .doc(recipeId)
        .collection('reviews')
        .get();

    if (reviewsSnapshot.docs.isEmpty) return;

    double totalRating = 0;
    for (var doc in reviewsSnapshot.docs) {
      final review = Review.fromMap(doc.data());
      totalRating += review.rating;
    }

    final averageRating = totalRating / reviewsSnapshot.docs.length;

    await _db.collection('recipes').doc(recipeId).update({
      'rating': averageRating,
      'reviewsCount': reviewsSnapshot.docs.length,
    });
  }
}
