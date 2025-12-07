
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../models/data_models.dart';
import '../../core/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(recipe.title, 
                style: GoogleFonts.playfairDisplay(
                  textStyle: TextStyle(
                    color: Colors.white,
                    shadows: [Shadow(color: Colors.black.withValues(alpha: 0.8), blurRadius: 8)],
                  ),
                ),
              ),
              background: Hero(
                tag: 'recipe_${recipe.id}',
                child: CachedNetworkImage(
                  imageUrl: recipe.imageUrl,
                  fit: BoxFit.cover,
                  color: Colors.black.withValues(alpha: 0.2),
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Row(
                           children: [
                             CircleAvatar(
                               backgroundImage: NetworkImage(recipe.chef.avatarUrl),
                             ),
                             const SizedBox(width: 8),
                             Text('By ${recipe.chef.name}', style: Theme.of(context).textTheme.titleMedium),
                           ],
                         ),
                         RatingBarIndicator(
                            rating: recipe.rating,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: AppColors.accentOrange,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(recipe.description, style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 24),
                    const Divider(),
                    _buildSectionTitle(context, 'Ingredients'),
                    ...recipe.ingredients.map((ing) => _buildListItem(ing)),
                    const SizedBox(height: 24),
                    _buildSectionTitle(context, 'Instructions'),
                    ...recipe.instructions.map((inst) => _buildListItem(inst, icon: Icons.arrow_right)),
                    const SizedBox(height: 24),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {}, 
                        icon: const Icon(Icons.favorite_border), 
                        label: const Text('Save to Favorites'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentOrange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    _buildSectionTitle(context, 'Reviews'),
                    // Mock reviews for now
                    _buildReviewItem('Jane Doe', 5, 'Absolutely delicious! The truffle oil makes it.'),
                    _buildReviewItem('John Smith', 4, 'Great recipe but took longer than expected.'),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          color: AppColors.accentOrange,
          fontSize: 24,
        ),
      ),
    );
  }

  Widget _buildListItem(String text, {IconData icon = Icons.circle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: icon == Icons.circle ? 8 : 20, color: AppColors.accentGreen),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16, height: 1.5))),
        ],
      ),
    );
  }

  Widget _buildReviewItem(String name, double rating, String comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              RatingBarIndicator(
                rating: rating,
                itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                itemCount: 5,
                itemSize: 14.0,
                direction: Axis.horizontal,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(comment, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
