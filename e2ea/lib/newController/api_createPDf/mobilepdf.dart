import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

Future<void> saveandluch(List<int> bytes, String doc_name) async {
  final path = (await getExternalStorageDirectory()).path;
  final file = File('$path/$doc_name');

  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open('$path/$doc_name');
}
