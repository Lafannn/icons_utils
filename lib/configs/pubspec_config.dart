import 'package:icomoon/models/font.dart';
import 'package:icomoon/project.dart';
import 'package:yaml/yaml.dart' as yaml;

class PubspecConfig {
  final String name;
  final List<Font> fonts;
  final String outputDir;
  final String? hostId;
  final bool? isTemp;
  final String? projectName;
  final String? className;

  PubspecConfig(
    this.name,
    this.fonts,
    this.outputDir,
    this.projectName,
    this.hostId,
    this.isTemp,
    this.className,
  );

  factory PubspecConfig.load() {
    final file = Project().getPubspecFile()!;
    final fileContent = file.readAsStringSync();
    final pubspecYaml = yaml.loadYaml(fileContent) as yaml.YamlMap;
    final name = pubspecYaml['name'];
    final pubspecFonts = pubspecYaml['flutter']['fonts'] as yaml.YamlList;
    final fonts = pubspecFonts
        .map(
          (font) => Font(
            font['family'],
            (font['fonts'] as yaml.YamlList)
                .map((x) => x['asset'] as String)
                .toList(),
          ),
        )
        .toList();

    final flutterIconsConfig = pubspecYaml['flutter_icons'];
    if (flutterIconsConfig == null) {
      throw Exception('Add to pubspec.yaml flutter_icons section');
    }

    return PubspecConfig(
      name,
      fonts,
      flutterIconsConfig['output_dir'],
      flutterIconsConfig['project'],
      flutterIconsConfig['host'],
      flutterIconsConfig['temp'],
      flutterIconsConfig['class-name'],
    );
  }
}
