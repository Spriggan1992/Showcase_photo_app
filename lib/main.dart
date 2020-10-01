import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo/repositories/auth/auth_repository.dart';
import 'package:photo/screen/welcome_screen/welcome_screen.dart';

import 'bloc/auth/auth_bloc.dart';
import 'screen/login_screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) =>
              AuthBloc(authRepository: AuthRepository())..add(AppStarted()),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: TextTheme(
            bodyText1: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.black,
                decorationColor: Colors.black),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (_) => WelcomeScreen(),
          LoginScreen.id: (_) => LoginScreen(),
        },
      ),
    );
  }
}
