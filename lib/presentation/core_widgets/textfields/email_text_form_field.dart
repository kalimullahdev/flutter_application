import 'package:flutter/material.dart';

class EmailTextFormField extends StatefulWidget {
  const EmailTextFormField({
    Key? key,
    required this.emailController,
    required this.isFormButtonClicked,
  }) : super(key: key);

  final TextEditingController emailController;
  final bool isFormButtonClicked;
  @override
  _EmailTextFormFieldState createState() => _EmailTextFormFieldState();
}

class _EmailTextFormFieldState extends State<EmailTextFormField> {
  final bool _isValid = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.emailController,
      onChanged: (value) {},
      autovalidateMode: widget.isFormButtonClicked
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      validator: (value) {
        final bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(widget.emailController.text);
        if (value == null || value.isEmpty) {
          // _changeValidation(validationValue: false);
          return 'Email cannot be empty';
        } else if (!emailValid) {
          // _changeValidation(validationValue: false);
          return 'Email is not valid.';
        }
        // _changeValidation(validationValue: true);
        return null;
      },
      style: const TextStyle(fontSize: 14),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        suffixIcon: Icon(_isValid ? Icons.mail : Icons.error),
        hintText: 'Enter email address ',
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
  }
}
