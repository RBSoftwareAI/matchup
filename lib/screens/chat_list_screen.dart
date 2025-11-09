import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../data/mock_profiles.dart';
import 'chat_detail_screen.dart';

/// Écran de liste des conversations
class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    
    if (difference.inMinutes < 1) {
      return 'À l\'instant';
    } else if (difference.inMinutes < 60) {
      return 'Il y a ${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return 'Il y a ${difference.inHours}h';
    } else if (difference.inDays == 1) {
      return 'Hier';
    } else {
      return 'Il y a ${difference.inDays}j';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Chat',
          style: TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher une discussion…',
                hintStyle: const TextStyle(color: AppColors.muted),
                prefixIcon: const Icon(Icons.search, color: AppColors.muted),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          
          // Liste des conversations
          Expanded(
            child: mockConversations.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 80,
                          color: AppColors.muted,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Aucune conversation',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: mockConversations.length,
                    itemBuilder: (context, index) {
                      final conversation = mockConversations[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatDetailScreen(conversation: conversation),
                            ),
                          );
                        },
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        leading: Stack(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(conversation.matchAvatar),
                            ),
                            if (conversation.unreadCount > 0)
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 20,
                                    minHeight: 20,
                                  ),
                                  child: Text(
                                    '${conversation.unreadCount}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        title: Text(
                          conversation.matchName,
                          style: TextStyle(
                            fontWeight: conversation.unreadCount > 0 
                                ? FontWeight.w600 
                                : FontWeight.normal,
                            color: AppColors.text,
                          ),
                        ),
                        subtitle: Text(
                          conversation.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: conversation.unreadCount > 0 
                                ? AppColors.text 
                                : AppColors.muted,
                            fontWeight: conversation.unreadCount > 0 
                                ? FontWeight.w500 
                                : FontWeight.normal,
                          ),
                        ),
                        trailing: Text(
                          _formatTime(conversation.lastMessageTime),
                          style: TextStyle(
                            color: conversation.unreadCount > 0 
                                ? AppColors.primary 
                                : AppColors.muted,
                            fontSize: 12,
                            fontWeight: conversation.unreadCount > 0 
                                ? FontWeight.w600 
                                : FontWeight.normal,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
