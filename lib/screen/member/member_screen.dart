import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permah_flutter/drawer.dart';

import '../../controller/member_controller.dart';

class MembersScreen extends StatelessWidget {
  final MemberController _memberController = Get.put(MemberController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  MembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerScreen(),
      appBar: AppBar(
        title: const Text('Membres'),
        leading: IconButton(
          icon: const Icon(Icons.list_rounded),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      body: Obx(() {
        if (_memberController.isLoading.value) {
          return Center(
            child: Column(
              textDirection: TextDirection.ltr,
              children: [
                SizedBox(
                  height: 100,
                ),
                Text(
                  "En attente de connection ",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                LoadingAnimationWidget.newtonCradle(
                    color: Colors.orange, size: 100),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        } else if (_memberController.members.isEmpty) {
          return const Center(child: Text('No members found.'));
        } else {
          return ListView.builder(
            itemCount: _memberController.members.length,
            itemBuilder: (context, index) {
              var member = _memberController.members[index];
              String avatarUrl = 'https:' + member['avatar_urls']['full'];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(avatarUrl),
                ),
                title: Text(member['name'] ?? 'No name'),
                subtitle: Text(member['email'] ?? 'No email'),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _memberController.fetchMembers(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
