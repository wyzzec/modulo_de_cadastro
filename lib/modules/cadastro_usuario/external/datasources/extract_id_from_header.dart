class ExtractIdFromHeader {
  int call(String header) {
    List<String> split = header.split('/');
    return int.parse(split.last);
  }
}