import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  // main part
  int secs = 0, mins = 0, hrs = 0;
  String displaySecs = "00", displayMins = "00", displayHrs = "00";
  Timer? timer;
  bool letStart = false;
  List laps = [];

  // stop function
  void pause() {
    timer!.cancel();
    setState(() {
      letStart = false;
    });
  }

  // reset function
  void reset() {
    timer!.cancel();
    setState(() {
      secs = 0;
      mins = 0;
      hrs = 0;
      displaySecs = "00";
      displayMins = "00";
      displayHrs = "00";

      letStart = false;
      laps.clear();
    });
  }

  // adding laps
  void addLaps() {
    String lap = "${displayHrs}:${displayMins}:${displaySecs}";
    setState(() {
      laps.add(lap);
    });
  }

  // start function
  void start() {
    letStart = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSecs = secs + 1;
      int localMins = mins;
      int localHrs = hrs;

      if (localSecs > 59) {
        if (localMins > 59) {
          localHrs += 1;
          localMins = 0;
        } else
          localMins++;
        localSecs = 0;
      }
      setState(() {
        secs = localSecs;
        mins = localMins;
        hrs = localHrs;

        displaySecs = (secs > 9) ? "$secs" : "0$secs";
        displayMins = (mins > 9) ? "$mins" : "0$mins";
        displayHrs = (hrs > 9) ? "$hrs" : "0$hrs";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 13, 158, 57),
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 7, 53, 9),
        ),
        drawer: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text('STOPWATCH'),
            ),
            ListTile(
              title: Text('first one'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.50),
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "STOPWATCH",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 38.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    color: Color.fromARGB(255, 7, 53, 9),
                  ),
                ),
                /*SizedBox(
                  height: 20.0,
                ),*/
                Center(
                  child: Text(
                    "${displayHrs}:${displayMins}:${displaySecs}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                    height: 300.0,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 7, 53, 9),
                      borderRadius: BorderRadius.circular(8),
                    ),

                    // laps
                    child: ListView.builder(
                      itemCount: laps.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Lap No.${index + 1}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                              ),
                              Text(
                                "${laps[index]}",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )),
                /* SizedBox(
                  height: 20.0,
                ),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: RawMaterialButton(
                      onPressed: () {
                        (!letStart) ? start() : pause();
                      },
                      shape: StadiumBorder(
                          side:
                              BorderSide(color: Color.fromARGB(255, 7, 53, 9))),
                      child: Text(
                        (letStart) ? 'Pause' : 'Start',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                    SizedBox(
                      width: 8.0,
                    ),
                    IconButton(
                      onPressed: () {
                        addLaps();
                      },
                      icon: Icon(Icons.flag),
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                        child: RawMaterialButton(
                      onPressed: () {
                        reset();
                      },
                      shape: StadiumBorder(
                          side:
                              BorderSide(color: Color.fromARGB(255, 7, 53, 9))),
                      child: Text(
                        'Reset',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
