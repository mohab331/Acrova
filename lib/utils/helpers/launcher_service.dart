import 'package:url_launcher/url_launcher.dart';

class LauncherService {
  Future<void> callNumber(String phoneNumber) async {
    final url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Future<void> openWhatsApp(String phoneNumber) async {
    final url = Uri.parse('https://wa.me/$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> sendEmail(String emailAddress, {String? subject}) async {
    final url = Uri(
      scheme: 'mailto',
      path: emailAddress,
      query: subject != null ? 'subject=$subject' : null,
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}
