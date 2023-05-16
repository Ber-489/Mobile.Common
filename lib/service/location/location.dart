// import 'dart:async';
//
// import 'package:get/get.dart';
// import 'package:location/location.dart';
// import 'package:thacoloyalty/utils/common/data.dart';
// import 'package:thacoloyalty/utils/widget/popup/custom_popup.dart';
//
// class LocationService {
//   bool isShowSnackBar;
//
//   LocationService({this.isShowSnackBar = true});
//
//   Location location = Location();
//
//   Future<bool> checkPermission() async {
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;
//
//     /// Check service location in device is available or not
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return false;
//       }
//     }
//
//     /// Check permission is granted or denied
//     _permissionGranted = await location.hasPermission();
//
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         if (isShowSnackBar)
//           await CustomPopup.showSnackBar(
//               title: 'Có lỗi xảy ra', message: 'failed_finding_location'.tr);
//         return false;
//       }
//     }
//
//     return true;
//   }
//
//   //Check vs get permission
//   Future<void> getLocation() async {
//     if (!(await checkPermission())) return;
//
//     /// Get location
//     unawaited(Future(
//         () async {
//           AppDataGlobal.location = await location.getLocation();
//     }));
//     return;
//   }
// }
