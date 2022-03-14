import 'package:animations/animations.dart';
import 'package:apollo_lite/backend/song_manager.dart';
import 'package:apollo_lite/pages/create_playlist.dart';
import 'package:apollo_lite/pages/library_page.dart';
import 'package:apollo_lite/pages/playing_now.dart';
import 'package:apollo_lite/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'backend/constants.dart';
import 'backend/locals/lang.dart';
import 'backend/locals/locale_const.dart';
import 'home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (ctx) => PageManager())],
      child: MaterialApp(
        title: 'Apollo Lite',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.brown,
          fontFamily: 'Rubik',
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
              TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(
                transitionType: SharedAxisTransitionType.horizontal,
              ),
            },
          ),
        ),
        builder: (context, widget) => ResponsiveWrapper.builder(BouncingScrollWrapper.builder(context, widget!),
            mediaQueryData: physicalHeight < 2100 ? MediaQuery.of(context).copyWith(textScaleFactor: 0.95) : MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            maxWidth: 1200,
            minWidth: 450,
            defaultScale: true,
            breakpoints: const [
              ResponsiveBreakpoint.resize(600, name: MOBILE),
              ResponsiveBreakpoint.autoScale(800, name: TABLET),
              ResponsiveBreakpoint.autoScale(1200, name: DESKTOP),
              ResponsiveBreakpoint.resize(450, name: MOBILE),
              ResponsiveBreakpoint.autoScale(800, name: TABLET),
              ResponsiveBreakpoint.autoScale(1000, name: TABLET),
              ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              ResponsiveBreakpoint.autoScale(2460, name: "4K"),
            ]),
        home: const MyHomePage(),
        initialRoute: Splash.routeName,
        routes: {
          MyHomePage.routeName: (ctx) => const MyHomePage(),
          Splash.routeName: (ctx) => const Splash(),
          LibraryPage.routeName: (ctx) => const LibraryPage(),
          //CreatePlaylistPage.routeName: (ctx) => const CreatePlaylistPage(),
        },
        onGenerateRoute: (page) {
          switch (page.name) {
            case PlayingNow.routeName:
              return PageTransition(
                child: const PlayingNow(),
                curve: Curves.easeIn,
                type: PageTransitionType.bottomToTop,

                //childCurrent: const MyHomePage(),
                duration: const Duration(milliseconds: 250),
                settings: page,
              );

            case CreatePlaylistPage.routeName:
              return PageTransition(
                child: const CreatePlaylistPage(),
                curve: Curves.easeIn,
                type: PageTransitionType.topToBottomJoined,
                childCurrent: const LibraryPage(),
                duration: const Duration(milliseconds: 250),
                settings: page,
              );
            default:
              return null;
          }
        },
        locale: _locale,
        supportedLocales: const [Locale('en', ''), Locale('tr', ''), Locale('fr', 'FR'), Locale('es', 'ES')],
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode && supportedLocale.countryCode == locale?.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
      ),
    );
  }
}
