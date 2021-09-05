import 'package:flutter/material.dart';
import 'package:flutter_application/inherited_widgets/auth/auth_service_inherited_widget.dart';
import 'package:flutter_application/models/auth/user_entity.dart';
import 'package:flutter_application/presentation/core_widgets/blue_button.dart';
import 'package:flutter_application/presentation/core_widgets/custom_logo.dart';
import 'package:flutter_application/presentation/core_widgets/textfields/already_have_account.dart';
import 'package:flutter_application/presentation/core_widgets/textfields/email_text_form_field.dart';
import 'package:flutter_application/presentation/core_widgets/textfields/password_text_form_field.dart';
import 'package:flutter_application/presentation/core_widgets/textfields/sign_up_with_google.dart';
import 'package:flutter_application/presentation/home/user_data_page/user_data_view_page.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:uuid/uuid.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Register",
          style: TextStyle(color: Colors.white70),
        ),
        backgroundColor: const Color(0xff3d3d3d),
        elevation: 0,
      ),
      body: const RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm>
    with TickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  DateTime dateOfBirth = DateTime(1995, 3, 5);
  final dateOfBirthController = TextEditingController();
  String? _chosenProgrammingLanguage;
  bool _isHobbieSelected = false;
  bool _isFormButtonClicked = false;
  String _selectedGenderValue = "Male";
  final _formKey = GlobalKey<FormState>();
  bool _termAndConditionsChecked = false;
  //states variables for animations
  bool _startEmailAnimation = false;
  bool _startPasswordAnimation = false;
  bool _startDateAnimation = false;
  bool _startProgrammingAnimation = false;
  bool _startHobbiesAnimation = false;
  bool _startGenderAnimation = false;

  Map<int, String> intDateToString = {
    1: 'January ',
    2: 'February ',
    3: "March ",
    4: "April",
    5: "May",
    6: "June ",
    7: "July",
    8: "August",
    9: "September",
    10: "Octuber",
    11: "November",
    12: "December",
  };
  Map<String, bool> hobbiesMap = {
    'Photography': false,
    'Writing': false,
    'Cooking': false,
  };

  List<String> programmingLanguagesList = <String>[
    'Android',
    'IOS',
    'Flutter',
    'Node',
    'Java',
    'Python',
    'PHP',
  ];

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

  late final AnimationController _slideTransitionForDateController =
      AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();
  late final Animation<Offset> _slideTransitionForDateAnimation = Tween<Offset>(
    begin: const Offset(1.5, 0.0),
    end: Offset.zero,
  ).animate(_slideTransitionForDateController);

  late final AnimationController _rotationTransitionForProgrammingController =
      AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();

  late final AnimationController _fadeTransitionForHobbiesController =
      AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();

  late final AnimationController _slideTransitionForGenderController =
      AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();
  late final Animation<Offset> _slideTransitionForGenderAnimation =
      Tween<Offset>(
    begin: const Offset(-1.5, 0.0),
    end: Offset.zero,
  ).animate(_slideTransitionForGenderController);

  @override
  void initState() {
    dateOfBirthController.text = convertDateOfBirthToString(dateOfBirth);
    Future.delayed(
      const Duration(seconds: 1),
      () => {
        setState(() {
          _startEmailAnimation = true;
        }),
      },
    );

    Future.delayed(
      const Duration(seconds: 5),
      () => {
        setState(() {
          _startPasswordAnimation = true;
        }),
      },
    );

    Future.delayed(
      const Duration(seconds: 7),
      () => {
        setState(() {
          _startDateAnimation = true;
        }),
      },
    );

    Future.delayed(
      const Duration(seconds: 9),
      () => {
        setState(() {
          _startProgrammingAnimation = true;
        }),
      },
    );
    Future.delayed(
      const Duration(seconds: 11),
      () => {
        setState(() {
          _startHobbiesAnimation = true;
        }),
      },
    );

    Future.delayed(
      const Duration(seconds: 3),
      () => {
        setState(() {
          _startGenderAnimation = true;
        }),
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    dateOfBirthController.dispose();
    _slideTransitionForEmailController.dispose();
    _scaleTransitionForPasswordController.dispose();
    _slideTransitionForDateController.dispose();
    _fadeTransitionForHobbiesController.dispose();
    _rotationTransitionForProgrammingController.dispose();
    _slideTransitionForGenderController.dispose();
    super.dispose();
  }

  String convertDateOfBirthToString(DateTime dateTime) {
    return "${dateOfBirth.year.toString()} / ${intDateToString[dateOfBirth.month.toInt()]} / ${dateOfBirth.day.toString()}";
  }

  List<String> convertMaptoCheckedKeysListString(Map<String, bool> hobbiesMap) {
    final List<String> _newHobbyList = [];
    for (final hobbyKey in hobbiesMap.keys) {
      if (hobbiesMap[hobbyKey] == true) {
        _newHobbyList.add(hobbyKey);
      }
    }
    return _newHobbyList;
  }

  void changeFormButtonClickStatus() {
    setState(() {
      _isFormButtonClicked = true;
    });
  }

  void checkHobbiesStatues() {
    setState(() {
      _isHobbieSelected = hobbiesMap.containsValue(true);
    });
  }

  void modifyCheckedHobbies(String key, bool value) {
    setState(() {
      hobbiesMap[key] = value;
    });
  }

  void setDropdownProgrammingLanguageValue(String value) {
    setState(() {
      _chosenProgrammingLanguage = value;
    });
  }

  void changeDateOfBirth(DateTime value) {
    setState(() {
      dateOfBirth = value;
      dateOfBirthController.text = convertDateOfBirthToString(dateOfBirth);
    });
  }

  void toggleTermsAndConditions() {
    setState(() {
      _termAndConditionsChecked
          ? _termAndConditionsChecked = false
          : _termAndConditionsChecked = true;
    });
  }

  String convertStringListToString(List<String> listofString) {
    return listofString.join('_');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomLogo(),
                    const SizedBox(height: 32),
                    if (_startEmailAnimation == true)
                      SlideTransition(
                        position: _slideTransitionForEmailAnimation,
                        child: EmailTextFormField(
                          emailController: emailController,
                          isFormButtonClicked: _isFormButtonClicked,
                        ),
                      ),
                    const SizedBox(height: 16),
                    TextFormField(
                      style: const TextStyle(fontSize: 14),
                      controller: usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'username cannot be empty.';
                        } else if (value.length > 20) {
                          return 'username must be less than 20 characters';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.person),
                        hintText: 'Enter username',
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
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
                    const SizedBox(height: 12.0),
                    if (_startDateAnimation == true)
                      SlideTransition(
                          position: _slideTransitionForDateAnimation,
                          child: dateTimeField(context)),
                    const SizedBox(height: 12.0),
                    if (_startProgrammingAnimation == true)
                      RotationTransition(
                        turns: _rotationTransitionForProgrammingController,
                        child: programmingLanguageDropDown(),
                      ),
                    const SizedBox(height: 16),
                    if (_startHobbiesAnimation)
                      FadeTransition(
                        opacity: _fadeTransitionForHobbiesController,
                        child: chooseHobbiesWidget(),
                      ),
                    const SizedBox(height: 16),
                    if (_startGenderAnimation)
                      SlideTransition(
                        position: _slideTransitionForGenderAnimation,
                        child: selectGenderWidget(),
                      ),
                    termsAndConditionCheckBox(context),
                    // buttonsColumn(context),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BlueButton(
                          text: "Register",
                          onPressed: () {
                            changeFormButtonClickStatus();
                            checkHobbiesStatues();
                            changeFormButtonClickStatus();
                            if (_formKey.currentState!.validate() &&
                                _isHobbieSelected &&
                                _termAndConditionsChecked) {
                              AuthServiceInheritedWidget.of(context)
                                  .authLocalService
                                  .insertUser(
                                    User(
                                      id: const Uuid().v1(),
                                      email: emailController.text.toString(),
                                      password:
                                          passwordController.text.toString(),
                                      hobbies: convertStringListToString(
                                        convertMaptoCheckedKeysListString(
                                            hobbiesMap),
                                      ),
                                      dateOfBirth: convertDateOfBirthToString(
                                          dateOfBirth),
                                      programmingLanguage:
                                          _chosenProgrammingLanguage == null
                                              ? ""
                                              : _chosenProgrammingLanguage!,
                                      gender: _selectedGenderValue,
                                      name: usernameController.text.toString(),
                                    ),
                                  );
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return const UserDataViewPage();
                                },
                              ), (route) => false);
                            }
                          },
                        ),
                        signUpWithGoogle(context),
                      ],
                    ),
                    const AlreadyHaveAccount()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget selectGenderWidget() {
    return Column(
      children: <Widget>[
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Select Gender",
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Row(
              children: [
                Radio(
                  value: "Male",
                  groupValue: _selectedGenderValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedGenderValue = value.toString();
                    });
                  },
                ),
                const Text('Male'),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: "Female",
                  groupValue: _selectedGenderValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedGenderValue = value.toString();
                    });
                  },
                ),
                const Text('Female'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget chooseHobbiesWidget() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            "Choose your hobbies",
            style: TextStyle(color: Colors.black54),
          ),
        ),
        const SizedBox(height: 8),
        Column(
          children: hobbiesMap.keys.map((String key) {
            return SizedBox(
              height: 30,
              child: Row(
                children: [
                  Checkbox(
                    value: hobbiesMap[key],
                    onChanged: (value) => {
                      modifyCheckedHobbies(key, value!),
                      checkHobbiesStatues(),
                    },
                  ),
                  Text(key),
                ],
              ),
            );
          }).toList(),
        ),
        if (_isFormButtonClicked && _isHobbieSelected == false)
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Please choose at least one hobby",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          )
      ],
    );
  }

  Widget programmingLanguageDropDown() {
    return DropdownButtonFormField<String>(
      value: _chosenProgrammingLanguage,
      isExpanded: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => value == null ? 'field required' : null,
      decoration: const InputDecoration(
        labelText: "Choose programming language",
      ),
      style: const TextStyle(color: Colors.black),
      items: programmingLanguagesList
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) => {
        setDropdownProgrammingLanguageValue(value!),
      },
    );
  }

  Widget dateTimeField(BuildContext context) {
    return TextFormField(
      showCursor: false,
      enableInteractiveSelection: false,
      controller: dateOfBirthController,
      decoration: const InputDecoration(
        labelText: "Date of birth",
        suffixIcon: Icon(Icons.calendar_today),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        DatePicker.showDatePicker(
          context,
          minTime: DateTime(1940, 3, 5),
          maxTime: DateTime.now(),
          onConfirm: (date) {
            changeDateOfBirth(date);
          },
          onChanged: (date) {
            changeDateOfBirth(date);
          },
          currentTime: dateOfBirth,
        );
      },
    );
  }

  Widget termsAndConditionCheckBox(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              value: _termAndConditionsChecked,
              onChanged: (value) => toggleTermsAndConditions(),
            ),
            SizedBox(
              width: (MediaQuery.of(context).size.width / 5) * 3,
              child: Text(
                "I agree to the terms & conditions and privacy policy",
                maxLines: 2,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ],
        ),
        if (_isFormButtonClicked && _termAndConditionsChecked == false)
          const Padding(
            padding: EdgeInsets.fromLTRB(12, 0, 0, 12),
            child: Text(
              "Please the box to proceed .",
              style: TextStyle(color: Colors.red),
            ),
          )
      ],
    );
  }

  void validateAndNaviagte(BuildContext context) {
    if (_formKey.currentState!.validate() &&
        _isHobbieSelected &&
        _termAndConditionsChecked) {
      AuthServiceInheritedWidget.of(context).authLocalService.insertUser(
            User(
              id: const Uuid().v1(),
              email: emailController.text.toString(),
              password: passwordController.text.toString(),
              hobbies: convertStringListToString(
                convertMaptoCheckedKeysListString(hobbiesMap),
              ),
              dateOfBirth: convertDateOfBirthToString(dateOfBirth),
              programmingLanguage: _chosenProgrammingLanguage == null
                  ? ""
                  : _chosenProgrammingLanguage!,
              gender: _selectedGenderValue,
              name: usernameController.text.toLowerCase().toString(),
            ),
          );
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return const UserDataViewPage();
        },
      ), (route) => false);
    }
  }
}
