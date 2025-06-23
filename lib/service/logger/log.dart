import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LogCustoms {
  late Logger logger;
  late File logAPIFile;
  late File logFlowFile;
  late File logAPIServerFile;

  void initLog() async {
    if (kDebugMode) {
      print('************** Logs Init **************');
    }
    logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        // Hiển thị 2 dòng của stack trace
        errorMethodCount: 8,
        // Hiển thị stack trace chi tiết khi có lỗi
        lineLength: 120,
        // Giới hạn độ dài mỗi dòng
        colors: true,
        // Bật màu sắc
        printEmojis: true,
        // Thêm emoji vào log
        printTime: true, // Không hiển thị thời gian
      ),
    );
  }
}
