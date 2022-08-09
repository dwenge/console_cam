import 'package:args/command_runner.dart' as cr;
import 'package:logging/logging.dart';

abstract class Command<T> extends cr.Command<T> {
  Logger? _log;

  Logger _getLogger() {
    if (parent != null && (parent is Command)) {}
    _log ??= Logger(name);
    return _log!;
  }

  Logger get log => _getLogger();
}
