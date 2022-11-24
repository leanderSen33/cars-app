import 'package:cars_app/views/password_page.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';

import 'package:cars_app/services/auth/auth_service.dart';
import 'package:cars_app/services/sorage/storage_service.dart';

import '../models/user.dart';
import '../models/user_preferences.dart';
import '../services/database/firestore.dart';
import '../widgets/build_appbar.dart';
import '../widgets/dialogs.dart';
import '../widgets/profile_widget.dart';

enum PhotoMethod { camera, gallery }

class ProfileView extends StatefulWidget {
  const ProfileView({
    Key? key,
    required this.firestore,
  }) : super(key: key);

  final Firestore firestore;

  static Future<void> show(BuildContext context) async {
    final database = Provider.of<Firestore>(context, listen: false);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProfileView(
          firestore: database,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final storage = StorageService();
  final _auth = AuthService.firebase();
  bool _isCameraMethodPreferred = false;

  @override
  Widget build(BuildContext context) {
    const user = UserPreferences2.myUser;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              onClicked: changePhoto,
            ),
            const SizedBox(height: 24),
            buildName(user),
            const SizedBox(height: 48),
            buildAbout(user),
            const SizedBox(
              height: 45,
            ),
            TextButton(
              onPressed: () => PasswordPage.show(context),
              child: const Text('Change password'),
            ),
            TextButton(
              onPressed: () async {
                final shouldLogOut = await showLogOutDialog(context);
                if (shouldLogOut) {
                  await AuthService.firebase().logOut();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAbout(User user) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.about,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            '${AuthService.firebase().currentUser?.email}',
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  void changePhoto() async {
    var buttonWasPressed = false;
    await Dialogs.materialDialog(
        msg: 'Upload image from:',
        color: Colors.white,
        context: context,
        actions: [
          IconsOutlineButton(
            onPressed: () {
              selectPhotoMethod(PhotoMethod.gallery);
              buttonWasPressed = true;
              Navigator.pop(context);
            },
            text: 'file',
            iconData: Icons.folder,
            textStyle: const TextStyle(color: Colors.grey),
            iconColor: Colors.grey,
          ),
          IconsOutlineButton(
            onPressed: () {
              selectPhotoMethod(PhotoMethod.camera);
              buttonWasPressed = true;
              Navigator.pop(context);
            },
            text: 'camera',
            iconData: Icons.camera_alt,
            // color: Colors.red,
            textStyle: const TextStyle(color: Colors.grey),
            iconColor: Colors.grey,
          ),
        ]);

    buttonWasPressed
        ? await storage.changeProfilePhoto(context, _isCameraMethodPreferred)
        : null;
    setState(() {});
  }

  void selectPhotoMethod(PhotoMethod method) {
    if (method == PhotoMethod.camera) {
      setState(() {
        _isCameraMethodPreferred = true;
        setPhotoMethod(widget.firestore);
      });
    } else {
      setState(() {
        _isCameraMethodPreferred = false;
        setPhotoMethod(widget.firestore);
      });
    }
  }

  void setPhotoMethod(Firestore firestore) {
    final userPreference = UserPreferences(
        id: _auth.currentUser!.id, preferCamera: _isCameraMethodPreferred);
    firestore.setPreferredPhotoMethod(userPreference);
  }
}

void selectPhotoMethod(PhotoMethod gallery) {}

class UserPreferences2 {
  static const myUser = User(
    name: 'Test User',
    email: 'sarah.abs@gmail.com',
    about:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras id sagittis nulla. Nam hendrerit egestas velit eu porttitor. Suspendisse lacus metus, pulvinar eu nunc vel, commodo rhoncus justo. Cras ut scelerisque felis. Vestibulum maximus euismod arcu, vitae lobortis tellus efficitur.',
    isDarkMode: false,
  );
}
