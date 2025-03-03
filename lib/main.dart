import 'package:flutter/material.dart';
import 'package:maache_weather_app/pages/presets/ScheduleProvider.dart';
import 'package:maache_weather_app/pages/presets/city_provider.dart';
import 'package:maache_weather_app/pages/presets/notification_provider.dart';
import 'package:maache_weather_app/services/notif_service.dart';
import 'package:provider/provider.dart';
import 'pages/WeatherPage.dart';
import 'pages/presets/theme_provider.dart';
void main()  {
  
  // FIREBASE INITIALIZATION ----------------------------------------
 /* if (kIsWeb)
{  await Firebase.initializeApp(options: FirebaseOptions(
  apiKey: "AIzaSyBk-zBNXQN6I-wq5_hzYfP7b_qRsJMIoco",
  authDomain: "maache-weather-app.firebaseapp.com",
  projectId: "maache-weather-app",
  storageBucket: "maache-weather-app.firebasestorage.app",
  messagingSenderId: "258684727901",
  appId: "1:258684727901:web:f3a01a8d854c8f35d1d3b4",
  measurementId: "G-TVZF8KGGK9"));
  } else { await Firebase.initializeApp();}
  */
  // FIREBASE INITIALIZATION END -------------------------------------
  WidgetsFlutterBinding.ensureInitialized();
   notifService().initNotification(); // Initialize notifications
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
        ChangeNotifierProvider(create: (context) => CityProvider()),
        ChangeNotifierProvider(create: (context) => Scheduleprovider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Weatherpage(),
          theme: themeProvider.themeData,
        );
      },
    );
  }
}