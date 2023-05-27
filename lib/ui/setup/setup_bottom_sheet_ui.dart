import 'package:quickk/app/app.locator.dart';
import 'package:quickk/enums/bottom_sheet_type.dart';
import 'package:quickk/ui/bottom_sheets/notice/favorite_sheet.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();

  final Map<dynamic, SheetBuilder> builders = {
    BottomSheetType.favorite: (context, request, completer) =>
        FavoriteSheet(completer: completer, request: request),
    // @stacked-bottom-sheet-builder
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}
