
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../core/providers/main_provider.dart';
import '../../core/widgets/recipe_card.dart';

import '../upload/upload_screen.dart';
import '../details/recipe_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger data load if empty (or could be done in InitState)
    // final provider = Provider.of<MainProvider>(context, listen: false);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Recommender'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.cloud_upload),
            tooltip: 'Seed Mock Data',
            onPressed: () {
               final provider = Provider.of<MainProvider>(context, listen: false);
               provider.seedData();
               ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(content: Text('Seeding Database... check your Firestore!')),
               );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign Out',
            onPressed: () {
               // Simple sign out triggers stream in main.dart
               context.read<MainProvider>().signOut();
            },
          ),
        ],
      ),
      body: Consumer<MainProvider>(
        builder: (context, provider, child) {
          if (provider.recipes.isEmpty) {
             return const Center(child: CircularProgressIndicator());
          }
          
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What do you want to cook today?',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16),
                      // Horizontal Menu Categories would go here
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverMasonryGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childCount: provider.recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = provider.recipes[index];
                    return RecipeCard(
                      recipe: recipe,
                      onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (_) => RecipeDetailScreen(recipe: recipe)));
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const UploadScreen()));
        },
        label: const Text('Upload'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
