import 'package:console_cam/console_cam.dart';
import 'package:logging/logging.dart';

void main(List<String> args) {
  try {
    App().run(args);
  } catch (e, s) {
    Logger.root.shout(null, e, s);
  }
}
