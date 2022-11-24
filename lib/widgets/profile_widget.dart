import 'package:flutter/material.dart';

import '../services/sorage/storage_service.dart';

class ProfileWidget extends StatelessWidget {
  // final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    // required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    final storage = StorageService();

    return Center(
      child: Stack(
        children: [
          FutureBuilder<String?>(
            future: storage.getPhotoProfileURL(),
            builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 80,
                  width: 80,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black26,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.black,
                    ),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Avatar(
                    snapshot: snapshot.data!,
                    onPressed: onClicked,
                  );
                } else {
                  return const CircleAvatar(
                    radius: 70.0,
                    backgroundImage:
                        AssetImage('assets/avatar_placeholder.png'),
                  );
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: InkWell(
            onTap: onClicked,
            child: const Icon(
              Icons.add_a_photo,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

class Avatar extends StatelessWidget {
  const Avatar({
    required this.snapshot,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String snapshot;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 70.0,
      backgroundImage: NetworkImage(snapshot),
    );
  }
}
