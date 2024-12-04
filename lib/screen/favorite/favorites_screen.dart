import 'package:flutter/material.dart';
import '../../models/hymn.dart';
import '../../services/hymn_service.dart';
import '../hymn/hymn_detail_screen.dart';

class FavoritesPage extends StatelessWidget {
  final HymnService _hymnService = HymnService();

  FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.hintColor;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Tiana',
            style: TextStyle(color: textColor)),
      ),
      body: StreamBuilder<List<Hymn>>(
        stream: _hymnService.getFavoriteHymnsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Olana: ${snapshot.error}',
                    style: TextStyle(color: textColor)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text('Mbola tsy misy hira tiana',
                    style: TextStyle(color: textColor)));
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
                      border: Border.all(
                          color: textColor.withOpacity(0.5)),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: theme.dividerColor,
                        child: Text(
                          hymn.hymnNumber,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        hymn.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      ),
                      trailing: StreamBuilder<List<String>>(
                        stream: _hymnService.getFavoriteHymnIdsStream(),
                        builder: (context, favoriteSnapshot) {
                          final isFavorite = favoriteSnapshot.data?.contains(hymn.id) ?? false;
                          return IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : textColor,
                            ),
                            onPressed: () {
                              _hymnService.toggleFavorite(hymn);
                            },
                          );
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
