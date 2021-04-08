import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:social/api%20services/api_services.dart';
import 'package:social/country.dart';
import 'package:social/my_flutter_app_icons.dart';
import 'package:social/timeZone.dart';
import 'package:social/models/user.dart';
import './widgets.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _fromState = GlobalKey<FormState>();

  List data;
  List<TimeZone> times = [];
  TimeZone selectedTime;

  String countryCode = "+374";

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/timezones.json');
    var res = json.decode(jsonText);
    times = (res as List).map((e) => TimeZone.fromJson(e)).toList();
  }

  String email;
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    loadJsonData();

    super.initState();
  }

  void onSave() {
    if (_fromState.currentState.validate()) {
      _fromState.currentState.save();

      Api().auth.createUser(user: user);
    }
  }

  User user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Something"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _fromState,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                input(
                    hint: "Full name",
                    prefix: MyFlutterApp.person,
                    onSave: (v) {},
                    validator: (v) {
                      return v.length > 2 ? null : "its bad name";
                    }),
                input(
                    hint: "Email",
                    prefix: Icons.email,
                    onSave: (v) {
                      user.email = v;
                    },
                    validator: (v) {
                      return isValidEmail(v) ? null : "its bad email";
                    }),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          var res = await getContryCode(context);
                          setState(() {
                            countryCode = res.dialCode;
                          });
                        },
                        child: input(
                          controller: TextEditingController(text: countryCode),
                          prefix: MyFlutterApp.local_phone,
                          enabled: false,
                          suffix: Icons.arrow_drop_down_rounded,
                        ),
                      ),
                    ),
                    Expanded(
                      child: input(
                          hint: "Phone Number",
                          showPrefix: false,
                          type: TextInputType.number,
                          formatters: [FilteringTextInputFormatter.digitsOnly]),
                    ),
                  ],
                ),
                input(
                    hint: "Create password",
                    prefix: MyFlutterApp.key,
                    controller: passwordController),
                input(
                    hint: "Repeat password",
                    prefix: MyFlutterApp.key,
                    onSave: (v) {},
                    validator: (v) {
                      return v == passwordController.text
                          ? null
                          : "password doest't match";
                    }),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: onSave,
                  color: Colors.pink,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text("Sign Up"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<TimeZone> timeZonesBottomSheet(
      {List<TimeZone> times, BuildContext context}) async {
    var res = await showModalBottomSheet(
        context: context,
        builder: (c) => Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView.builder(
                itemBuilder: (c, i) => ListTile(
                  title: Text(times[i].value),
                  onTap: () => Navigator.of(context).pop(times[i]),
                ),
                itemCount: times.length,
              ),
            ));

    return res;
  }

  Future<CountryAndFlags> getContryCode(BuildContext context) async {
    var res = await showModalBottomSheet(
      context: context,
      builder: (c) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: ListView.builder(
          itemBuilder: (c, i) => ListTile(
            title: Text(CountryAndFlags.countries[i].name),
            onTap: () {
              Navigator.of(context).pop(CountryAndFlags.countries[i]);
            },
          ),
          itemCount: CountryAndFlags.countries.length,
        ),
      ),
    );
    return res;
  }

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}
