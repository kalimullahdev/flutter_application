import 'package:flutter/material.dart';

Widget signUpWithGoogle(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(8),
    width: (MediaQuery.of(context).size.width / 5) * 4,
    height: 55,
    child: ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: const BorderSide(color: Colors.blue))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Icon(
            Icons.ac_unit,
            color: Colors.blue,
          ),
          Text(
            "Sign Up with Google",
            style: TextStyle(color: Colors.blue),
          ),
        ],
      ),
    ),
  );
}
