extension StringExtension on String {
  // 全て小文字の文字列をUpperCamelCaseに変換するメソッド
  String toUpperCamelCase() {
    return replaceAllMapped(RegExp(r'(^\w)|(_\w)'), (Match match) {
      return match.group(0)!.toUpperCase();
    });
  }

  String convertToJson() {
    var str = this;
    str = str.toString().replaceAll('{', '{"');
    str = str.toString().replaceAll(': ', '": "');
    str = str.toString().replaceAll(', ', '", "');
    str = str.toString().replaceAll('}', '"}');
    return str;
  }
}
