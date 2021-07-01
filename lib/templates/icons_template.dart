import 'package:icomoon/models/icon.dart';

class IconsTemplate {
  IconsTemplate._();

  static String generateFontFile(
    List<Icon> icons,
    String fontFamily,
    String package,
    String className,
  ) {
    return '''
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';

abstract class $className {
  ${icons.map((icon) => 'static const ${icon.name} = _IconData(${icon.code});').join('\n  ')}
}

class _IconData extends IconData {
  const _IconData(int codePoint)
    : super(
        codePoint,
        fontFamily: '$fontFamily',
        fontPackage: '$package',
  );
}
''';
  }
}
