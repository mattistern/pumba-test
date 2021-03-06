import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pumba_test/models/user_model.dart';
import 'package:pumba_test/providers/shared_pref_provider.dart';
import 'package:pumba_test/providers/user_provider.dart';
import 'package:pumba_test/screens/home_screen.dart';
import 'package:pumba_test/screens/waiting_screen.dart';
import 'package:pumba_test/widgets/gender_selection.dart';
import 'package:pumba_test/widgets/card_text_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //3 controllers for the the fields
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

  var _gender = Gender.other;

  //a form for validation
  final _formKey = GlobalKey<FormState>();

  //This provider is for managing user in Firebase.
  late UserProvider _userProvider;
  late SharedPrefProvider _prefProvider;

  ///Try to submit user registration.
  ///
  ///The text field can't be empty.
  ///The gender is initialized to Gender.other.
  Future<void> _trySubmit() async {
    var valid = _formKey.currentState!.validate();
    if (valid) {
      _formKey.currentState!.save();
      var _userModel = UserModel(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        gender: _gender,
      );

      try {
        var userId = await _userProvider.registerUser(_userModel);

        _prefProvider.setIsRegister(true);
        _prefProvider.setUserId(userId);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const HomeScreen();
            },
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
          ),
        );
      }
    }
  }

  ///Manage the gender selection.
  void _setGender(Gender gender) {
    setState(() {
      _gender = gender;
    });
  }

  //It's important to dispose all controllers to avoid memory leak.
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  bool emailValidator(String email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    _prefProvider = Provider.of<SharedPrefProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background_register.jpg'),
                  fit: BoxFit.cover),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'REGISTER',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CardTextInput(
                            controller: _firstNameController,
                            lableText: 'First Name',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please insert first name';
                              }
                              return null;
                            },
                          ),
                          CardTextInput(
                            controller: _lastNameController,
                            lableText: 'Last Name',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please insert last name';
                              }
                              return null;
                            },
                          ),
                          CardTextInput(
                            controller: _emailController,
                            textInputType: TextInputType.emailAddress,
                            lableText: 'Email',
                            validator: (value) {
                              if (!emailValidator(value as String)) {
                                return 'Please enter a valid email';
                              }

                              return null;
                            },
                          ),
                          GenderSelection(
                            selectedGender: _gender,
                            setGenderFn: _setGender,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                            child: _userProvider.isLoading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: _trySubmit,
                                    child: const Text('Register'),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
