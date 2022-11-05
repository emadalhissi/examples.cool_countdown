import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final IconData icon;
  final Function() onTap;

  const MyButton({
    required this.icon,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        margin: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: const Color(0xff60d1e7),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(
          icon,
          size: 36,
          color: const Color(0xff273f4f),
        ),
      ),
    );
  }
}
