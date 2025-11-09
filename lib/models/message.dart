/// Modèle représentant un message de chat
class Message {
  final String id;
  final String senderId;
  final String senderName;
  final String content;
  final DateTime timestamp;
  final bool isMe;

  const Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.content,
    required this.timestamp,
    required this.isMe,
  });
}

/// Modèle représentant une conversation
class Conversation {
  final String id;
  final String matchId;
  final String matchName;
  final String matchAvatar;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final List<Message> messages;

  const Conversation({
    required this.id,
    required this.matchId,
    required this.matchName,
    required this.matchAvatar,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
    required this.messages,
  });
}
