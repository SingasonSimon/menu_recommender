
import '../models/data_models.dart';

class MockDataService {
  static final User _chefGordon = User(
    id: 'u1', 
    name: 'Gordon R.', 
    avatarUrl: 'https://i.pravatar.cc/150?u=gordon'
  );

  static final User _chefJulia = User(
    id: 'u2', 
    name: 'Julia C.', 
    avatarUrl: 'https://i.pravatar.cc/150?u=julia'
  );

  static List<Recipe> getRecipes() {
    return [
      Recipe(
        id: 'r1',
        title: 'Truffle Mushroom Risotto',
        description: 'Creamy arborio rice with black truffle oil and wild mushrooms.',
        imageUrl: 'https://images.unsplash.com/photo-1476124369491-e7addf5db371?auto=format&fit=crop&w=800&q=80',
        ingredients: ['Arborio Rice', 'Mushrooms', 'Truffle Oil', 'Parmesan', 'White Wine'],
        instructions: ['SautÃ© mushrooms', 'Toast rice', 'Add wine', 'Slowly add stock', 'Finish with cheese'],
        type: DishType.dinner,
        chef: _chefGordon,
        rating: 4.8,
        reviewsCount: 120,
        isPremium: true,
      ),
      Recipe(
        id: 'r2',
        title: 'Avocado Toast with Poached Egg',
        description: 'Sourdough bread topped with smashed avocado and a perfectly poached egg.',
        imageUrl: 'https://images.unsplash.com/photo-1525351460165-75430ca4b1cb?auto=format&fit=crop&w=800&q=80',
        ingredients: ['Sourdough', 'Avocado', 'Egg', 'Chili Flakes'],
        instructions: ['Toast bread', 'Poach egg', 'Assemble'],
        type: DishType.breakfast,
        chef: _chefJulia,
        rating: 4.5,
        reviewsCount: 85,
      ),
       Recipe(
        id: 'r3',
        title: 'Grilled Salmon with Asparagus',
        description: 'Fresh salmon fillet grilled to perfection served with roasted asparagus.',
        imageUrl: 'https://images.unsplash.com/photo-1467003909585-2f8a7270028d?auto=format&fit=crop&w=800&q=80',
        ingredients: ['Salmon', 'Asparagus', 'Lemon', 'Olive Oil'],
        instructions: ['Season salmon', 'Grill for 10 mins', 'Roast asparagus'],
        type: DishType.lunch,
        chef: _chefGordon,
        rating: 4.9,
        reviewsCount: 200,
        isPremium: true,
      ),
      Recipe(
        id: 'r4',
        title: 'Berry Smoothie Bowl',
        description: 'A refreshing mix of mixed berries, banana, and yogurt.',
        imageUrl: 'https://images.unsplash.com/photo-1557799552-27a739a04a65?auto=format&fit=crop&w=800&q=80',
        ingredients: ['Berries', 'Banana', 'Yogurt', 'Granola'],
        instructions: ['Blend fruits', 'Pour into bowl', 'Top with granola'],
        type: DishType.breakfast,
        chef: _chefJulia,
        rating: 4.2,
        reviewsCount: 45,
      ),
    ];
  }

  static List<Menu> getMenus() {
    final recipes = getRecipes();
    return [
      Menu(
        id: 'm1',
        title: 'Weekend Brunch Special',
        description: 'The perfect collection for a lazy Sunday morning.',
        recipes: [recipes[1], recipes[3]],
        imageUrl: 'https://images.unsplash.com/photo-1533089862017-ec329abb070e?auto=format&fit=crop&w=800&q=80',
      ),
      Menu(
        id: 'm2',
        title: 'Elegant Dinner Date',
        description: 'Impress your significant other with these fine dining dishes.',
        recipes: [recipes[0], recipes[2]],
        imageUrl: 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?auto=format&fit=crop&w=800&q=80',
      ),
    ];
  }
}
