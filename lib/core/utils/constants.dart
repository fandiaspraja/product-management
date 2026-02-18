import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w500';
const termsUrl = 'https://api.atssolutionco.com/terms';
const privacyUrl = 'https://api.atssolutionco.com/privacy';

// colors
const Color primary = Color(0xFF237EDC);
const Color primarySecond = Color(0xFF53A1E7);
const Color primaryThird = Color(0xFF83C5F2);
const Color primary90 = Color(0xFF3B8FE2);
const Color primary70 = Color(0xFF6BB3ED);
const Color primary50 = Color(0xFF9BD7F8);
const Color primary40 = Color(0xFFCAF0FE);
const Color primary30 = Color(0xFFCAF0FE);
const Color primary20 = Color(0xFFDFF6FE);
const Color primary10 = Color(0xFFEEF9FF);
const Color primaryDark = Color(0xFF1A5EB7);

const Color secondary = Color(0xFF2BB63F);
const Color secondary90 = Color(0xFF4DC157);
const Color secondary80 = Color(0xFF6FCC6F);
const Color secondary70 = Color(0xFF91D787);
const Color secondary60 = Color(0xFFB3E29F);
const Color secondary50 = Color(0xFFD5EDA7);
const Color secondary40 = Color(0xFFE6F3BF);
const Color secondary30 = Color(0xFFF0F7D6);
const Color secondary20 = Color(0xFFF7FAE8);
const Color secondary10 = Color(0xFFFBFDF3);

const Color yellow = Color(0xFFF4CD32);
const Color lightYellow = Color(0xFFFFF9ED);
const Color black = Color(0xFF061738);
const Color white = Color(0xFFFFFFFF);
const Color green = Color(0xFF2BB63F);
const Color red = Color(0xFFEB5757);
const Color red20 = Color(0xFFFFF3F3);

const Color blue = Color(0xFF237EDC);
const Color disable = Color(0xFFB7C7DF);

const Color bgPrimary = Color(0xFFFFFFFF);
const Color bgSecondary = Color(0xFFf2f2f7);
const Color bgTertiery = Color(0xFFFFFFFF);

const Color darkGreyFirst = Color(0xFF737373);
const Color darkGreySecond = Color(0xFFE6E6E6);
const Color darkGreyThird = Color(0xFFB7C7DF);

// font
const Color fontColorPrimary = Color(0xFF061738);
const Color fontColorHint = Color(0xff30839abc);
const Color fontColorSecondary = Color(0xff8F9EB2);
const Color fontColorTertiary = Color(0xffB7C7DF);
const Color fontColorPlaceholder = Color(0xff9AA4B2);
const Color fontColorPrimaryBlue = Color(0xFF1566B9);

const Color lineForm = Color(0xFFE3ECFA);
const Color lineFormOnprogress = Color(0xFFE1EAF6);

const Color bgImageForm = Color(0xFFF1F5FB);
const Color bgHomepage = Color(0xFFF8FBFF);
const Color borderDisable = Color(0xFFEEEEEE);

const Color bgBody = Color(0xFFFFFFFF);
const Color bgDisableCard = Color(0xFFD7E2F0);
const Color bgCard = Color(0xFFF8FBFF);
const Color bgDisableButton = Color(0xFFB7C7DF);

const Color border = Color(0xFFE2E8F0);
const Color borderLight = Color(0xFFF0F1F6);

const Color closeIconColor = Color(0xFF4F4F4F);
const Color baseColor = Color(0xFFF4F4F4);

const Color neutral80 = Color(0xFFE8EDF2);

// text style
final TextStyle kHeading5 = GoogleFonts.urbanist(
  fontSize: 23,
  fontWeight: FontWeight.w900,
);
final TextStyle kHeading6 = GoogleFonts.urbanist(
  fontSize: 19,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.15,
);
final TextStyle kSubtitle = GoogleFonts.urbanist(
  fontSize: 15,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.15,
);
final TextStyle kBodyText = GoogleFonts.urbanist(
  fontSize: 13,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.25,
);

// text theme
final kTextTheme = TextTheme(
  headlineMedium: kHeading5,
  headlineSmall: kHeading6,
  labelMedium: kSubtitle,
  bodyMedium: kBodyText,
);

final kDrawerTheme = DrawerThemeData(backgroundColor: Colors.grey.shade700);

const kColorScheme = ColorScheme(
  primary: primary,
  secondary: primarySecond,
  secondaryContainer: primaryThird,
  surface: bgSecondary,
  error: Colors.red,
  onPrimary: bgPrimary,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  onError: Colors.white,
  brightness: Brightness.dark,
);

// Gap
const SizedBox gapH8 = SizedBox(height: 8);
const SizedBox gapH4 = SizedBox(height: 4);

const SizedBox gapH10 = SizedBox(height: 10);
const SizedBox gapH12 = SizedBox(height: 12);
const SizedBox gapH16 = SizedBox(height: 16);
const SizedBox gapH20 = SizedBox(height: 20);
const SizedBox gapH24 = SizedBox(height: 24);
const SizedBox gapH32 = SizedBox(height: 32);
const SizedBox gapH40 = SizedBox(height: 40);
const SizedBox gapH60 = SizedBox(height: 60);

const SizedBox gapW4 = SizedBox(width: 4);
const SizedBox gapW8 = SizedBox(width: 8);
const SizedBox gapW10 = SizedBox(width: 10);
const SizedBox gapW12 = SizedBox(width: 12);
const SizedBox gapW16 = SizedBox(width: 16);
const SizedBox gapW20 = SizedBox(width: 20);
const SizedBox gapW24 = SizedBox(width: 24);
const SizedBox gapW32 = SizedBox(width: 32);
const SizedBox gapW40 = SizedBox(width: 40);
const SizedBox gapW60 = SizedBox(width: 60);

const List<Color> polylineColors = [
  yellow,
  blue,
  green,
  red,
  Colors.cyanAccent,
];
