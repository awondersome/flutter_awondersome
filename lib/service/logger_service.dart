import 'package:logger/logger.dart';

class LoggerService {
  static LoggerService? _instance;

  factory LoggerService() {
    _instance ??= LoggerService._internal();
    return _instance!;
  }

  LoggerService._internal() {
    _logger = Logger();
  }
  Logger get logger => _logger;
  static late Logger _logger;
}
