import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthApi {
  static const String baseUrl = 'https://www.permah.net';
  static const String loginEndpoint = '/auth/login';
  static const String membersEndpoint = '/buddypress/v1/members';

  // Fonction pour se connecter et obtenir un token JWT
  static Future<String?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$loginEndpoint'),
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final token = jsonData[
            'token']; // Exemple de récupération du token depuis la réponse JSON
        if (token != null) {
          // Stocker le token dans SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('jwt_token', token);
          return token;
        }
      }
      return null; // Retourne null si la connexion a échoué
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Fonction pour récupérer la liste des membres
  static Future<List<dynamic>?> fetchMembers(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$membersEndpoint'),
        headers: {
          'Authorization': 'Bearer $token',
          // Ajouter le token JWT dans l'en-tête Authorization
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return jsonData[
            'members']; // Exemple de récupération des membres depuis la réponse JSON
      } else {
        print('Failed to load members');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}

class FetchApi extends StatefulWidget {
  const FetchApi({super.key});

  @override
  State<FetchApi> createState() => _FetchApiState();
}

class _FetchApiState extends State<FetchApi> {
  String? _token;
  List<dynamic>? _members;

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  // Fonction pour récupérer le token JWT depuis SharedPreferences
  void _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('jwt_token');
    });
  }

  // Fonction pour se connecter et obtenir un nouveau token
  Future<void> _login() async {
    String? token = await AuthApi.login('username', 'password');
    if (token != null) {
      setState(() {
        _token = token;
      });
    }
  }

  // Fonction pour charger les membres depuis l'API
  Future<void> _fetchMembers() async {
    if (_token != null) {
      List<dynamic>? members = await AuthApi.fetchMembers(_token!);
      if (members != null) {
        setState(() {
          _members = members;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Authentification et API Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_token == null)
              ElevatedButton(
                onPressed: _login,
                child: const Text('Se Connecter'),
              )
            else
              ElevatedButton(
                onPressed: _fetchMembers,
                child: const Text('Charger les Membres'),
              ),
            if (_members != null)
              Expanded(
                child: ListView.builder(
                  itemCount: _members!.length,
                  itemBuilder: (context, index) {
                    var member = _members![index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(member['avatar_url']),
                      ),
                      title: Text(member['name']),
                      subtitle: Text(member['id'].toString()),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
