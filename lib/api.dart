abstract class Api {
  Stream<String> request(String resource, [String id = ""]);
}
