// ignore_for_file: file_names, avoid_print
import 'package:maache_weather_app/pages/presets/ScheduleProvider.dart';
import 'package:maache_weather_app/pages/presets/city_provider.dart';
import 'package:maache_weather_app/pages/presets/notification_provider.dart';
import 'package:provider/provider.dart';
import 'presets/theme_provider.dart';
import 'WeatherPage.dart';
import 'package:flutter/material.dart';
import 'findcity.dart';
import '../services/notif_service.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isDarkMode = false;
  int id = 10;
  bool isNotificationsOn = false;
  TimeOfDay time = TimeOfDay(hour: 6, minute: 30);
  final notifService _notifService = notifService();

  @override
  void initState() {
    super.initState();
    isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isSwitched;
    isNotificationsOn = Provider.of<NotificationProvider>(context, listen: false).isNotifOn;
    time = Provider.of<Scheduleprovider>(context, listen: false).time;
    _initializeNotificationService();
  }

  Future<void> _initializeNotificationService() async {
    await _notifService.initNotification();
    print('Notification service initialized');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'A T M O S P H E R E',
          style: TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 100,
      ),
      drawer: Drawer(
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Text(
                    "A T M O S P H E R E",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ListTile(
                leading: Icon(Icons.home),
                title: Text(
                  'My City',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Weatherpage())),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.location_city),
                title: Text(
                  'Other City',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Findcity())),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(
                  'Settings',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Settings())),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            ListTile(
              contentPadding: EdgeInsets.only(left: 28, right: 40),
              leading: Icon(Icons.dark_mode_outlined),
              title: Text(
                'Dark Mode',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
              ),
              trailing: Switch(
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    if (Provider.of<ThemeProvider>(context, listen: false).isSwitched == false) {
                      isDarkMode = true;
                    } else {
                      isDarkMode = false;
                    }
                    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                    print('Dark mode toggled: $isDarkMode');
                  });
                },
              ),
            ),
            SizedBox(height: 30),
            ListTile(
              contentPadding: EdgeInsets.only(left: 28, right: 40),
              leading: Icon(Icons.notifications_active_outlined),
              title: Text(
                'Notifications',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
              ),
              trailing: Switch(
                value: isNotificationsOn,
                onChanged: (value) {
                  setState(() {
                    if (Provider.of<NotificationProvider>(context, listen: false).isNotifOn == false) {
                      isNotificationsOn = true;
                      _notifService.showNotification(id: 2022, title: 'A T M O S P H E R E', body: 'Notifications are on');
                    } else {
                      isNotificationsOn = false;
                    }
                    Provider.of<NotificationProvider>(context, listen: false).toggleNotif();
                    print('Notifications toggled: $isNotificationsOn');
                  });
                },
              ),
            ),
            SizedBox(height: 30),
            ListTile(
              contentPadding: EdgeInsets.only(left: 28, right: 40),
              leading: Icon(Icons.alarm),
              title: Text(
                'Set Time',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
              ),
              trailing: TextButton(
                onPressed: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: time,
                  );
                  if (picked != null && picked != time) {
                    setState(() {
                      time = picked;
                      Provider.of<Scheduleprovider>(context, listen: false).setscheduleTime(time);
                    });

                    final cityName = Provider.of<CityProvider>(context, listen: false).cityName;
                    final cityCondition = Provider.of<CityProvider>(context, listen: false).condition;
                    final cityTemp = Provider.of<CityProvider>(context, listen: false).temperature;

                    print('City Name: $cityName');
                    print('City Condition: $cityCondition');
                    print('City Temperature: $cityTemp');

                    await _notifService.scheduleNotification(
                      id: id + 1,
                      title: cityName,
                      body: '$cityCondition $cityTemp',
                      hour: time.hour,
                      minute: time.minute,
                    );
                    print('Scheduled notification at ${time.format(context)}');
                  }
                },
                child: Text(
                  '${time.format(context)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}