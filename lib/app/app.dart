import 'package:stacked/stacked_annotations.dart';
import 'package:quickk/ui/views/home/home_view.dart';
import 'package:quickk/ui/views/startup/startup_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:quickk/ui/views/urltest/urltest_view.dart';
import 'package:quickk/ui/views/explore/explore_view.dart';

import 'package:quickk/ui/views/addscreen/addscreen_view.dart';

import 'package:quickk/services/sharedpreference_service.dart';
// @stacked-import

@StackedApp(routes: [
  MaterialRoute(page: StartupView),
  MaterialRoute(page: HomeView),
  MaterialRoute(page: UrltestView),
  MaterialRoute(page: ExploreView),
  MaterialRoute(page: AddscreenView),
// @stacked-route
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: DialogService),
  LazySingleton(classType: BottomSheetService),

  LazySingleton(classType: SharedpreferenceService),
// @stacked-service
])
class App {}
