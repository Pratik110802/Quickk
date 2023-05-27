import 'dart:async';
import 'dart:developer';
import 'package:quickk/app/app.locator.dart';
import 'package:quickk/app/app.router.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel implements Initialisable {
  final _navigationService = locator<NavigationService>();

  bool isintentavailable = false;

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    navigation();
    notifyListeners();
  }

  Future navigation() async {
    Future.delayed(const Duration(seconds: 2), () {
      if (data != null) {
        log(data.toString());
        _navigationService.replaceWithAddscreenView(url: data!);
      } else {
        log(data.toString());

        _navigationService.replaceWithHomeView();
      }
    });
  }

  //Flutter intent in app
  late StreamSubscription intentData;
  String? data;

  @override
  void initialise() {
    super.initialised;
    intentData = ReceiveSharingIntent.getTextStream().listen((String value) {
      data = value;
      notifyListeners();
    });

    ReceiveSharingIntent.getInitialText().then((value) {
      data = value;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    intentData.cancel();
    super.dispose();
  }
}
