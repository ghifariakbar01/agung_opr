part of style;

mixin Themes {
  static void initUiOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Palette.primaryColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  static ThemeData lightTheme(BuildContext context) {
    return ThemeData.light().copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: const ColorScheme.light(
        primary: Palette.primaryColor,
        secondary: Palette.secondaryColor,
        onSecondary: Palette.secondaryTextColor,
      ),
      textTheme: GoogleFonts.latoTextTheme(
        Theme.of(context).textTheme,
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData.dark().copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: const ColorScheme.dark(
        primary: Palette.primaryColor,
        secondary: Palette.secondaryColor,
        onPrimary: Palette.primaryTextColor,
        onSecondary: Palette.secondaryTextColor,
      ),
      textTheme: GoogleFonts.latoTextTheme(
        Theme.of(context).textTheme,
      ),
    );
  }

  static TextStyle blue(FontWeight? fontWeight, double fontSize) {
    return GoogleFonts.poppins(
        color: Palette.secondaryColor,
        fontWeight: fontWeight,
        fontSize: fontSize);
  }

  static TextStyle white(FontWeight? fontWeight, double fontSize) {
    return GoogleFonts.poppins(
        color: Colors.white,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize);
  }

  static TextStyle blueSpaced(FontWeight fontWeight, double fontSize) {
    return GoogleFonts.poppins(
        color: Palette.secondaryColor,
        fontWeight: fontWeight,
        fontSize: fontSize,
        letterSpacing: 4);
  }

  static TextStyle whiteSpaced(FontWeight fontWeight, double fontSize) {
    return GoogleFonts.poppins(
        color: Colors.white,
        fontWeight: fontWeight,
        fontSize: fontSize,
        letterSpacing: 4);
  }

  static TextStyle grey(FontWeight fontWeight, double fontSize) {
    return GoogleFonts.poppins(
        color: Palette.grey,
        fontWeight: fontWeight,
        fontSize: fontSize,
        letterSpacing: 4);
  }

  static TextStyle greyHint(FontWeight fontWeight, double fontSize) {
    return GoogleFonts.poppins(
      color: Palette.greySecondary,
      fontWeight: fontWeight,
      fontSize: fontSize,
    );
  }

  static TextStyle customColor(
      FontWeight? fontWeight, double fontSize, Color color) {
    return GoogleFonts.poppins(
        color: color,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize);
  }

  static OutlineInputBorder notFocused({
    required bool isRadius,
    Color? borderColor,
  }) {
    return OutlineInputBorder(
        borderRadius: isRadius
            ? BorderRadius.all(Radius.circular(10))
            : BorderRadius.all(Radius.zero),
        borderSide: BorderSide(color: borderColor ?? Palette.greySecondary));
  }

  static OutlineInputBorder focused() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Palette.primaryColor));
  }

  static OutlineInputBorder focusedSearch() {
    return const OutlineInputBorder(
        borderSide: BorderSide(color: Palette.primaryColor, width: 2));
  }

  static InputDecoration formStyle(String hintText,
      {Widget? icon, double? hintFontSize}) {
    return InputDecoration(
      enabledBorder: Themes.notFocused(isRadius: true),
      focusedBorder: Themes.focused(),
      contentPadding: const EdgeInsets.all(16),
      border: InputBorder.none,
      hintStyle: Themes.greyHint(FontWeight.normal, hintFontSize ?? 16),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1.0),
        borderRadius: BorderRadius.circular(4.0),
      ),
      errorStyle: TextStyle(fontSize: 12.0, color: Colors.red),
      hintText: hintText,
      suffixIcon: icon ?? null,
    );
  }

  static InputDecoration formStyleSquared(String hintText,
      {TextStyle? hintStyle, Widget? icon}) {
    return InputDecoration(
      enabledBorder:
          Themes.notFocused(isRadius: false, borderColor: Palette.grey),
      focusedBorder:
          Themes.notFocused(isRadius: false, borderColor: Palette.primaryColor),
      disabledBorder:
          Themes.notFocused(isRadius: false, borderColor: Palette.primaryColor),
      contentPadding: const EdgeInsets.all(16),
      border: InputBorder.none,
      hintStyle: hintStyle ?? Themes.greyHint(FontWeight.bold, 12),
      hintText: hintText,
      suffixIcon: icon ?? null,
    );
  }

  static InputDecoration searchFormStyle(String hintText, {Widget? icon}) {
    return InputDecoration(
      enabledBorder:
          Themes.notFocused(isRadius: false, borderColor: Palette.primaryColor),
      focusedBorder: Themes.focusedSearch(),
      contentPadding: const EdgeInsets.all(16),
      border: InputBorder.none,
      hintStyle: Themes.greyHint(FontWeight.bold, 12),
      hintText: hintText,
      suffixIcon: icon ?? null,
    );
  }

  static TextStyle blackItalic() {
    return GoogleFonts.poppins(
      color: Colors.black,
      fontSize: 12,
      fontStyle: FontStyle.italic,
      decoration: TextDecoration.underline,
    );
  }
}
