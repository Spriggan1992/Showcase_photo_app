import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo/bloc/blocks.dart';
import 'package:photo/config/paths.dart';
import 'package:photo/widgets/title_holder.dart';

import '../../widgets/reusable_main_btn.dart';
import '../screens.dart';
// import 'package:flutter_svg/svg.dart';

class WelcomeScreen extends StatelessWidget {
  static String id = 'welcome_screen';
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
            body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/background.jpg'),
                              fit: BoxFit.cover))),
                  Align(
                      alignment: Alignment.center,
                      child: TitleHolder(
                        title: 'photo',
                        fontSize: 50,
                      )),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ReusableMainBtn(
                  title: 'Log In',
                  titleColor: Colors.black,
                  backgroundColor: Colors.white,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LoginScreen(screenIndicator: Paths.login))),
                ),
                ReusableMainBtn(
                  title: 'register',
                  titleColor: Colors.white,
                  backgroundColor: Colors.black,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LoginScreen(screenIndicator: Paths.register))),
                ),
              ],
            )
          ],
        ));
      },
    );
  }
}
