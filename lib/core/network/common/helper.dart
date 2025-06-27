class Helper {
  static String getMessageFromException(Exception e) {
    final error = e.toString();
    final extracted =
        error.contains('-') ? error.split('-').sublist(1).join('-').trim() : error;
    return extracted;
  }
}
