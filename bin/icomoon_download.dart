import 'dart:io';

import 'package:icomoon/configs/pubspec_config.dart';
import 'package:icomoon/icomoon.dart';
import 'package:args/args.dart' as args;

void main(List<String> arguments) async {
  late final String? outputDir;
  late final bool? isTemp;
  late final String? projectName;
  late final String? hostId;
  late final String? className;

  final PubspecConfig pubspecConfig;
  try {
    pubspecConfig = PubspecConfig.load();
  } on Exception catch (e) {
    exitWithError(e.toString());
    return;
  }

  final argParser = args.ArgParser()
    ..addOption(
      'output-dir',
      help: 'Directory of dart fonts file',
      callback: (x) => outputDir = x,
      defaultsTo: pubspecConfig.outputDir,
    )
    ..addFlag(
      'temp',
      abbr: 't',
      help: 'Flag that means have you paid subscription or are using temp url',
      defaultsTo: pubspecConfig.isTemp,
      negatable: false,
      callback: (x) => isTemp = x,
    )
    ..addOption(
      'project',
      help: 'Name of the project on icomoon',
      defaultsTo: pubspecConfig.projectName,
      callback: (x) => projectName = x,
    )
    ..addOption(
      'host',
      help:
          'Id of host. Should be passed every time if is used free version of icommon',
      callback: (x) => hostId = x,
      defaultsTo: pubspecConfig.hostId,
    )
    ..addOption(
      'class-name',
      help: 'Name of generated class',
      callback: (x) => className = x,
      defaultsTo: pubspecConfig.className,
    );

  try {
    argParser.parse(arguments);
  } on args.ArgParserException catch (e) {
    exitWithError('${e.message}\n\n${argParser.usage}');
  }

  try {
    await Icomoon.generate(
      hostId: ArgumentError.checkNotNull(hostId, 'host'),
      projectName: ArgumentError.checkNotNull(projectName, 'project'),
      outputDir: ArgumentError.checkNotNull(outputDir, 'output-dir'),
      isTemp: ArgumentError.checkNotNull(isTemp, 'temp'),
      packageName: pubspecConfig.name,
      fonts: pubspecConfig.fonts,
      className: className ?? 'AppIcons',
    );
  } on ArgumentError catch (e) {
    exitWithError(e.toString());
  }
}

void exitWithError(String message) {
  stderr.writeln(message);
  exit(2);
}
