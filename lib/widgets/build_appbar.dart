import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar() {
  return AppBar(
    leading: const BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}

class BuildAppBar extends StatelessWidget {
  const BuildAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const BackButton(),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
