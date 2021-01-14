import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectcontrol_app/Iotproject_observer.dart';
import 'package:projectcontrol_app/utils/app_theme.dart';
import 'package:projectcontrol_app/bloc/bloc_authen/authentication_bloc.dart';
import 'package:projectcontrol_app/view/screen/Home/home.dart';
import 'package:projectcontrol_app/view/screen/Login/login_screen.dart';
import 'package:projectcontrol_app/view/screen/testz/home_view.dart';
import 'package:projectcontrol_app/view/widget/intro/widget_intro.dart';

void main() {
  Bloc.observer = IOTProjectObserver();
  return runApp(
    MyApp(),
    //  DevicePreview(builder: (context)=>MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  final authenticationBloc = AuthenticationBloc();

  @override
  Widget build(BuildContext context) {
    authenticationBloc.add(AppIntro());
    return MaterialApp(
      // builder: DevicePreview.appBuilder,
      // locale: DevicePreview.locale(context),
      home: BlocListener<AuthenticationBloc, AuthenticationState>(
        cubit: authenticationBloc,
        listener: (context, AuthenticationState state) {
          if (state is AppIntroState) {
            return Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => WidgetIntro(
                        authenticationBloc: authenticationBloc,
                      )),
            );
          } else if (state is LoginSucessState) {
            return Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen()),
                (Route<dynamic> route) => false);
          } else if (state is LogoutState) {
            return Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()),
                (Route<dynamic> route) => false);
          }
        },
        child: LoginScreen(),
      ),
      title: 'Project Control',
      theme: AppTheme.darkMode,
    );
  }
}

// class MainPage extends StatefulWidget {
//   @override
//   _MainPageState createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   SharedPreferences sharedPreferences;
//   @override
//   void initState() {
//     checkLoginStatus();
//     super.initState();
//   }

//   checkLoginStatus() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     // sharedPreferences.clear();
//     // sharedPreferences.commit();
//     if (sharedPreferences.getBool('remember_me') == true) {
//       if (sharedPreferences.getString("token") != null) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (BuildContext context) => HomeScreen(0)),
//         );
//       }
//     } else {
//       Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
//           (Route<dynamic> route) => false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: null,
//     );
//   }
// }
