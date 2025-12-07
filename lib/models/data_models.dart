


enum DishType { breakfast, lunch, dinner, snack, dessert }

class User {
  final String id;
  final String name;
  final String avatarUrl;

  User({required this.id, required this.name, required this.avatarUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'avatarUrl': avatarUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      avatarUrl: map['avatarUrl'] ?? '',
    );
  }
}

class Review {
  final String id;
  final String userId;
  final String userName;
  final double rating;
  final String comment;
  final DateTime date;

  Review({
    required this.id,
    required this.userId,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'rating': rating,
      'comment': comment,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      comment: map['comment'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] ?? 0),
    );
  }
}

class Recipe {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> instructions;
  final DishType type;
  final User chef;
  final double rating;
  final int reviewsCount;
  final bool isPremium;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.ingredients,
    required this.instructions,
    required this.type,
    required this.chef,
    required this.rating,
    required this.reviewsCount,
    this.isPremium = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'ingredients': ingredients,
      'instructions': instructions,
      'type': type.index,
      'chef': chef.toMap(),
      'rating': rating,
      'reviewsCount': reviewsCount,
      'isPremium': isPremium,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map, String id) {
    return Recipe(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      ingredients: List<String>.from(map['ingredients'] ?? []),
      instructions: List<String>.from(map['instructions'] ?? []),
      type: DishType.values[map['type'] ?? 0],
      chef: User.fromMap(map['chef'] ?? {}),
      rating: (map['rating'] ?? 0).toDouble(),
      reviewsCount: map['reviewsCount'] ?? 0,
      isPremium: map['isPremium'] ?? false,
    );
  }
}

class Menu {
  final String id;
  final String title;
  final String description;
  final List<Recipe> recipes; // Simplified: In DB this might be IDs, but for now we embed or fetch
  final String imageUrl;

  Menu({
    required this.id,
    required this.title,
    required this.description,
    required this.recipes,
    required this.imageUrl,
  });
  
  // Note: Serialization for Menu might be complex if we reference recipes by ID.
  // For this prototype, we'll assume we duplicate data or fetch fully.
}
