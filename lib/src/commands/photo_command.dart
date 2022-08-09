import 'dart:async';
import 'dart:io';

import 'package:escapi/escapi.dart';
import 'package:console/console.dart';
import 'package:image/image.dart';

import 'base.dart';
import 'package:console_cam/utils.dart';

class PhotoCommand extends Command {
  PhotoCommand() {
    argParser
      ..addOption(
        'out',
        abbr: 'o',
        help: 'Выходной файл',
      )
      ..addOption(
        'width',
        abbr: 'x',
        help: 'Ширина выходного фала',
        valueHelp: '320 | 640 | 1280',
        defaultsTo: '320',
      )
      ..addOption(
        'height',
        abbr: 'y',
        help: 'Высота выходного файла',
        valueHelp: '240 | 480 | 720',
        defaultsTo: '240',
      )
      ..addFlag('view', help: 'Вывод изображения в консоль', defaultsTo: true)
      ..addFlag(
        'symbols',
        abbr: 's',
        help: 'Выводить изображение символами',
      );
  }

  @override
  String get name => 'photo';

  @override
  String get description => 'Сделать фото';

  @override
  List<String> get aliases => ['p'];

  @override
  FutureOr? run() {
    final w = int.tryParse(argResults?['width']) ?? 320;
    final h = int.tryParse(argResults?['height']) ?? 240;
    final String out = argResults?['out'] ?? '';
    final bool view = argResults?['view'] ?? false;
    final bool symbols = argResults?['symbols'] ?? false;

    final ep = Escapi();
    final device = ep.initCapture(w, h);

    if (device != null) {
      log.fine('Device created: ${device.index}');
      try {
        var img = device.captureImage();
        if (out.isNotEmpty) {
          img.save(out);
          log.info('Файл сохранен "$out"');
        }
        if (view) {
          Console.nextLine();
          if (w > Console.columns || h > Console.rows) {
            img = copyResize(img, width: Console.columns, height: Console.rows);
          }
          ConsoleExt.writeImage(img, useSymbols: symbols);
          Console.resetBackgroundColor();
        }
      } catch (_) {
        rethrow;
      } finally {
        device.free();
        log.fine('Device free');
      }
    } else {
      log.warning('Fail create device');
    }
  }
}
