  import 'package:george/app/utils/app_log.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openWhatsApp(String phoneNumber) async {
    final String sanitizedNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');
    final Uri whatsappUri = Uri.parse('https://wa.me/$sanitizedNumber');

    try {
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri);
      } else {
        throw 'Could not launch $whatsappUri';
      }
    } catch (e) {
      errorLog('WhatsApp', e);
      Get.snackbar('Error', 'Could not open WhatsApp. Please try again.');
    }
  }