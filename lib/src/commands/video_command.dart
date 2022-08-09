import 'dart:async';
import 'dart:io';

import 'package:console/console.dart';
import 'package:escapi/escapi.dart';

import 'base.dart';
import 'package:console_cam/utils.dart';

class VideoCommand extends Command {
  @override
  String get name => 'video';

  @override
  String get description => 'Видео';

  @override
  List<String> get aliases => ['v'];

  Device? device;

  VideoCommand() {
    argParser
      ..addOption(
        'fps',
        defaultsTo: '24',
      )
      ..addFlag(
        'symbols',
        abbr: 's',
        help: 'Использовать символы',
      );
  }

  @override
  FutureOr? run() {
    final fps = int.tryParse(argResults?['fps']) ?? 24;
    final symbols = argResults?['symbols'] ?? false;

    final ep = Escapi();
    device = ep.initCapture(Console.columns, Console.rows - 1);
    if (device != null) {
      ProcessSignal.sigint.watch().listen((event) {
        device?.free();
      });
      Console.hideCursor();

      Timer.periodic(Duration(milliseconds: 1000 ~/ fps), (_) {
        Console.eraseDisplay();
        Console.moveCursor(row: 0, column: 0);
        ConsoleExt.writeImage(device!.captureImage(), useSymbols: symbols);
      });
    } else {}
  }
}
