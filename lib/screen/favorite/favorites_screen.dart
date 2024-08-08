import 'package:flutter/material.dart';

import '../../models/hymn.dart';
import '../../services/hymn_service.dart';
import '../../utility/screen_util.dart';
import '../hymn/hymn_detail_screen.dart';

class FavoritesPage extends StatelessWidget {
  final HymnService _hymnService = HymnService();

  FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tiana'),
      ),
      body: StreamBuilder<List<Hymn>>(
        stream: _hymnService.getFavoriteHymnsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Olana: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Mbola tsy misy hira tiana'));
          } else {
            final favoriteHymns = snapshot.data!;
            return ListView.builder(
              itemCount: favoriteHymns.length,
              itemBuilder: (context, index) {
                final hymn = favoriteHymns[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          hymn.hymnNumber,
                          style: TextStyle(
                            color: getTextTheme(context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        hymn.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          'Napidirina tamin\'ny: ${hymn.favoriteAddedDate}'),
                      trailing: IconButton(
                        icon: Icon(
                          hymn.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: hymn.isFavorite ? Colors.red : null,
                        ),
                        onPressed: () async {
                          await _hymnService.toggleFavorite(hymn);
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HymnDetailScreen(hymn: hymn),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
