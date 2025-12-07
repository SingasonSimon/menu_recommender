
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
}
