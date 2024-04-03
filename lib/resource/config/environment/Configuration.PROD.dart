import '../../../api/url.dart';
import '../../../utils/common/data.dart';

void productAppSettings() {
  AppDataGlobal.evironment = 'PROD';
  mainURL = urlConnectAPI["prod"]!;
}
