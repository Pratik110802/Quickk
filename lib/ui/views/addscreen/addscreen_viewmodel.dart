import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/sharedpreference_service.dart';

class AddscreenViewModel extends BaseViewModel {
  //Services
  final _navigationService = locator<NavigationService>(); //Navigation service
  final _sharedpreference =
      locator<SharedpreferenceService>(); //Sharedpreference service
  final String url;
  AddscreenViewModel({required this.url});

  //Textediting controller for name of the quickk url
  TextEditingController quickkname = TextEditingController();

  late bool _isfavorite = false;
  bool get isfavorite => _isfavorite;

  void tofavorite() async {
    if (isfavorite == true) {
      _isfavorite = false;
      notifyListeners();
    } else {
      _isfavorite = true;
      notifyListeners();
    }
  }

  void navigatetoMainScreen() {
    _navigationService.replaceWith(Routes.homeView);
    rebuildUi();
    notifyListeners();
  }

  void addquickk() {
    if (_isfavorite) {
      addfavquick();
    } else {
      addtoallquickk();
    }
  }

  void addtoallquickk() {
    _sharedpreference.setUrl(quickkname.text, url);
    log("The string is added to sharedpreference " +
        url.toString() +
        " for the key " +
        quickkname.text.toString());
    navigatetoMainScreen();
    notifyListeners();
  }

  void addfavquick() {
    _sharedpreference.setUrl('❤️ - ' + quickkname.text, url);
    log("The string is added to sharedpreference  " +
        url.toString() +
        " for the key as Favorite Quickk " +
        '❤️ - ' +
        quickkname.text.toString());
    navigatetoMainScreen();
    notifyListeners();
  }

//Testing purpose

  late String test;
  void changetest() {
    test = url;
    log("The string is added to test" + test.toString());
    navigatetoMainScreen();
    notifyListeners();
  }
}
