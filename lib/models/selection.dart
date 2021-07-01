import 'icon.dart';

class Selection {
  final String name;
  final List<Icon> icons;

  Selection(this.name, this.icons);

  factory Selection.fromJson(Map<String, dynamic> json) {
    final name = json['metadata']['name'];
    final icons = (json['icons'] as List<dynamic>)
        .map((x) => Icon.fromJson(x['properties']))
        .toList();

    return Selection(name, icons);
  }
}
