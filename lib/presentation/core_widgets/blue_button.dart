import 'package:flutter/material.dart';
import 'package:flutter_application/presentation/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BlueButton extends ConsumerWidget {
  const BlueButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);
  final String text;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: (MediaQuery.of(context).size.width / 5) * 4,
      height: 53,
      child: ElevatedButton(
        onPressed: () {
          watch(popPageProvider.notifier).popPageState(false);
          onPressed();
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(color: Colors.blue))),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
