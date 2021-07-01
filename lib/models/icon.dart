class Icon {
  final String name;
  final int code;

  Icon(this.name, this.code);

  factory Icon.fromJson(Map<String, dynamic> json) {
    return Icon(json['name'], json['code']);
  }
}
