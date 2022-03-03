import 'package:http/http.dart' as http;
import 'package:lp_finance/utils/constants.dart';
import 'package:lp_finance/utils/exports.dart';
import '../../../Controller/data_controller.dart';
import '../models/login_model.dart';

class AuthRepository {
  Future<List> register(
    firstname,
    lastname,
    email,
    password,
    contryCode,
    phoneNumber,
  ) async {
    var response;
    Uri endpoint = Uri.parse(Constants.restApiBaseUrl + '/auth/register');
    print(endpoint);
    try {
      var resp = await http.post(endpoint, body: {
        'first_name': firstname,
        'last_name': lastname,
        'email': email.trim(),
        'password': password,
        'password_confirmation': password,
        'phone': phoneNumber,
        'country_code': contryCode,
      } /*, headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',} */);
      print(resp.statusCode);
      print(resp.body);

      if (resp.statusCode == 200) {
        response = jsonDecode(resp.body);
        print(response['data']);
        if (response['error'].toString() == 'true') {
          Get.snackbar('Error', response['message'],
              margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900]);
          return [false, response['message']];
        }
        return [true, response['data']['access_token']];
      } else if (resp.statusCode == 401) {
        response = jsonDecode(resp.body);
        Get.snackbar('Error', '404',
            margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900]);
        return [false, response['message']];
      } else {
        response = jsonDecode(resp.body);
        Get.snackbar('Error', resp.statusCode.toString(),
            margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900]);
        print(resp.statusCode);
        return [false, response['message']];
      }
    } catch (e) {
      String errorType = e.runtimeType.toString();
      if (errorType == 'SocketException') {
        print(errorType);
      }
    }
    return [false, response['message']];
  }

  Future<String?> login(email, password) async {
    Uri endpoint = Uri.parse(Constants.restApiBaseUrl + '/auth/login');
    print(endpoint);
    print(email.trim());
    print(password);

    try {
      var resp = await http.post(endpoint, body: {
        'email': email.trim(),
        'password': password
      } /*, headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',} */);

      if (resp.statusCode == 200) {
        var response = jsonDecode(resp.body);
        final DataController dataController = Get.find();
        dataController.loginModel = LoginModel.fromJson(response);
        return response['data']['access_token'];
      } else if (resp.statusCode == 401) {
        return null;
      } else {
        print(resp.statusCode);
      }
    } catch (e) {
      String errorType = e.runtimeType.toString();
      if (errorType == 'SocketException') {
        //Make a connected / not connected state true / false ;
        // Get.to(NotConnectedScreen());
      }
    }
    return null;
  }

  Future activation(token, otp) async {
    print(otp);
    Uri endpoint = Uri.parse(Constants.restApiBaseUrl + '/auth/otp');

    try {
      var resp = await http.post(
        endpoint,
        headers: <String, String>{'Authorization': 'Bearer ' + token},
        body: {
          'otp': otp,
        },
      );
      if (resp.statusCode == 200) {
        var jsonData = jsonDecode(resp.body);
        print(jsonData);
        if (jsonData['error'].toString() == 'false') {
          return true;
        } else {
          print("Error");
          Get.snackbar('Error', jsonData['message'].toString(),
              margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900]);

          return false;
        }
      } else if (resp.statusCode == 401) {
        return false;
      } else {
        print(resp.statusCode);
        return false;
      }
    } catch (e) {
      String errorType = e.runtimeType.toString();
      if (errorType == 'SocketException') {
        //  Get.to(NotConnectedScreen());
      }
    }
  }

  Future otpToResetPassword(email) async {
    Uri endpoint = Uri.parse(Constants.restApiBaseUrl + '/auth/sendotpreset');

    var resp = await http.post(
      endpoint,
      headers: <String, String>{'Authorization': 'Bearer ' ''},
      body: {
        'email': email,
      },
    );
    if (resp.statusCode == 200) {
      var jsonData = jsonDecode(resp.body);
      print(jsonData);
      if (jsonData['error'].toString() == 'false') {
        return true;
      } else {
        Get.snackbar('Error', jsonData['message'].toString(),
            margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900]);

        return false;
      }
    } else if (resp.statusCode == 401) {
      Get.snackbar('Error', 'Something went wrong!, Check your internet',
          margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.grey[900]);
      return false;
    } else {
      Get.snackbar('Error', 'Something went wrong!, Check your internet',
          margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.grey[900]);
      return false;
    }
  }

  Future verifyPasswordOTP(email, otp) async {
    print(otp);
    print(email);
    Uri endpoint =
        Uri.parse(Constants.restApiBaseUrl + '/auth/verifypasswordotp');

    try {
      var resp = await http.post(
        endpoint,
        headers: <String, String>{'Authorization': 'Bearer ' ''},
        body: {
          'otp': otp,
          'email': email,
        },
      );
      print(resp.statusCode);
      print(jsonDecode(resp.body));
      if (resp.statusCode == 200) {
        var jsonData = jsonDecode(resp.body);
        print(jsonData);
        if (jsonData['error'].toString() == 'false') {
          return true;
        } else {
          print("Error");
          Get.snackbar('Error', jsonData['message'].toString(),
              margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900]);

          return false;
        }
      } else if (resp.statusCode == 401) {
        return false;
      } else {
        print(resp.statusCode);
        return false;
      }
    } catch (e) {
      String errorType = e.runtimeType.toString();
      if (errorType == 'SocketException') {
        //  Get.to(NotConnectedScreen());
      }
    }
  }

  Future updatePasswordFinal(
      {required String email,
      required String password,
      required String otp}) async {
    Uri endpoint =
        Uri.parse(Constants.restApiBaseUrl + '/auth/updatePasswordfinal');

    var resp = await http.post(
      endpoint,
      headers: <String, String>{'Authorization': 'Bearer ' ''},
      body: {
        'email': email,
        'password': password,
        'otp': otp,
      },
    );
    if (resp.statusCode == 200) {
      var jsonData = jsonDecode(resp.body);
      print(jsonData);
      if (jsonData['error'].toString() == 'false') {
        Get.snackbar('Great', jsonData['message'].toString(),
            margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900]);
        return true;
      } else {
        Get.snackbar('Error', jsonData['message'].toString(),
            margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900]);

        return false;
      }
    } else if (resp.statusCode == 401) {
      Get.snackbar('Error', 'Something went wrong!, Check your internet',
          margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.grey[900]);
      return false;
    } else {
      Get.snackbar('Error', 'Something went wrong!, Check your internet',
          margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.grey[900]);
      return false;
    }
  }

  Future veriff(token, otp) async {
    Uri endpoint = Uri.parse('https://stationapi.veriff.com/v1/sessions/');

    var resp = await http.post(
      endpoint,
      headers: <String, String>{
        'X-AUTH-CLIENT': '26c8a528-741e-4219-bbbb-28a7c5f49cd5',
        'Content-Type': 'application/json'
      },
      body: {
        'verification': {
          'callback': 'https://veriff.com',
          'person': {
            'firstName': 'test',
            'lastName': 'flutter',
          },
          'timestamp': '2016-05-19T08:30:25.597Z'
        }
      },
    );
    if (resp.statusCode == 200) {
      var jsonData = jsonDecode(resp.body);
    } else if (resp.statusCode == 401) {
      return false;
    } else {
      return false;
    }
  }
}
