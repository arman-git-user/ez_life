import 'package:ez_life/repository/ai_chat_repo.dart';
import 'package:flutter/foundation.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  ChatMessage({required this.text, required this.isUser});
}

class AiChatViewModel extends ChangeNotifier {
  final _myRepo = AiChatRepo();

  final List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => _messages;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> promptAI({required String displayText, required String fullPrompt}) async {
    // Add only the user's visible text to the chat history
    _messages.add(ChatMessage(text: displayText, isUser: true));
    _loading = true;
    notifyListeners();

    try {
      // Send the full context to the AI repository
      final response = await _myRepo.promptAI(fullPrompt);

      _messages.add(ChatMessage(text: response.toString(), isUser: false));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      _messages.add(ChatMessage(text: "Sorry, something went wrong.", isUser: false));
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
