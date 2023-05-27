import 'package:flutter/material.dart';
import 'package:quickk/app/app.router.dart';
import 'package:quickk/ui/common/app_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:quickk/app/app.locator.dart';
import 'package:quickk/enums/bottom_sheet_type.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../enums/dialog_type.dart';
import '../../../services/sharedpreference_service.dart';

class HomeViewModel extends BaseViewModel implements Initialisable {
  final _navigationService = locator<NavigationService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _dialogService = locator<DialogService>();
  final _sharedpreference =
      locator<SharedpreferenceService>(); //Sharedpreference service

  List<String> allquickknames = [];
  List<String> allfavquickks = [];
  List<String> favorites = [];
  FocusNode query = FocusNode();

  @override
  void initialise() {
    super.initialised;
    getallquicks();
    getfavquickks();
    getfavquickksseparate();
    notifyListeners();
  }

  Future<void> refresh() async {
    getallquicks();
    getfavquickks();
    getfavquickksseparate();
    debugPrint(favorites.toString());
    notifyListeners();
    rebuildUi();
  }

  //Search query controller
  TextEditingController querycontroller = TextEditingController();

  //clear the text
  void cleartext() {
    querycontroller.clear();
    query.unfocus();
  }

//Sample google urls
  String google = 'https://www.google.com';

//Launch google in browser
  Future<void> launchgoogleinBrowser() async {
    String host = 'https://www.google.com';
    final Uri uri = Uri.parse(host);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Can not launch $host";
    }
  }

//Search in App

//To update the url entered in textfield
  String q = '';
  void updateurl() {
    String query = querycontroller.text;
    q = query;
  }

//To launch the keyword in App search
  Future<void> launchInApp() async {
    updateurl();
    String host = 'https://www.google.com/search?q=' + q;
    final Uri uri = Uri.parse(host);
    debugPrint(uri.toString());
    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      throw "Can not launch $uri";
    }
  }

  Future getfavquickks() async {
    allfavquickks = await _sharedpreference.getallfavkeys();
    debugPrint(allfavquickks.toString());
    notifyListeners();
  }

  Future getallquicks() async {
    allquickknames = await _sharedpreference.getallkeys();
    debugPrint(allquickknames.toString());
    notifyListeners();
  }

  Future getfavquickksseparate() async {
    favorites = await _sharedpreference.separatefav();
    debugPrint(favorites.toString());
    notifyListeners();
  }

//Test
  String? tolaunch = 'hello';
  Future<void> launchsharedpref(String sharedpref) async {
    final get = await SharedPreferences.getInstance();
    tolaunch = get.getString(sharedpref);
    debugPrint(tolaunch.toString() + "is ready to be launched");
    Future.delayed(const Duration(seconds: 1), () async {
      debugPrint('Time delayed is over');

      final Uri uri = Uri.parse(tolaunch.toString());
      debugPrint(uri.toString() + "is the url to be launched");
      if (!await launchUrl(
        uri,
        mode: LaunchMode.inAppWebView,
      )) {
        throw "Cannnot launch the url";
      }
    });
  }

//Launch any url in browser
  // Future<void> launchInBrowser() async {
  //   String host = 'https://www.google.com';
  //   final Uri uri = Uri.parse(host);

  //   if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
  //     throw "Can not launch $host";
  //   }
  // }

//Dialog to confirm the delete of quickk
  Future<void> deletequickk(String quickkname) async {
    final dialogResult = await _dialogService.showCustomDialog(
      variant: DialogType.confirmDelete,
      title: quickkname,
    );
    if (dialogResult!.confirmed) {
      _sharedpreference.deletequickk(quickkname);
      getallquicks();
      notifyListeners();
    }
  }

  //Bottom sheet to view Favorite quickks
  void showbottomsheet(List<String> data, List<String> favstext) {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.favorite,
      title: 'Favorites ❤️',
      isScrollControlled: true,
      customData: favstext,
      data: favstext,
    );
  }

  // Navigation Service
  void navigatetoexplore(ExploreCard explore) {
    _navigationService.navigateToExploreView(data: explore);
  }

  // Explore list
  List<ExploreCard> explorelist = [
    ExploreCard(
        'Entertainment', Colors.red, entertainment, Icons.phone_android),
    ExploreCard('News', Colors.blue, news, Icons.newspaper),
    ExploreCard('Education', Colors.green, entertainment, Icons.school_sharp),
    ExploreCard('Finance', Colors.grey, finance, Icons.attach_money),
    ExploreCard('Business', Colors.yellow, business, Icons.business),
    ExploreCard('Sports', const Color.fromARGB(255, 2, 54, 102), sports,
        Icons.sports_cricket)
  ];

  static List<ExploreViewdata> entertainment = [
    ExploreViewdata(Colors.purple, 'Instagram', 'www.instagram.com'),
    ExploreViewdata(
        const Color.fromARGB(255, 45, 3, 0), 'Youtube', 'www.youtube.com'),
    ExploreViewdata(Colors.pink, 'Amazon Mini TV', 'www.amazon.in/minitv')
  ];
  static List<ExploreViewdata> news = [
    ExploreViewdata(Colors.white, 'BBC News', 'www.bbc.com'),
    ExploreViewdata(const Color.fromARGB(255, 159, 11, 0), 'Times of India',
        'www.timesofindia.indiatimes.com/'),
  ];
  static List<ExploreViewdata> articles = [
    ExploreViewdata(Colors.purple, 'Medium', 'www.medium.com'),
  ];
  static List<ExploreViewdata> education = [];
  static List<ExploreViewdata> finance = [];
  static List<ExploreViewdata> business = [];
  static List<ExploreViewdata> sports = [];
}
