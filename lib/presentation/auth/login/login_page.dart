import 'package:flutter/material.dart';
import 'package:flutter_application/page_animations/scale_route.dart';
import 'package:flutter_application/presentation/auth/login/widgets/donot_have_account_widget.dart';
import 'package:flutter_application/presentation/core_widgets/blue_button.dart';
import 'package:flutter_application/presentation/core_widgets/custom_logo.dart';
import 'package:flutter_application/presentation/core_widgets/textfields/email_text_form_field.dart';
import 'package:flutter_application/presentation/core_widgets/textfields/password_text_form_field.dart';
import 'package:flutter_application/presentation/home/home_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> with TickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool progressIndicatorStatus = false;
  bool rememberMeCheckBox = false;
  bool _isFormButtonClicked = false;
  bool _startEmailAnimation = false;
  bool _startPasswordAnimation = false;

  late final AnimationController _slideTransitionForEmailController =
      AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();
  late final Animation<Offset> _slideTransitionForEmailAnimation =
      Tween<Offset>(
    begin: const Offset(1.5, 0.0),
    end: Offset.zero,
  ).animate(_slideTransitionForEmailController);

  late final AnimationController _scaleTransitionForPasswordController =
      AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 1),
      () => {
        setState(() {
          _startEmailAnimation = true;
        }),
      },
    );

    Future.delayed(
      const Duration(seconds: 3),
      () => {
        setState(() {
          _startPasswordAnimation = true;
        }),
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _slideTransitionForEmailController.dispose();
    _scaleTransitionForPasswordController.dispose();
    super.dispose();
  }

  void changeFormButtonClickStatus() {
    setState(() {
      _isFormButtonClicked = true;
    });
  }

  void showProgressIndicator() {
    setState(() {
      progressIndicatorStatus = true;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomLogo(),
                    const SizedBox(height: 24),
                    if (_startEmailAnimation == true)
                      SlideTransition(
                        position: _slideTransitionForEmailAnimation,
                        child: EmailTextFormField(
                          emailController: emailController,
                          isFormButtonClicked: _isFormButtonClicked,
                        ),
                      ),
                    const SizedBox(height: 16),
                    if (_startPasswordAnimation == true)
                      ScaleTransition(
                        scale: _scaleTransitionForPasswordController,
                        child: PasswordTextFormField(
                          passwordController: passwordController,
                          isFormButtonClicked: _isFormButtonClicked,
                        ),
                      ),
                    rememberMeAndForgetPasswordWidget(),
                    const SizedBox(height: 8.0),
                    BlueButton(
                      text: "Login",
                      onPressed: () async {
                        changeFormButtonClickStatus();
                        if (_formKey.currentState!.validate()) {
                          showProgressIndicator();
                          await Future.delayed(const Duration(seconds: 1));
                          // ignore: use_build_context_synchronously
                          Navigator.pushAndRemoveUntil(
                            context,
                            ScaleRoute(page: HomePage()),
                            (route) => false,
                          );
                        }
                      },
                    ),
                    const DonotHaveAccountWidget(),
                    if (progressIndicatorStatus == true)
                      const LinearProgressIndicator(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget rememberMeAndForgetPasswordWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: rememberMeCheckBox,
              onChanged: (value) => {
                setState(() {
                  rememberMeCheckBox = !rememberMeCheckBox;
                })
              },
            ),
            const Text("Remember me"),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Forget password?",
          ),
        )
      ],
    );
  }
}
