import 'package:http/http.dart' as http;

class RescueRequestService {
  Future<void> sendRescueRequest(String userId, double lat, double lng) async {
    final response = await http.post(
      Uri.parse('https://your-api.com/rescue'),
      body: {
        'userId': userId,
        'lat': lat.toString(),
        'lng': lng.toString(),
      },
    );

    if (response.statusCode != 200) {
      throw 'Failed to send request';
    }
  }
}
