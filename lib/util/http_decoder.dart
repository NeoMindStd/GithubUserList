import 'dart:convert';

import 'package:http/http.dart';

class HttpDecoder {
  static utf8Response(Response response) =>
      jsonDecode(utf8.decode(response.bodyBytes));
}
