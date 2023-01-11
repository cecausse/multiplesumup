import 'package:flutter/material.dart';
import 'package:multiplesumup/theme/textTheme.dart';

const Color kdarkprimarycolor = Color(0xFFF57C00);
const Color klightprimarycolor = Color(0xFFFFE0B2);
const Color kprimarycolor = Color(0xFFFF9800);
const Color ktexticonscolor = Color(0xFF212121);
const Color kaccentcolor = Color(0xFF536DFE);
const Color kprimarytextcolor = Color(0xFF212121);
const Color ksecondarytextcolor = Color(0xFF757575);
const Color kdividercolor = Color(0xFFBDBDBD);

ThemeData myTheme = ThemeData(
  primaryColor: kprimarycolor,
  accentColor: kaccentcolor,
  primaryColorDark: kdarkprimarycolor,
  primaryColorLight: klightprimarycolor,
  primaryTextTheme: ktexttheme,
  dividerColor: kdividercolor,
  primaryIconTheme: IconThemeData(color: ktexticonscolor),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

const double kborderRadius = 10;
const Color buttonColor = Color(0xFFFF9800);
