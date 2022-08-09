import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:logging/logging.dart';

import 'package:console_cam/src/commands/video_command.dart';
import 'package:console_cam/src/commands/photo_command.dart';

class App {
  final CommandRunner _runner;

  App()
      : _runner = CommandRunner(
          'console_cam',
          'Консолькое приложения для работы с камерой',
        ) {
    _init();

    _runner
      ..addCommand(PhotoCommand())
      ..addCommand(VideoCommand())
      ..argParser.addFlag(
        'verbose',
        abbr: 'v',
        help: 'Полное логирование',
        callback: (verbose) {
          if (verbose) Logger.root.level = Level.ALL;
        },
      );
  }

  void _init() {
    Logger.root.onRecord.listen((record) {
      print(
        '[${record.loggerName}][${record.level.name}][${record.time}]'
        ' ${record.message}',
      );
    });
  }

  Future run(Iterable<String> args) {
    return _runner.run(args)
      ..catchError((error) {
        if (error is! UsageException) throw error;
        print(error);
        exit(64);
      });
  }
}
