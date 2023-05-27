import 'package:quickk/app/app.locator.dart';
import 'package:quickk/enums/dialog_type.dart';
import 'package:quickk/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:quickk/ui/dialogs/confirm_delete/confirm_delete_dialog.dart';
// @stacked-import

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<dynamic, DialogBuilder> builders = {
    DialogType.infoAlert: (context, request, completer) =>
        InfoAlertDialog(request: request, completer: completer),
    DialogType.confirmDelete: (context, request, completer) =>
        ConfirmDeleteDialog(completer: completer, request: request),
// @stacked-dialog-builder
  };

  dialogService.registerCustomDialogBuilders(builders);
}
