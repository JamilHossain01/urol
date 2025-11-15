class ApiUrl {
  static const String baseUrl = "http://10.10.10.9:4300/api";

  static const String login = "$baseUrl/auth/login";
  static const String forgetPass = "$baseUrl/auth/forgot-password";
  static const String verifyOTP = "$baseUrl/auth/verify-otp";
  static const String signUp = "$baseUrl/auth/create";
  static const String resetPassword = "$baseUrl/auth/reset-password";
  static const String updateProfile = "$baseUrl/users/update-my-profile";
  static const String support = "$baseUrl/contacts/add";
  static const String changePassword = "$baseUrl/auth/change-password";
  static const String addFriend = "$baseUrl/friends";
  static const String competition = "$baseUrl/users/competition";
  static const String addGym = "$baseUrl/gyms";
  static const String claimGym = "$baseUrl/claim-reqs";
  static const String myGyms = "$baseUrl/gyms/my-gyms";
  static const String addEvents = "$baseUrl/events";
  static const String myEvent = "$baseUrl/events/my-events";
  static const String savedGym = "$baseUrl/save";
  static const String allNotification = "$baseUrl/notifications";
  static const String profile = "$baseUrl/users/my-profile";
  static const String notificationUnread = "$baseUrl/notifications/unread-count";
  static const String allNotificationRead = "$baseUrl/notifications/make-read-all";
  static String discoverFriends(
          {required String searchTerm, required String limit}) =>
      "$baseUrl/users/unfriends?limit=$limit&searchTerm=$searchTerm";

  static String editEvent({required String id}) => "$baseUrl/events/$id";

  static String getOpenMats({required String lat,required String long,required String hour,required String dayName,required String minute}) =>
      "$baseUrl/gyms/mats/near-me?day=$dayName&hour=$hour&minute=$minute&long=$long&lat=$lat";

  static String mapGym(
          {required String searchTerm,
          required dynamic distance,
          required String disciplines}) =>
      "$baseUrl/gyms/mats?searchTerm=$searchTerm&disciplines=$disciplines&distance=$distance";

  static String readNotificationSingle({required String id}) =>
      "$baseUrl/notifications/make-read/$id";

  static String allEvent(
          {required String searchTerm,
          required String type,
          required String state,
          required String city}) =>
      "$baseUrl/events?searchTerm=$searchTerm&type=$type&state=$state&city=$city&limit=99999999";

  static String deleteGym({required String gymId}) => "$baseUrl/gyms/$gymId";
  static String deleteBookMarkGym({required String gymId}) =>
      "$baseUrl/save/$gymId";

  static String deleteEvent({required String eventId}) =>
      "$baseUrl/events/$eventId";

  static String addGymBookmarks() => "$baseUrl/save";

  static String gymDetails({required String gymId}) => "$baseUrl/gyms/$gymId";

  static String myFriends({required String searchTerm}) =>
      "$baseUrl/friends?searchTerm=$searchTerm";

  static String unFriend({required String friendId}) =>
      "$baseUrl/friends/unfolow/$friendId";

  static String reviewStatistics({required String serviceId}) =>
      "$baseUrl/reviews/stats/$serviceId";

  static String settingMetaData({required String meta}) =>
      "$baseUrl/setting/$meta";
}
