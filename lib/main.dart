import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xsmoke/core/view_models/choose_level_controller.dart';
import 'package:xsmoke/core/view_models/cigrates_screen_controller.dart';
import 'package:xsmoke/core/view_models/home_screen_controller.dart';
import 'package:xsmoke/core/view_models/lungshape_screen_controller.dart';
import 'package:xsmoke/views/screens/activites_screen.dart';
import 'package:xsmoke/views/screens/add_comment_screen.dart';
import 'package:xsmoke/views/screens/cigrates_screen.dart';
import 'package:xsmoke/views/screens/control_view.dart';
import 'package:xsmoke/views/screens/edit_screen.dart';
import 'package:xsmoke/views/screens/home_screen.dart';
import 'package:xsmoke/views/screens/login_screen.dart';
import 'package:xsmoke/views/screens/lungshape_screen.dart';
import 'package:xsmoke/views/screens/prefered_level_screen.dart';
import 'package:xsmoke/views/screens/readmore_screen.dart';
import 'package:xsmoke/views/screens/signup_screen.dart';
import 'package:xsmoke/views/screens/splash_screen.dart';
import 'package:xsmoke/views/widgets/menu.dart';

import 'core/view_models/comment_view_model.dart';
import 'core/view_models/edit_screen_controller.dart';
import 'core/view_models/login_controller.dart';
import 'core/view_models/profile_screen_controller.dart';
import 'core/view_models/signup_controller.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => SignUpController()),
      ChangeNotifierProvider(create: (context) => LoginController()),
      ChangeNotifierProvider(create: (context) => CigratesScreenController()),
      ChangeNotifierProvider(create: (context) => ChooseLevelController()),
      ChangeNotifierProvider(create: (context) => HomeScreenController()),
      ChangeNotifierProvider(create: (context) => EditScreenController()),
      ChangeNotifierProvider(create: (context) => AddCommentController()),
      ChangeNotifierProvider(create: (context) => ProfileScreenController()),
      ChangeNotifierProvider(create: (context) => LungShapeController()),
    ],
    child: Xsmoke(),
  ));
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class Xsmoke extends StatefulWidget {
  @override
  State<Xsmoke> createState() => _XsmokeState();
}

class _XsmokeState extends State<Xsmoke> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:
          auth.currentUser?.uid != null ? "ControlView" : "SplashScreen",
      routes: {
        "SplashScreen": (context) => SplashScreen(),
        "LoginScreen": (context) => LoginScreen(),
        "SignUpScreen": (context) => SignUpScreen(),
        "HomeScreen": (context) => HomeScreen(),
        "CigratesScreen": (context) => CigratesScreen(),
        "PrefLevel": (context) => PredferdLevelScreen(),
        "HomeScreen": (context) => HomeScreen(),
        "ControlView": (context) => ControllerView(),
        "Menu": (context) => Menu(),
        "ActivitiesScreen": (context) => ActivitiesScreen(),
        "LungShapeScreen": (context) => LungShapeScreen(),
        "ReadMoreScreen": (context) => ReadMoreScreen(),
        "EditScreen": (context) => EditScreen(),
        "AddCommentScreen": (context) => AddCommentScreen(),
      },
    );
  }
}
