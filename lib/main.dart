import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopinglist/firebase_options.dart';
import 'package:shopinglist/pages/splash_page.dart';
import 'package:shopinglist/routes/page_routes.dart';
import 'package:shopinglist/screens/login_page.dart';
import 'package:shopinglist/screens/shopinglist.dart';


void main ()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Shopinglist());
}

class Shopinglist extends StatelessWidget {
  const Shopinglist({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoping List App',
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          color: Colors.grey [600],

        ),
        textTheme:const TextTheme(
          bodyLarge: TextStyle( color: Colors.yellow),
          bodyMedium: TextStyle(color: Colors.yellow),
          bodySmall: TextStyle( color: Colors.yellow),
          titleLarge: TextStyle(color: Colors.orange),
          titleMedium: TextStyle( color: Colors.orange),
          titleSmall: TextStyle( color: Colors.orange),
        ),
         inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.black.withOpacity(0.4),  
          hintStyle: const TextStyle(color: Colors.yellow),

          labelStyle: const TextStyle(color: Colors.yellow),
          border: const OutlineInputBorder(),
          errorStyle: const TextStyle(color : Colors.orange),
          counterStyle: const TextStyle(color : Colors.orange, fontSize: 12),
        )
      ),
      routes: {
        PageRoutes.loginPage: (context)=>LoginPage(),
        PageRoutes.shopinglistPage: (context)=>ShopinglistPage(),
      },
    );
  }
}
