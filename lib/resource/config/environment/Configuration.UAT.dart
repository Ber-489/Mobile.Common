import '../../../api/url.dart';
import '../../../utils/common/data.dart';

void uatAppSettings() {
  AppDataGlobal.evironment = 'UAT';
  mainURL = urlConnectAPI["uat"]!;
}
