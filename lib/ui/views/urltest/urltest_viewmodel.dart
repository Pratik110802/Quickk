import 'dart:async';
import 'dart:developer';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UrltestViewModel extends BaseViewModel {
  TextEditingController title = TextEditingController();
  TextEditingController url = TextEditingController();

  List<String> urls = [];

  //Item count test var

  int count = 1;
  void increment() {
    count++;
    notifyListeners();
  }

  void decrement() {
    count--;
    notifyListeners();
  }

  //Shared preferences
  String? intenturl = "https://www.google.com";
  String name = '';

  // Future<void> incomingurlfetch() async {
  //   url.text = data!;
  //   notifyListeners();
  // }

  // Future<void> setUrl() async {
  //   name = title.text;
  //   final pref = await SharedPreferences.getInstance();
  //   if (data == null) {
  //     log("No data is received");
  //   } else {
  //     log(title.text +
  //         "is added as key in shared preferences for" +
  //         data.toString());

  //     pref.setString(name, data!);
  //   }
  // }

  Future<void> getUrl() async {
    Future.delayed(const Duration(seconds: 2), () async {
      final get = await SharedPreferences.getInstance();

      intenturl = get.getString(name);
      log("Getting the url for $name as " + intenturl.toString());
      notifyListeners();
    });
  }

  String? tolaunch = 'hello';

  Future<void> launchsharedpref(String sharedpref) async {
    final get = await SharedPreferences.getInstance();
    tolaunch = get.getString(sharedpref);
    log(tolaunch.toString() + "is ready to be launched");
    Future.delayed(const Duration(seconds: 1), () async {
      log('Time delayed is over');

      final Uri uri = Uri.parse(tolaunch.toString());
      log(uri.toString() + "is the url to be launched");
      if (!await launchUrl(
        uri,
        mode: LaunchMode.inAppWebView,
      )) {
        throw "Cannnot launch the url";
      }
    });
  }

  Future<void> removekey(String key) async {
    final pref = await SharedPreferences.getInstance();
    pref.remove(key);
    log(key + "is removed from shared preferences");
    getallkeys();
  }

  //Get all keys
  Future<void> getallkeys() async {
    final pref = await SharedPreferences.getInstance();

    urls = pref.getKeys().where((String key) => key != null).toList();
    log(urls.toString());
    notifyListeners();
  }

  //Url launcher testings
  var querycontroller = TextEditingController();
  var numbercontroller = TextEditingController();
  late String whatsappnumber = '7387579748';
  late String call = '7387579748';
  void updatepnumber() {
    call = 'tel:' '+91' + numbercontroller.text;
    whatsappnumber = 'https://wa.me/' + numbercontroller.text;
    log('updated');
  }

  void clearurl() {
    querycontroller.clear();
  }

  String q = '';
  void updateurl() {
    String query = querycontroller.text;
    q = query;
  }

  String google = 'https://www.google.com';

  Future<void> launchInApp() async {
    updateurl();
    String host = 'https://www.google.com/search?q=' + q;
    final Uri uri = Uri.parse(host);
    log(uri.toString());
    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      throw "Can not launch url";
    }
  }

  Future<void> launchIntentUrl() async {
    final Uri uri = Uri.parse(intenturl.toString());
    log(uri.toString());
    if (!await launchUrl(
      uri,
      mode: LaunchMode.inAppWebView,
    )) {
      throw "Cannnot launch the url";
    }
  }

  String host = 'https://www.google.com';

  Future<void> launchInBrowser(String data) async {
    final Uri uri = Uri.parse(host);
    log(uri.toString());
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Can not launch $host";
    }
  }

  // Future<void> makePhoneCall(String url) async {
  //   updatepnumber();

  //   if (!await launchUrlString(url)) {
  //     throw "Cannot launch whatsapp";
  //   }
  // }

  // Future<void> whatsapp(String url) async {
  //   updatepnumber();
  //   final Uri uri = Uri.parse(url);
  //   if (!await launchUrl(uri)) {
  //     throw "Cannot launch whatsapp";
  //   }
  // }
}
