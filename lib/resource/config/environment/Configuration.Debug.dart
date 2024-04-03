import '../../../api/url.dart';
import '../../../utils/common/data.dart';

void debugAppSettings() {
  AppDataGlobal.evironment = 'DEV';
  mainURL = urlConnectAPI["dev"]!;
}
