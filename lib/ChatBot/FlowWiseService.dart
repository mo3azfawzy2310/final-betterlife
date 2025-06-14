import 'package:http/http.dart' as http;
import 'dart:convert';

class FlowiseService {
  static const String chatbotUrl =
      'https://cloud.flowiseai.com/api/v1/prediction/95832782-11c9-4c77-a59e-71eff19cb60e';

  Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse(chatbotUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'question': message,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['text'] ?? 'No response received';
      } else {
        throw Exception('Failed to get response: ${response.statusCode}');
      }
    } catch (e) {
      return 'Error: Unable to connect to chatbot. Please try again.';
    }
  }
}
