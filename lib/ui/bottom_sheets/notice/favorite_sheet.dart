import 'package:flutter/material.dart';
import 'package:quickk/ui/common/app_colors.dart';
import 'package:stacked_services/stacked_services.dart';

class FavoriteSheet extends StatelessWidget {
  final Function(SheetResponse)? completer;
  final SheetRequest request;
  const FavoriteSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: kcDarkGreyColor),
        height: 200,
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 10),
              child: Text(
                'Favorites ❤️',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 80,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: request.data.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              completer!(SheetResponse(
                                  confirmed: true, responseData: request.data));
                            },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Text(request.customData[index].toString()),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.red,
                              ),
                              height: 80,
                              width: 80,
                            ),
                          ),
                        )),
              ),
            ),
          ],
        ));
  }
}
