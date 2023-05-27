import 'package:flutter/material.dart';
import 'package:quickk/ui/common/app_colors.dart';
import 'package:quickk/ui/common/ui_helpers.dart';
import 'package:stacked_services/stacked_services.dart';

const double _graphicSize = 60;

class ConfirmDeleteDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const ConfirmDeleteDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: kcMediumGrey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure you want to delete ' +
                  request.title.toString() +
                  ' ?',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w300,
              ),
            ),
            verticalSpaceMedium,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    completer(DialogResponse(confirmed: true));
                    SnackBar delete = SnackBar(
                      content: Text(
                        'Deleteing Quickk ' + request.title.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic),
                      ),
                      backgroundColor: Colors.red,
                      elevation: 10,
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.all(5),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(delete);
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: _graphicSize,
                  ),
                ),
                horizontalSpaceSmall,
                GestureDetector(
                  onTap: () => completer(DialogResponse(confirmed: false)),
                  child: const Icon(
                    Icons.cancel,
                    color: Colors.green,
                    size: _graphicSize,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
