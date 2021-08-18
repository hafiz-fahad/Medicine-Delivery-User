import 'package:al_asar_user/provider/app_provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:al_asar_user/screens/home.dart';
import 'package:al_asar_user/screens/login.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'provider/user_provider.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: UserProvider.initialize()),
  ],
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Color(0xff01783e)
        ),
        home:
        SplashScreen(
            seconds: 6,
            navigateAfterSeconds: new ScreensController(),
            image: new Image.asset('images/logo.png'),
            backgroundColor: Colors.white,
//            styleTextUnderTheLoader:
//              TextStyle(
//                color: Colors.grey.withOpacity(0.5),
//                fontSize: 12,
//                fontWeight: FontWeight.bold
//            ),
            photoSize: 80.0,
            loadingText: Text("\t\t\tPowered By \n Meds @ Home",
              style: TextStyle(
                  color: Colors.grey.withOpacity(0.5),
                  fontSize: 12,
                  fontWeight: FontWeight.bold
              ),
            ),
            loaderColor: Colors.white
        ),
//        AnimatedSplashScreen(
//          duration: 2000,
//          splash: Image.asset('images/logo.png'),
//          nextScreen: ScreensController(),
//          splashTransition: SplashTransition.rotationTransition,
//          pageTransitionType: PageTransitionType.leftToRight,
//          backgroundColor: Colors.white,
//          curve: Curves.bounceInOut,
//        ),

      )));
}


class ScreensController extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch(user.status){
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Login();
      case Status.Authenticated:
        return HomePage();
      default: return Login();
    }
  }
}