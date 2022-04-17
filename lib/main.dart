import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pumba_test/providers/shared_pref_provider.dart';

import './providers/user_provider.dart';
import './screen_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //here we manage the providers for the app.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider<SharedPrefProvider>(
          create: (_) => SharedPrefProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Pumba Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ScreenRouter(),
      ),
    );
  }
}
