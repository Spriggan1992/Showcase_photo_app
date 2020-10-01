import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo/bloc/blocks.dart';
import 'package:photo/config/paths.dart';
import 'package:photo/utils/size_config.dart';
import 'package:photo/widgets/reusable_main_btn.dart';
import 'package:photo/widgets/title_holder.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  /// Responsible for showing LogingScreen or Register screen
  final String screenIndicator;
  const LoginScreen({Key key, this.screenIndicator}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  /// Responsible for showing next Registration step with Nickname field
  bool signUpRegister = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
          if (state.isSuccess) {
            print('success');
          }
        }, builder: (context, state) {
          return _buildBody(state);
        }),
      ),
    );
  }

  Widget _buildBody(LoginState state) {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultSize * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin:
                EdgeInsets.only(top: defaultSize * 2, bottom: defaultSize * 3),
            alignment: Alignment.centerLeft,
            child: TitleHolder(
              //if screenIndicator == ''Log in' -> show Login title, else show Register title
              title:
                  widget.screenIndicator == Paths.login ? 'Log in' : 'Register',
              fontSize: defaultSize * 4,
            ),
          ),
          TextFormFieldHolder(
            hintText: !signUpRegister ? 'email' : 'nickname',
            validator: (_) =>
                !state.isEmailValid && _emailController.text.isNotEmpty
                    ? 'Invalid Email'
                    : null,
            onChange: (val) =>
                context.bloc<LoginBloc>().add(EmailChanged(email: val)),
          ),
          !signUpRegister
              ? SizedBox(height: defaultSize * 2)
              : SizedBox.shrink(),
          !signUpRegister
              ? TextFormFieldHolder(
                  hintText: 'password',
                  validator: (_) => !state.isPasswordValid &&
                          _passwordController.text.isNotEmpty
                      ? 'Password must be at least 6 characters'
                      : null,
                  onChange: (val) => context
                      .bloc<LoginBloc>()
                      .add(PasswordChanged(password: val)),
                )
              : SizedBox.shrink(),
          SizedBox(height: defaultSize * 0.5),
          // If signUpRegister == false -> show Login or Next btns, else show Signup btn
          !signUpRegister && widget.screenIndicator == Paths.register
              ? ReusableMainBtn(
                  // If  Path.login == 'register' -> show Log in btn, else show Next btn
                  title:
                      widget.screenIndicator == Paths.login ? 'Log In' : 'Next',
                  backgroundColor: Colors.black,
                  titleColor: Colors.white,
                  onTap: () {
                    signUpRegister = true;
                    setState(() {});
                  },
                )
              : ReusableMainBtn(
                  title: 'Sign up',
                  backgroundColor: Colors.black,
                  titleColor: Colors.white),
          // if signUpRegister equil to true then show RichTerxt, else show nothing
          !signUpRegister
              ? SizedBox.shrink()
              : Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "By sign up, you agree to Photo's ",
                      style: TextStyle(
                        fontSize: 15,
                      )),
                  TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.black,
                      decorationThickness: 1.5,
                    ),
                  ),
                  TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy.',
                    style: TextStyle(
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.black,
                      decorationThickness: 1.5,
                    ),
                  ),
                ])),
        ],
      ),
    );
  }
}

class TextFormFieldHolder extends StatelessWidget {
  const TextFormFieldHolder({
    Key key,
    this.hintText,
    this.validator,
    this.onChange,
  }) : super(key: key);
  final String hintText;
  final String Function(String) validator;
  final Function onChange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      validator: validator,
      autovalidate: true,
      decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(0),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(0))),
    );
  }
}
