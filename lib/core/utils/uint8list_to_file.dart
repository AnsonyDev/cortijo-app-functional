import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<File> uint8ListToFile(Uint8List uint8List) async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  final uniqueFileName =
      '${DateTime.now().millisecondsSinceEpoch}.dat'; // Genera un nombre de archivo único

  final file = File('${documentsDirectory.path}/$uniqueFileName');
  await file.writeAsBytes(uint8List);

  return file;
}
