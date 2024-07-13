import 'package:flutter/material.dart';

import '../../utility/screen_util.dart';

class MembeScreen extends StatelessWidget {
  // final MemberController _memberController = Get.put(MemberController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  MembeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: textColor,
          ),
          onPressed: () {
            openDrawer(context);
          },
        ),
        title: Text(
          'Membres',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ),
      body: const Column(
        children: [
          /**
              Expanded(
              child: Obx(
              () {
              if (_memberController.isLoading.value) {
              return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
              color: Theme.of(context).primaryColor,
              size: 50,
              ),
              );
              } else if (_memberController.members.isEmpty) {
              return const Center(
              child: Text('Aucun membre trouvé'),
              );
              } else {
              return ListView.builder(
              itemCount: _memberController.members.length,
              itemBuilder: (context, index) {
              final member = _memberController.members[index];
              final imageName = 'member_${member['id']}.jpg';
              return ListTile(
              leading: FutureBuilder<Image?>(
              future:
              _memberController.loadImageFromStorage(imageName),
              builder: (context, imageSnapshot) {
              if (imageSnapshot.connectionState ==
              ConnectionState.waiting) {
              return const CircularProgressIndicator();
              } else if (imageSnapshot.hasError) {
              return const CircleAvatar(
              child: Icon(Icons.error),
              );
              } else if (imageSnapshot.hasData &&
              imageSnapshot.data != null) {
              return CircleAvatar(
              backgroundImage: imageSnapshot.data!.image,
              );
              } else {
              return const CircleAvatar(
              child: Icon(Icons.person),
              );
              }
              },
              ),
              title: Text(member['name']),
              );
              },
              );
              }
              },
              ),
              ),
           **/
        ],
      ),
    );
  }
}
