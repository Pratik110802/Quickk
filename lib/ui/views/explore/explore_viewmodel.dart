import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class ExploreViewModel extends BaseViewModel {
  //Launch the url
  Future<void> launchInApp(String url) async {
    String host = 'https://' + url;
    final Uri uri = Uri.parse(host);

    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      throw "Can not launch $uri";
    }
  }
}
