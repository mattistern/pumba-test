import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pumba_test/models/user_model.dart';
import 'package:pumba_test/providers/shared_pref_provider.dart';
import 'package:pumba_test/providers/user_provider.dart';
import 'package:pumba_test/screens/home_screen.dart';
import 'package:pumba_test/widgets/gender_selection.dart';
import '../widgets/card_text_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  var _gender = Gender.other;

  final _formKey = GlobalKey<FormState>();

  late UserProvider _userProvider;

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
        _userProvider.registerUser(_userModel);
        Provider.of<SharedPrefProvider>(
          context,
          listen: false,
        ).setIsRegister(true);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomeScreen();
            },
          ),
        );
      } catch (e) {
        print('Error Accured!');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
          ),
        );
      }
    }
  }

  void _setGender(Gender gender) {
    setState(() {
      _gender = gender;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Register!!',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
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
                      lableText: 'Email',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please insert email';
                        }
                        return null;
                      },
                    ),
                    GenderSelection(
                      selectedGender: _gender,
                      setGenderFn: _setGender,
                    ),
                    const SizedBox(
                      height: 20,
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
    );
  }
}