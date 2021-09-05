import 'package:flutter/material.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    Key? key,
    required this.passwordController,
    required this.isFormButtonClicked,
  }) : super(key: key);

  final bool isFormButtonClicked;
  final TextEditingController passwordController;
  @override
  _PasswordTextFormFieldState createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool visiblePassword = false;

  void togglePassword() {
    setState(() {
      visiblePassword = !visiblePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !visiblePassword,
      style: const TextStyle(fontSize: 14),
      controller: widget.passwordController,
      autovalidateMode: widget.isFormButtonClicked
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      validator: (value) {
        if (value == null || value.isEmpty) {
          // _changeValidation(validationStatus: false);
          return 'password cannot be empty.';
        } else if (value.length < 8) {
          // _changeValidation(validationStatus: false);
          return 'password must be greater than 8 characters';
        }
        // _changeValidation(validationStatus: true);
        return null;
      },
      decoration: InputDecoration(
        suffixIcon: IconButton(
            onPressed: () => togglePassword(),
            icon: const Icon(Icons.visibility)),
        hintText: 'Enter password',
        filled: true,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
  }
}
