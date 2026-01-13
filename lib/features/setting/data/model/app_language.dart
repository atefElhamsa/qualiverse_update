class AppLanguage {
  final String code;
  final String name;

  AppLanguage({required this.code, required this.name});
}

AppLanguage mapCodeToLanguage(String code) {
  switch (code) {
    case 'ar':
      return AppLanguage(code: 'ar', name: 'arabic');
    case 'en':
    default:
      return AppLanguage(code: 'en', name: 'english_us');
  }
}
