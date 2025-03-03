import 'package:flutter/material.dart';
import 'Settings.dart';
import 'WeatherPage.dart';
import 'WeatherPage2.dart';

class Findcity extends StatefulWidget {
  const Findcity({super.key});

  @override
  State<Findcity> createState() => _FindcityState();
}

class _FindcityState extends State<Findcity> {
  String cityName = ''; // Initialize cityName with an empty string
  final _formkey = GlobalKey<FormState>();
  final _cityNameController = TextEditingController();

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
              )),
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                'My City',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Weatherpage())),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.location_city),
              title: Text(
                'Other City',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
              onTap: () => Navigator.pop(context),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Settings())),
            )
          ],
        )),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: _cityNameController,
                        decoration: InputDecoration(
                          labelText: 'Enter City Name',
                          border: OutlineInputBorder(),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a city name';
                          }
                          return null;
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            cityName = _cityNameController.text;
                          });
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Weatherpage2(
                                    cityName: cityName,
                                  )));
                        }
                      },
                      child: Text('Search'),
                    ),
                    SizedBox(
                      height: 450,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
