class Constants {
  //app
  static String appName = 'Lp Finance';
  static String restApiBaseUrl = 'https://api.lpblock.org/api';
  static String restApiProtocol = 'http'; // https or http
  static String webDashboardBaseUrl = 'http://137.184.158.187/restapi/api';

  //minimum amount for fiat currency transactions
  static int minimumFiatTransfer = 10; // change 10

  //support
  static bool whatsAppSupport = true;
  static String whatsAppNumber = "+258850586843";
  static String whatsAppChatlink =
      Uri.encodeFull("https://wa.me/$whatsAppNumber?text=Hello, i need help");
  // static bool telegramSupport = false;
  // static String telegramChatlink = "";
}
