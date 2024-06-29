import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FetchApi extends StatefulWidget {
  const FetchApi({Key? key}) : super(key: key);

  @override
  State<FetchApi> createState() => _FetchApiState();
}

class _FetchApiState extends State<FetchApi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des utilisateurs"),
      ),
      body: MembersList(),
    );
  }
}

class MembersList extends StatelessWidget {
  Future<List<dynamic>> fetchMembers() async {
    final response = await http
        .get(Uri.parse('https://www.permah.net/wp-json/buddypress/v1/members'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load members');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchMembers(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var member = snapshot.data![index];
              String avatarUrl = 'https:' + member['avatar_urls']['full'];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(avatarUrl),
                ),
                title: Text(member['name']),
                subtitle: Text(member['id'].toString()),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
