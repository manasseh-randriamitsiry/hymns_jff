import 'package:flutter/material.dart';

import '../../widgets/drawerWidget.dart';

class MembeScreen extends StatelessWidget {
  // final MemberController _memberController = Get.put(MemberController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  MembeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: Text(
          'Membres',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      body: Column(
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
