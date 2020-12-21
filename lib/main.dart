import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:simple_animations/simple_animations.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:ads/ads.dart';
import 'package:connectivity/connectivity.dart';
import 'package:animate_do/animate_do.dart';
import 'package:confetti/confetti.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:url_launcher/url_launcher.dart';

//Locale
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

Ads ads;
String appID = "ca-app-pub-5811993212614257~3564260786";
bool connection = false;
Locale myLocale;
final String bannerUnitId = "ca-app-pub-5811993212614257/2985676288";
final String videoUnitId = "ca-app-pub-5811993212614257/1672594619";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var connectivityResult = await (Connectivity().checkConnectivity());
  myLocale = WidgetsBinding.instance.window.locale;
  if (myLocale.languageCode != 'ru' && myLocale.languageCode != 'en')
    myLocale = Locale('en', '');
  if (connectivityResult != ConnectivityResult.none) {
    connection = true;
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

privacyUrl() async {
  const url = 'https://wholesomeness-fantas.flycricket.io/privacy.html';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

//APP

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    if (connection) {
      ads = Ads(appID);

      ads.setVideoAd(
        childDirected: true,
        testDevices: [
          "Pixel_2_API_28_ANDROID_9:5554",
        ],
        adUnitId: videoUnitId,
      );

      ads.eventListener = (MobileAdEvent event) {
        switch (event) {
          case MobileAdEvent.loaded:
            print("An ad has loaded successfully in memory.");
            break;
          case MobileAdEvent.failedToLoad:
            print("The ad failed to load into memory.");
            break;
          case MobileAdEvent.clicked:
            print("The opened ad was clicked on.");
            break;
          case MobileAdEvent.impression:
            print("The user is still looking at the ad. A new ad came up.");
            break;
          case MobileAdEvent.opened:
            print("The Ad is now open.");
            break;
          case MobileAdEvent.leftApplication:
            print("You've left the app after clicking the Ad.");
            break;
          case MobileAdEvent.closed:
            print("You've closed the Ad and returned to the app.");
            break;
          default:
            print("There's a 'new' MobileAdEvent?!");
        }
      };
    }
  }

  @override
  void dispose() {
    ads?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    showBanner();
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en', ''),
              Locale('ru', ''),
            ],
            title: 'WHOLESOMENESS TEST',
            theme: ThemeData(
              primaryColor: Colors.white,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: GoogleFonts.pangolinTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            home: StartScreen(),
            routes: {
              FinderScreen.routeName: (context) => FinderScreen(),
              ResultScreen.routeName: (context) => ResultScreen(),
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}

//LOAD
showBanner() async {
  if (connection)
    await ads.showBannerAd(
      childDirected: true,
      testDevices: [
        "Pixel_2_API_28_ANDROID_9:5554",
        "aefe28ec5b3d386c",
      ],
      adUnitId: bannerUnitId,
      size: AdSize.banner,
    );
}

class Load extends StatefulWidget {
  @override
  _LoadState createState() => _LoadState();
}

class _LoadState extends State<Load> {
  @override
  Widget build(BuildContext context) {
    S.load(Locale(myLocale.languageCode, ''));
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            Background(),
            FadeIn(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Pulse(
                      infinite: true,
                      child: Text(
                        S.current.loadingMessage,
                        style: TextStyle(
                          fontSize: 36,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    SpinKitRing(
                      color: Colors.black38,
                      size: 80.0,
                    ),
                    SizedBox(height: 50),
                    SizedBox(height: 50)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//BACKGROUND

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "back",
      child: Container(
        foregroundDecoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

//START SCREEN

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);
    return StartPage();
  }
}

// ignore: must_be_immutable
class StartPage extends StatelessWidget {
  Future<bool> _onWillPop() async {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    String path = "";
    S.load(Locale(myLocale.languageCode, ''));
    if (S.current != null)
      path = S.current.titleName;
    else
      path = "assets/engBlank.png";
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            Background(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  FadeIn(
                    duration: Duration(seconds: 1),
                    child: Image(image: AssetImage(path)),
                  ),
                  SizedBox(height: 110),
                  FadeIn(
                    duration: Duration(seconds: 1),
                    child: AnimatedButton(),
                  ),
                  SizedBox(height: 20),
                  FadeIn(
                    child: Container(
                      height: 60,
                      child: FlatButton(
                        shape: StadiumBorder(),
                        textColor: Colors.black,
                        child: Text(
                          S.current.privacyMessage,
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          privacyUrl();
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 120),
                  SizedBox(height: 50)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum AniProps { color }
final tweenRainbow = MultiTween<AniProps>()
  ..add(
      AniProps.color,
      ColorTween(
          begin: Color(0xfffc5c65), end: Color(0xfffd9644)), //red -> orange
      Duration(milliseconds: 600))
  ..add(
      AniProps.color,
      ColorTween(
          begin: Color(0xfffd9644), end: Color(0xfffed330)), //orange -> yellow
      Duration(milliseconds: 600))
  ..add(
      AniProps.color,
      ColorTween(
          begin: Color(0xfffed330), end: Color(0xff26de81)), //yellow -> green
      Duration(milliseconds: 600))
  ..add(
      AniProps.color,
      ColorTween(
          begin: Color(0xff26de81), end: Color(0xff45aaf2)), //green -> blue
      Duration(milliseconds: 600))
  ..add(
      AniProps.color,
      ColorTween(
          begin: Color(0xff45aaf2), end: Color(0xffa55eea)), //blue -> violet
      Duration(milliseconds: 600))
  ..add(
      AniProps.color,
      ColorTween(
          begin: Color(0xffa55eea), end: Color(0xfffc5c65)), //violet -> red
      Duration(milliseconds: 600));

class AnimatedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String word = "";
    // myLocale = Localizations.localeOf(context);
    S.load(Locale(myLocale.languageCode, ''));
    if (S.current != null)
      word = S.current.startWord;
    else
      word = "Start";
    return LoopAnimation<MultiTweenValues<AniProps>>(
      tween: tweenRainbow,
      duration: tweenRainbow.duration,
      builder: (context, child, value) {
        return Container(
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            color: value.get(AniProps.color),
          ),
          height: 60,
          width: 220,
          child: OutlineButton(
            textColor: Colors.black,
            child: Pulse(
              child: Text(
                word,
                style: TextStyle(fontSize: 34),
              ),
            ),
            onPressed: () {
              genderScreenPush(context);
            },
          ),
        );
      },
    );
  }
}

bool genderCheck = false;
String genderValue = "";

//PUSH

startPagePush(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (_) {
    return StartScreen();
  }));
}

genderScreenPush(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (_) {
    return GenderScreen();
  }));
}

finderScreenPushNamed(context) async {
  loadPagePush(context);
  Future.delayed(Duration(seconds: 4), () {
    if (connection) {
      ads.showVideoAd();
    }
    Navigator.pushNamed(
      context,
      FinderScreen.routeName,
      arguments: Gender(genderValue),
    );
  });
}

loadPagePush(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (_) {
    return Load();
  }));
}

resultScreenPush(context, ResultArguments results) async {
  loadPagePush(context);
  Future.delayed(Duration(seconds: 4), () {
    if (connection) {
      ads.showVideoAd();
    }
    Navigator.pushNamed(
      context,
      ResultScreen.routeName,
      arguments: ResultArguments(results.testResult,
          results.wholesomenessPercent, results.mysticPercent),
    );
  });
}

//GENDER SCREEN

class GenderScreen extends StatelessWidget {
  const GenderScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      genderCheck = false;
      return (await startPagePush(context));
    }

    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            Background(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FadeInRight(
                  child: Text(
                    S.current.selectMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 42,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                FadeInRight(
                  child: LoopAnimation<MultiTweenValues<AniProps>>(
                    tween: tweenRainbow,
                    duration: tweenRainbow.duration,
                    builder: (context, child, valueTween) {
                      return CustomRadioButton(
                          enableShape: true,
                          enableButtonWrap: true,
                          wrapAlignment: WrapAlignment.center,
                          height: 40,
                          width: 100,
                          elevation: 10,
                          unSelectedColor: Colors.white,
                          buttonBorder: valueTween.get(AniProps.color),
                          buttonLables: [
                            S.current.maleMessage,
                            S.current.femaleMessage,
                          ],
                          buttonValues: [
                            "Male",
                            "Female",
                          ],
                          buttonTextStyle: ButtonTextStyle(
                              selectedColor: Colors.white,
                              unSelectedColor: Colors.black,
                              textStyle: TextStyle(fontSize: 20)),
                          radioButtonValue: (value) {
                            genderValue = value;
                            genderCheck = true;
                          },
                          selectedColor: valueTween.get(AniProps.color));
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                FadeInRight(
                  child: Container(
                    decoration: new BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(
                          width: 1,
                          color: Colors.black,
                          style: BorderStyle.solid),
                    ),
                    height: 60,
                    width: 200,
                    child: OutlineButton(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      shape: StadiumBorder(),
                      textColor: Colors.black,
                      child: Text(
                        S.current.acceptMessage,
                        style: TextStyle(fontSize: 24),
                      ),
                      onPressed: () {
                        if (genderCheck == true) {
                          genderCheck = false;
                          finderScreenPushNamed(context);
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return FadeIn(
                                child: AlertDialog(
                                  title: Text(S.current.selectSexAlert),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Gender {
  final String sex;
  Gender(this.sex);
}

class PercentText extends StatelessWidget {
  PercentText({this.count});

  final int count;
  @override
  Widget build(BuildContext context) {
    return Text('$count%');
  }
}

String globalSex;

Timer timer;

//FINDER SCREEN

class FinderScreen extends StatefulWidget {
  FinderScreen({Key key}) : super(key: key);
  static const routeName = '/finderScreen';
  @override
  State<StatefulWidget> createState() => new _FinderScreenState();
}

class _FinderScreenState extends State<FinderScreen> {
  ConfettiController _controllerCenter =
      ConfettiController(duration: const Duration(seconds: 10));
  Future<bool> _onWillPop() async {
    stopTimer();
    return (await genderScreenPush(context));
  }

  double _percentState;
  int _intPercentState;

  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _percentState = 0.0;
    _intPercentState = 0;
    super.initState();
  }

  void _plusPercent() {
    double nextPercent = _percentState + 0.02;
    int nextIntPercent = (nextPercent * 100).round();

    if (nextPercent > 1.0) {
      _percentState = 1.0;
      _intPercentState = 100;
      stopTimer();
    } else {
      setState(() {
        _percentState = nextPercent;
        _intPercentState = nextIntPercent;
      });
    }
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  startTimer() {
    _controllerCenter.play();
    timer = new Timer.periodic(
        const Duration(milliseconds: 100), (Timer timer) => _plusPercent());
  }

  stopTimer() {
    _controllerCenter.stop();
    if (_intPercentState == 100) {
      timer.cancel();
      resultScreenPush(context, resultCalculation(globalSex, context));
    } else {
      timer.cancel();
      setState(() {
        _percentState = 0.0;
        _intPercentState = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Gender gender = ModalRoute.of(context).settings.arguments;
    globalSex = gender.sex;
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            Background(),
            FadeInRight(
              duration: Duration(seconds: 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    S.current.holdMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: EdgeInsets.all(30),
                    decoration: new BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                      border: Border.all(
                          width: 3,
                          color: Colors.black,
                          style: BorderStyle.solid),
                    ),
                    child: LinearPercentIndicator(
                      padding: EdgeInsets.all(0),
                      curve: Curves.fastLinearToSlowEaseIn,
                      clipLinearGradient: true,
                      alignment: MainAxisAlignment.center,
                      backgroundColor: Colors.white,
                      animateFromLastPercent: true,
                      animation: true,
                      lineHeight: 30.0,
                      percent: _percentState,
                      linearGradient: LinearGradient(
                        colors: [
                          const Color(0xfffc5c65),
                          const Color(0xfffd9644),
                          const Color(0xfffed330),
                          const Color(0xff26de81),
                          const Color(0xff45aaf2),
                          const Color(0xffa55eea),
                        ],
                        stops: const [0.0, 0.20, 0.40, 0.60, 0.80, 1.00],
                      ),
                      center: PercentText(count: (_percentState * 100).round()),
                      linearStrokeCap: LinearStrokeCap.butt,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTapDown: (_) => startTimer(),
                    onTapUp: (_) => stopTimer(),
                    child: Container(
                      decoration: new BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        border: Border.all(
                          width: 1,
                          color: Colors.black,
                          style: BorderStyle.solid,
                        ),
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      height: 85,
                      width: 85,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ConfettiWidget(
                            emissionFrequency: 0.3,
                            numberOfParticles: 3,
                            minBlastForce: 5,
                            maxBlastForce: 6,
                            minimumSize: Size(5, 5),
                            maximumSize: Size(5, 5),
                            confettiController: _controllerCenter,
                            blastDirectionality: BlastDirectionality.explosive,
                            colors: const [
                              Color(0xfffc5c65),
                              Color(0xfffd9644),
                              Color(0xfffed330),
                              Color(0xff26de81),
                              Color(0xff45aaf2),
                              Color(0xffa55eea),
                            ],
                          ),
                          Pulse(
                            child: Text(
                              S.current.holdButtonMessage,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//RESULT ARG

class ResultArguments {
  String testResult;
  int wholesomenessPercent;
  int mysticPercent;
  ResultArguments(
      this.testResult, this.wholesomenessPercent, this.mysticPercent);
}

ResultArguments resultCalculation(String sex, BuildContext context) {
  ResultArguments result = ResultArguments(S.current.dragonMessage, 100, 99);
  Random rnd = new Random();

  int minPercent = 10;
  int maxPercent = 60;

  int minTestRes = 0;
  int maxTestRes = 100;

  int minMystic;
  int maxMystic;
  int rMystic;

  switch (sex) {
    case "Male":
      int rTestRes = minTestRes + rnd.nextInt(maxTestRes - minTestRes);
      int rPercent = minPercent + rnd.nextInt(maxPercent - minPercent);

      if (rTestRes >= 0 && rTestRes <= 70) {
        result.testResult = S.current.phoenixMessage;

        minMystic = 30;
        maxMystic = 99;
        rMystic = minMystic + rnd.nextInt(maxMystic - minMystic);

        result.mysticPercent = rMystic;
      }
      if (rTestRes >= 71 && rTestRes <= 100) {
        result.testResult = S.current.dragonMessage;

        minMystic = 30;
        maxMystic = 99;
        rMystic = minMystic + rnd.nextInt(maxMystic - minMystic);

        result.mysticPercent = rMystic;
      }
      result.wholesomenessPercent = rPercent;
      break;

    case "Female":
      int rTestRes = minTestRes + rnd.nextInt(maxTestRes - minTestRes);
      int rPercent = minPercent + rnd.nextInt(maxPercent - minPercent);

      if (rTestRes >= 0 && rTestRes <= 70) {
        result.testResult = S.current.fairyMessage;

        minMystic = 30;
        maxMystic = 99;
        rMystic = minMystic + rnd.nextInt(maxMystic - minMystic);

        result.mysticPercent = rMystic;
      }
      if (rTestRes >= 71 && rTestRes <= 100) {
        result.testResult = S.current.unicornMessage;

        minMystic = 30;
        maxMystic = 99;
        rMystic = minMystic + rnd.nextInt(maxMystic - minMystic);

        result.mysticPercent = rMystic;
      }
      result.wholesomenessPercent = rPercent;
      break;
  }

  return result;
}

//RESULT SCREEN

class ResultScreen extends StatefulWidget {
  ResultScreen({Key key}) : super(key: key);
  static const routeName = '/resultScreen';

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  Future<bool> _onWillPop() async {
    return (await genderScreenPush(context));
  }

  @override
  Widget build(BuildContext context) {
    final ResultArguments results = ModalRoute.of(context).settings.arguments;
    int imagination = results.mysticPercent;
    int logic = 100 - results.mysticPercent;
    testResult = results.testResult;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            Background(),
            FadeIn(
              duration: Duration(seconds: 1),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      S.current.congratulationsMessage,
                      style: TextStyle(fontSize: 34),
                    ),
                    Text(
                      S.current.youAreMessage + " " + results.testResult + "!",
                      style: TextStyle(fontSize: 26),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      S.current.imaginationMessage +
                          ": " +
                          imagination.toString() +
                          "%",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      S.current.logicMessage + ": " + logic.toString() + "%",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          S.current.wholesomenessMessage +
                              " " +
                              results.wholesomenessPercent.toString() +
                              "%",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                          color: Colors.black,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
                          iconSize: 18,
                          icon: Icon(Icons.help_outline),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(
                                  S.current.helpMessage,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      S.current.shareMessage,
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ArgonButton(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          height: 50,
                          width: 50,
                          borderRadius: 30.0,
                          color: Colors.white,
                          child: Icon(
                            Icons.refresh,
                            size: 30,
                          ),
                          loader: Container(
                            padding: EdgeInsets.all(10),
                            child: SpinKitRotatingCircle(
                              color: Colors.white,
                            ),
                          ),
                          onTap: (startLoading, stopLoading, btnState) {
                            startLoading();
                            genderScreenPush(context);
                            stopLoading();
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ArgonButton(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          height: 50,
                          width: 50,
                          borderRadius: 30.0,
                          color: Colors.white,
                          child: Icon(
                            Icons.share,
                            size: 30,
                          ),
                          loader: Container(
                            padding: EdgeInsets.all(10),
                            child: SpinKitRotatingCircle(
                              color: Colors.white,
                            ),
                          ),
                          onTap: (startLoading, stopLoading, btnState) {
                            startLoading();
                            shareText();
                            stopLoading();
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ArgonButton(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          height: 50,
                          width: 50,
                          borderRadius: 30.0,
                          color: Colors.white,
                          child: Icon(
                            Icons.exit_to_app,
                            size: 30,
                          ),
                          loader: Container(
                            padding: EdgeInsets.all(10),
                            child: SpinKitRotatingCircle(
                              color: Colors.white,
                            ),
                          ),
                          onTap: (startLoading, stopLoading, btnState) {
                            if (btnState == ButtonState.Idle) {
                              startLoading();
                              startPagePush(context);
                              stopLoading();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String testResult;
String appLink =
    "https://play.google.com/store/apps/details?id=com.tripledash.wholesomeness_scanner";

Future<void> shareText() async {
  String shareString = S.current.onShareText +
      testResult +
      "! " +
      S.current.onShareText2 +
      " " +
      appLink;
  try {
    Share.text("Share!", shareString, 'text/plain');
  } catch (e) {
    print('Error: $e');
  }
}
