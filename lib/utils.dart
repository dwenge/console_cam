library console_cam.utils;

import 'dart:io';

import 'package:escapi/escapi.dart';
import 'package:console/console.dart' as consolePkg;
import 'package:image/image.dart' as imgPkg;
import 'package:path/path.dart' as pathPkg;

extension CaptureImage on Device {
  imgPkg.Image captureImage() => imgPkg.Image.fromBytes(
        params.width,
        params.height,
        capture(),
        format: imgPkg.Format.bgra,
      );
}

extension EncodeImageExt on imgPkg.Image {
  List<int> encodeImageExt(String ext) {
    switch (ext.toUpperCase()) {
      case 'GIF':
        return imgPkg.encodeGif(this);
      case 'BMP':
        return imgPkg.encodeBmp(this);
      // case 'PNG':
      // return encodePng(img);
      case 'JPG':
      default:
        return imgPkg.encodeJpg(this);
    }
  }

  void save(String filename) {
    filename = pathPkg.normalize(filename);
    final ext = pathPkg.extension(filename).substring(1);
    File(filename).writeAsBytesSync(encodeImageExt(ext));
  }
}

extension ConsoleExt on consolePkg.Console {
  static void writeImage(imgPkg.Image img, {bool useSymbols = false}) {
    final bytes = img.getBytes(format: imgPkg.Format.luminance);
    String buf;
    if (useSymbols) {
      buf = List.generate(bytes.length, (index) {
        if (index % img.width == 0) return '\n';
        return '@\$.&\\|uiopasdfghjk":;,._'[bytes[index] ~/ 24];
      }).join();
    } else {
      buf = List.generate(bytes.length, (index) {
        final color = 232 + bytes[index] ~/ 24;
        if (index % img.width == 0) return '\x1b[48;5;${color}m\n';
        return '\x1b[48;5;${color}m ';
      }).join();
    }
    consolePkg.Console.write(buf);
  }
}
