import 'package:icomoon/api/icomoon_client.dart';
import 'package:icomoon/project.dart';

import 'models/font.dart';
import 'templates/icons_template.dart';

abstract class Icomoon {
  static Future<void> generate({
    required String hostId,
    required String projectName,
    required String outputDir,
    required bool isTemp,
    required String packageName,
    required List<Font> fonts,
    required String className,
  }) async {
    final project = Project();

    final client = IcomoonClient(isTemp, hostId, projectName);

    final selection = await client.getSelection();

    final ttf = await client.getTTF(selection.name);
    final ttfPath =
        fonts.singleWhere((font) => font.family == selection.name).assets.first;

    final ttfFile = await project.createFontFile(ttfPath);
    await ttfFile.writeAsBytes(ttf!);

    final fileContent = IconsTemplate.generateFontFile(
      selection.icons,
      selection.name,
      packageName,
      className,
    );

    final file = await project.createDartFileForIcons(
      outputDir,
      selection.name.toLowerCase(),
    );
    await file.writeAsString(fileContent);
  }
}
