import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GPT {
  String link = "https://api.openai.com/v1/chat/completions";
  String key = dotenv.env["chatgptUrl"]!;

  Future<String> getChatAnswer(String prompt) async {
    final uri = Uri.parse(link);
    String answer = "empty";
    final request = await http
        .post(uri,
            headers: {
              "Authorization": "Bearer $key",
              "Content-Type": "application/json"
            },
            body: jsonEncode(
              {
                "model": "gpt-3.5-turbo",
                "messages": [
                  {
                    "role": "system",
                    "content":
                        "أنت صيدلي وطبيب وسيطرح عليك مريضك بعض الأسئلة حول الأدوية والفيتامينات والامور والنصائح الطبية وعليك أن تعطيه إجابة قصيرة ,وإلا فسوف تجيب  \"اسف انا هنا فقط لمساعدتك بنصائح طبية  \"",
                  },
                  {
                    "role": "user",
                    "content": prompt,
                  }
                ]
              },
            ))
        .then((value) {
      print("Answer: ${value.body}");
      final response = jsonDecode(utf8.decode(value.bodyBytes));
      print(response);
      answer = response["choices"][0]["message"]["content"];
    });

    return answer;
  }
}
