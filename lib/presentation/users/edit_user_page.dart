import 'package:flutter/material.dart';
import 'package:flutter_application/inherited_widgets/auth/auth_service_inherited_widget.dart';
import 'package:flutter_application/models/auth/user_entity.dart';
import 'package:flutter_application/presentation/core_widgets/textfields/email_text_form_field.dart';
import 'package:flutter_application/presentation/core_widgets/textfields/password_text_form_field.dart';
import 'package:flutter_application/presentation/home/user_data_page/user_data_view_page.dart';
import 'package:flutter_application/presentation/users/users_page.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:uuid/uuid.dart';

class EditUserPage extends StatefulWidget {
  final String userId;
  const EditUserPage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  EditUserPageState createState() {
    return EditUserPageState();
  }
}

class EditUserPageState extends State<EditUserPage>
    with TickerProviderStateMixin {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  DateTime dateOfBirth = DateTime(1995, 3, 5);
  final dateOfBirthController = TextEditingController();
  String? _chosenProgrammingLanguage;
  bool _isHobbieSelected = false;
  bool _pageLoaded = false;
  bool _isFormButtonClicked = false;
  String _selectedGenderValue = "Male";
  final _formKey = GlobalKey<FormState>();

  Map<int, String> intMonthToString = {
    1: 'January',
    2: 'February',
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "Octuber",
    11: "November",
    12: "December",
  };
  Map<String, int> stringMonthToInt = {
    'January': 1,
    'February': 2,
    'March': 3,
    'April': 4,
    'May': 5,
    'June': 6,
    'July': 7,
    'August': 8,
    'September': 9,
    'Octuber': 10,
    'November': 11,
    'December': 12,
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

  @override
  void initState() {
    //restore information from db

    dateOfBirthController.text = convertDateOfBirthToString(dateOfBirth);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    dateOfBirthController.dispose();
    super.dispose();
  }

  String convertDateOfBirthToString(DateTime dateTime) {
    return "${dateOfBirth.year.toString()} / ${intMonthToString[dateOfBirth.month.toInt()]} / ${dateOfBirth.day.toString()}";
  }

  void setLoadedToTrue() {
    setState(() {
      _pageLoaded = true;
    });
  }

  void changeFormButtonClickStatus() {
    setState(() {
      _isFormButtonClicked = true;
    });
  }

  void changeHobbiesStatues() {
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

  String convertStringListToString(List<String> listofString) {
    return listofString.join('_');
  }

  List<String> convertStringToStringList(String givenString) {
    return givenString.split('_');
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

  void makeHobbiesCheckedFromString(
    List<String> hobbiesList,
  ) {
    for (final hobby in hobbiesList) {
      if (hobbiesMap.keys.toList().contains(hobby)) {
        modifyCheckedHobbies(hobby, true);
      }
    }
  }

  DateTime convertStringDateToDateTime(String _date) {
    final List<String> yearMonthDay = _date.split('/').toList();
    final int dateYear = int.parse(yearMonthDay[0].trim());
    final int dateMonth = stringMonthToInt[yearMonthDay[1].trim()] ?? 1;
    final int dateDay = int.parse(yearMonthDay[2].trim());
    final datetime = DateTime(dateYear, dateMonth, dateDay);
    return datetime;
  }

  @override
  void didChangeDependencies() {
    if (!_pageLoaded) {
      AuthServiceInheritedWidget.of(context)
          .authLocalService
          .getUser(widget.userId)
          .then(
        (value) {
          print(convertStringToStringList(value.hobbies).toString());
          emailController.text = value.email;
          passwordController.text = value.password;
          usernameController.text = value.name;
          changeDateOfBirth(convertStringDateToDateTime(value.dateOfBirth));
          setDropdownProgrammingLanguageValue(value.programmingLanguage);
          makeHobbiesCheckedFromString(
            convertStringToStringList(value.hobbies),
          );
          setState(() {
            _selectedGenderValue = value.gender;
          });
          // dateOfBirthController.value = Date
        },
      );
      setLoadedToTrue();
    }
    super.didChangeDependencies();
  }

  void discardChangesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: const [
              Icon(Icons.delete),
              SizedBox(width: 8),
              Text('Conform discard'),
            ],
          ),
          content: const Text('Are you sure, you want to discard the changes?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        UsersPage(),
                  ),
                  (route) => false,
                );
              },
              child: const Text("Yes"),
            ),
          ],
        );
        ;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => discardChangesDialog(),
            icon: const Icon(
              Icons.arrow_back,
            )),
        title: const Text(
          "Edit user",
          style: TextStyle(color: Colors.white70),
        ),
        backgroundColor: const Color(0xff3d3d3d),
        actions: [
          TextButton(
            onPressed: () {
              changeFormButtonClickStatus();
              changeHobbiesStatues();
              changeFormButtonClickStatus();
              if (_formKey.currentState!.validate() && _isHobbieSelected) {
                AuthServiceInheritedWidget.of(context)
                    .authLocalService
                    .updateUser(
                      User(
                        id: widget.userId,
                        email: emailController.text.toString(),
                        password: passwordController.text.toString(),
                        hobbies: convertStringListToString(
                          convertMaptoCheckedKeysListString(hobbiesMap),
                        ),
                        name: usernameController.text.toString(),
                        dateOfBirth: convertDateOfBirthToString(dateOfBirth),
                        programmingLanguage: _chosenProgrammingLanguage == null
                            ? ""
                            : _chosenProgrammingLanguage!,
                        gender: _selectedGenderValue,
                      ),
                    );
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        UsersPage(),
                  ),
                );
              }
            },
            child: const Text(
              "Done",
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),

      body: WillPopScope(
        onWillPop: () async {
          bool willLeave = false;
          // show the confirm dialog
          discardChangesDialog();
          return willLeave;
        },
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text("A ${widget.userId}"),
                        const SizedBox(height: 16),
                        EmailTextFormField(
                          emailController: emailController,
                          isFormButtonClicked: _isFormButtonClicked,
                        ),
                        const SizedBox(height: 16),
                        PasswordTextFormField(
                          passwordController: passwordController,
                          isFormButtonClicked: _isFormButtonClicked,
                        ),
                        const SizedBox(height: 12.0),
                        TextFormField(
                          style: const TextStyle(fontSize: 14),
                          controller: usernameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'User name cannot be empty.';
                            } else if (value.length > 20) {
                              return 'User name must be less than 20 characters';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.person),
                            hintText: 'Enter username',
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        dateTimeField(context),
                        const SizedBox(height: 12.0),
                        programmingLanguageDropDown(),
                        const SizedBox(height: 16),
                        chooseHobbiesWidget(),
                        const SizedBox(height: 16),
                        selectGenderWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      // body: EditUserPage(
      //   userId: widget.userId,
      // ),
    );
  }

  void discardOrNotWidget() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: const [
              Icon(Icons.delete),
              SizedBox(width: 8),
              Text('Conform discard'),
            ],
          ),
          content: const Text('Are you sure, you want to discard the changes?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        UsersPage(),
                  ),
                );
              },
              child: const Text("Yes"),
            ),
          ],
        );
        ;
      },
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
                      changeHobbiesStatues(),
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

  void validateAndNaviagte(BuildContext context) {
    if (_formKey.currentState!.validate() && _isHobbieSelected) {
      AuthServiceInheritedWidget.of(context).authLocalService.insertUser(
            User(
              id: const Uuid().v1(),
              name: usernameController.text.toString(),
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
