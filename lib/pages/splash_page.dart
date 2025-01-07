import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shopinglist/routes/page_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});


  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late int counter = 0;
  Random rnd = Random();
  String saying = "";
  List<String> sayings = [
    "#Markhor🦌",
    "#MeTheLoneWolf🐺",
    "#thuglife☠️👽⚔️🔪⛓",
    "#nothingbox🙇🤷🏽‍♂️🕸🎁",
    "#hakunamatata🐅",
    "#maulahjat🏋🏾‍⚔",
    "#deadman💀⚰️",
    "#deadwillriseagain⚔",
    "#istandalone👑",
    "#istandaloneforjustic🐅☘️",
    "#nøfate⚓️🚀⚰️",
    "#bornfreeandwild👅💪",
    "#bornfreeandlivefree🐅🐆🐈",
    "#brutaltactician🎖",
    "#holysinner🕊",
    "#devilhunter😇",
    "#khalaimakhlooq👻☠️😈🦅👽",
    "#aakhrichittan👻🚶🏽‍♂️🦁🐆🐅🌊🧗🏼‍♂️🥇🎖🏆🗻",
    "#KoiJalGiaKisiNayDuaDi👤🔥🎃☠️🤯😇🙏📦",
    "#ZakhmiDillJallaDon🤦🏻‍♂️🤕🔥💔👿☠️👻",
    "#WhatHappensToTheSoulsWhoLookInTheEyesOfDragon🦖🐉☃️🌊⛈💥🔥🌪🐲☠️👻"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadingStatus();

    Timer(Duration(seconds: 10),
        () => Navigator.pushReplacementNamed(context, PageRoutes.loginPage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: Card(
                elevation: 10,
                margin: const EdgeInsets.all(10),
                color: Colors.orange.withOpacity(0.7),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const CircularProgressIndicator(
                        strokeWidth: 10,
                        backgroundColor: Colors.orange,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Loading $counter', textAlign: TextAlign.center),
                      Text(saying, textAlign: TextAlign.center),
                      const Text(
                        "App powered by DeadMan Inc",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void loadingStatus() {
    Future.delayed(const Duration(seconds: 1)).then((_) {
      setState(() {
        counter += 10;
        saying = sayings[rnd.nextInt(18)];
      });
      loadingStatus();
    });
  }
}
