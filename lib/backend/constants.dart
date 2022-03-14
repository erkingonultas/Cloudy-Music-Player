import 'package:flutter/material.dart';
import 'dart:ui';

// STATS
const version = 'v0.03';

var pixelRatio = window.devicePixelRatio;
//Size in physical pixels
var physicalScreenSize = window.physicalSize;
var physicalWidth = physicalScreenSize.width;
var physicalHeight = physicalScreenSize.height;

final defaultPlaylistArt = Image.asset(
  'assets/AlbumPlaceHolder.png',
  fit: BoxFit.fitWidth,
  frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
    if (wasSynchronouslyLoaded) {
      return child;
    }
    return AnimatedOpacity(
      child: child,
      opacity: frame == null ? 0 : 1,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
    );
  },
);

const Color whitey = Color(0xffe9e6ff);
const Color brown1 = Color(0xffb0a084);
const Color brown2 = Color(0xff73683b);
const Color brown3 = Color(0xff583e23);
const Color dblue = Color(0xff13262f);

const Color black = Color(0xff000000);
const Color onyx = Color(0xff363946);
const Color dimGray = Color(0xff696773);
const Color morningBlue = Color(0xff819595);
const Color ashGray = Color(0xffb1b6a6);

const Color shamrockGreen = Color(0xff499f68);

const TextStyle basStyle = TextStyle(
  color: dblue,
  fontWeight: FontWeight.w500,
  fontSize: 30,
);
const TextStyle bas2Style = TextStyle(
  color: onyx,
  fontWeight: FontWeight.w400,
  fontSize: 24,
);
const TextStyle songTitleStyle = TextStyle(
  color: onyx,
  fontWeight: FontWeight.w600,
  fontSize: 16,
);
const TextStyle songArtistStyle = TextStyle(
  color: onyx,
  fontWeight: FontWeight.w400,
  fontSize: 14,
);

const TextStyle songDetailStyle = TextStyle(
  color: onyx,
  fontWeight: FontWeight.w500,
  fontSize: 23,
);
