library ddc.src.codegen.dart_codegen;

import 'dart:async' show Future;
import 'dart:io' as io;

import 'package:analyzer/analyzer.dart' as analyzer;
import 'package:analyzer/src/generated/ast.dart';
import 'package:analyzer/src/generated/java_core.dart' as java_core;
import 'package:dart_style/dart_style.dart';
import 'package:logging/logging.dart' as logger;
import 'package:path/path.dart' as path;

import 'code_generator.dart' as codegenerator;

final _log = new logger.Logger('ddc.dartgenerator');

// TODO(leafp) This is kind of a hack, but it works for now.
class FileWriter extends java_core.PrintStringWriter {
  bool _format;
  String _path;
  FileWriter(this._format, this._path);

  Future finalize() {
    String s = toString();
    if (_format) {
      DartFormatter d = new DartFormatter();
      try {
        s = d.format(s, uri: _path);
      } catch (e) {
        _log.severe("Failed to format $_path", e);
      }
    }
    var file = new io.File(_path);
    file.createSync();
    io.IOSink _sink = file.openWrite();
    _sink.write(s);
    return _sink.close();
  }
}

// TODO(leafp) Not sure if this is the right way to generate
// Dart source going forward, but it's a quick way to get started.
class UnitGenerator extends analyzer.ToSourceVisitor {
  CompilationUnit unit;

  UnitGenerator(this.unit, java_core.PrintWriter out) : super(out);

  void generate() {
    unit.visitChildren(this);
  }
}

class DartGenerator extends codegenerator.CodeGenerator {
  bool _format;

  DartGenerator(String outDir, Uri root, List<LibraryInfo> libraries,
      TypeRules rules, this._format) : super(outDir, root, libraries, rules);

  Future generateUnit(
      CompilationUnitElementImpl unit, LibraryInfo info, String libraryDir) {
    var uri = unit.source.uri;
    _log.info("Generating unit " + uri.toString());
    FileWriter out = new FileWriter(_format, path
        .join(libraryDir, '${uri.pathSeparator.last}'));
    var unitGen = new UnitGenerator(unit.node, out);
    unitGen.generate();
    return out.finalize();
  }
}
