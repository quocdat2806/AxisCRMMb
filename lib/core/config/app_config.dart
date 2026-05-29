class AppConfig {
  AppConfig._();

  static const String userProfileBoxName =
      'user_profile_box'; //box name for user profile
  static const String userProfileKey = 'user_profile'; //key for user profile
  static const String onboardingCompletedKey =
      'onboarding_completed'; //key for onboarding completed
  static const String topicsBoxName = 'topics_box'; //box name for topics
  static const String streakBoxName = 'streak_box'; //box name for streak data
  static const String tokenKey = 'token'; // JWT token key
  static const int connectTimeout =
      10000; //connect timeout for network requests
  static const int receiveTimeout =
      30000; //receive timeout for network requests
  static const int defaultPageSize = 20; //default page size for pagination
  static const int defaultPageIndex = 0; //default page index for pagination
  static const double scrollThreshold = 0.7; //scroll threshold for pagination
  static const String dateDisplayFormat = 'dd/MM/yyyy'; //date display format
  static const String dateTimeDisplayFormat =
      'dd/MM/yyyy HH:mm'; //date format for display
  static const String dateTimeAPIFormat =
      'YYYY-MM-DDThh:mm:ssTZD'; //date format for API
  static const String baseOpenAiUrl =
      'https://api.openai.com/v1'; // base URL for OpenAI API
}
