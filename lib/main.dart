import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kluksgram/models/user.dart' as model;
import 'package:kluksgram/providers/nav_provider.dart';
import 'package:kluksgram/providers/user_provider.dart';
import 'package:kluksgram/responsive/mobile_screen_layout.dart';
import 'package:kluksgram/responsive/responsive_layout.dart';
import 'package:kluksgram/responsive/web_screen_layout.dart';
import 'package:kluksgram/screens/login_page.dart';
import 'package:kluksgram/screens/signup_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCA3-SfXYbJ3VDQgs5NJUcKCh_S7hHwwXI",
            authDomain: "kluksgram.firebaseapp.com",
            projectId: "kluksgram",
            storageBucket: "kluksgram.appspot.com",
            messagingSenderId: "241486768382",
            appId: "1:241486768382:web:96ebfa75550fa50573ddaf"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NavProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: GoogleFonts.nunito().fontFamily,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return LoginPage();
          },
        ),
      ),
    );
  }
}
