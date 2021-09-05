import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.iconData,
    required this.title,
    required this.onPressed,
    this.active,
  }) : super(key: key);

  final void Function() onPressed;
  final IconData iconData;
  final String title;
  final bool? active;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        color: (active != null && active == true)
            ? const Color(0xff636363)
            : const Color(0xff3d3d3d),
        child: ListTile(
          leading: Icon(
            iconData,
            color: Colors.white70,
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
