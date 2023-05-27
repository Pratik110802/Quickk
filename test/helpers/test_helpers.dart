import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quickk/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';


import 'package:quickk/services/sharedpreference_service.dart';
// @stacked-import

@GenerateMocks([], customMocks: [
  MockSpec<NavigationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<BottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DialogService>(onMissingStub: OnMissingStub.returnDefault),

  

MockSpec<SharedpreferenceService>(onMissingStub: OnMissingStub.returnDefault),
// @stacked-mock-spec
])
void registerServices() {
  getAndRegisterNavigationService();
  getAndRegisterBottomSheetService();
  getAndRegisterDialogService();
 
getAndRegisterDatabaseService();
getAndRegisterSharedpreferenceService();
// @stacked-mock-register
}

MockNavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

class MockNavigationService {
}

MockBottomSheetService getAndRegisterBottomSheetService<T>({
  SheetResponse<T>? showCustomSheetResponse,
}) {
  _removeRegistrationIfExists<BottomSheetService>();
  final service = MockBottomSheetService();

  when(service.showCustomSheet<T, T>(
    enableDrag: anyNamed('enableDrag'),
    enterBottomSheetDuration: anyNamed('enterBottomSheetDuration'),
    exitBottomSheetDuration: anyNamed('exitBottomSheetDuration'),
    ignoreSafeArea: anyNamed('ignoreSafeArea'),
    isScrollControlled: anyNamed('isScrollControlled'),
    barrierDismissible: anyNamed('barrierDismissible'),
    additionalButtonTitle: anyNamed('additionalButtonTitle'),
    variant: anyNamed('variant'),
    title: anyNamed('title'),
    hasImage: anyNamed('hasImage'),
    imageUrl: anyNamed('imageUrl'),
    showIconInMainButton: anyNamed('showIconInMainButton'),
    mainButtonTitle: anyNamed('mainButtonTitle'),
    showIconInSecondaryButton: anyNamed('showIconInSecondaryButton'),
    secondaryButtonTitle: anyNamed('secondaryButtonTitle'),
    showIconInAdditionalButton: anyNamed('showIconInAdditionalButton'),
    takesInput: anyNamed('takesInput'),
    barrierColor: anyNamed('barrierColor'),
    barrierLabel: anyNamed('barrierLabel'),
    customData: anyNamed('customData'),
    data: anyNamed('data'),
    description: anyNamed('description'),
  )).thenAnswer((realInvocation) =>
      Future.value(showCustomSheetResponse ?? SheetResponse<T>()));

  locator.registerSingleton<BottomSheetService>(service);
  return service;
}

class MockBottomSheetService {
}

MockDialogService getAndRegisterDialogService() {
  _removeRegistrationIfExists<DialogService>();
  final service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

  return service;
}





MockMigrationserviceService getAndRegisterMigrationserviceService() {
  _removeRegistrationIfExists<MigrationserviceService>();
  final service = MockMigrationserviceService();
  locator.registerSingleton<MigrationserviceService>(service);
  return service;
}

MockDatabaseMigrationService getAndRegisterDatabaseMigrationService() {
  _removeRegistrationIfExists<DatabaseMigrationService>();
  final service = MockDatabaseMigrationService();
  locator.registerSingleton<DatabaseMigrationService>(service);
  return service;
}
MockDatabaseService getAndRegisterDatabaseService() { 
_removeRegistrationIfExists<DatabaseService>(); 
final service = MockDatabaseService(); 
locator.registerSingleton<DatabaseService>(service); 
return service; 
}
MockSharedpreferenceService getAndRegisterSharedpreferenceService() { 
_removeRegistrationIfExists<SharedpreferenceService>(); 
final service = MockSharedpreferenceService(); 
locator.registerSingleton<SharedpreferenceService>(service); 
return service; 
}
// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}