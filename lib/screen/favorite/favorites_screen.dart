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
    final theme = Theme.of(context);
    final appBarColor = theme.dividerColor;
    final textColor = theme.hintColor;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Tiana',
            style:
                TextStyle(color: textColor)), // Apply textColor to AppBar title
      ),
      body: StreamBuilder<List<Hymn>>(
        stream: _hymnService.getFavoriteHymnsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Olana: ${snapshot.error}',
                    style: TextStyle(
                        color: textColor))); // Apply textColor to error message
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text('Mbola tsy misy hira tiana',
                    style: TextStyle(
                        color: textColor))); // Apply textColor to empty message
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
                      color: Colors.red.withOpacity(
                          0.1), // You can adjust this color if needed
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: textColor.withOpacity(
                              0.5)), // Apply textColor to border with opacity
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            appBarColor, // Apply appBarColor to CircleAvatar background
                        child: Text(
                          hymn.hymnNumber,
                          style: TextStyle(
                            color: textColor, // Apply textColor to hymn number
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        hymn.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor), // Apply textColor to title
                      ),
                      subtitle: Text(
                        'Tiana tamin\'ny: ${hymn.favoriteAddedDate}',
                        style: TextStyle(
                            color: textColor), // Apply textColor to subtitle
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          hymn.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: hymn.isFavorite
                              ? Colors.red
                              : textColor, // Apply textColor to favorite icon when not selected
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
