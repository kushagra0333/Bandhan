import 'package:flutter/material.dart';
import '../components/main_nav.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  String? _activeUser;
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, String>> _users = [
    {
      'name': 'Rohan Kumar',
      'lastMessage': 'Hello! How are you?',
      'time': '10:30 AM',
    },
    {
      'name': 'Anita Sharma',
      'lastMessage': 'Let’s connect soon',
      'time': '09:15 AM',
    },
    {
      'name': 'Family Admin',
      'lastMessage': 'Meeting scheduled tomorrow',
      'time': 'Yesterday',
    },
  ];

  final List<Map<String, dynamic>> _messages = [
    {'text': 'Hello!', 'isMe': false},
    {'text': 'Hi, how are you?', 'isMe': true},
    {'text': 'I’m good, thanks!', 'isMe': false},
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add({'text': _controller.text, 'isMe': true});
      _controller.clear();
    });
  }

  void _openChat(String user) {
    setState(() {
      _activeUser = user;
    });
  }

  void _closeChat() {
    setState(() {
      _activeUser = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: _activeUser != null
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: _closeChat,
              )
            : null,
        title: _activeUser == null
            ? const Text(
                'Messages',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              )
            : Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: const Color(0xFFFFEBEE),
                    child: Text(
                      _activeUser![0],
                      style: const TextStyle(
                        color: Color(0xFFE91E63),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    _activeUser!,
                    style: const TextStyle(
                      color: Colors.black87, // ✅ gray name
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
        actions: _activeUser == null
            ? const [
                Icon(Icons.search, color: Colors.black),
                SizedBox(width: 16),
              ]
            : [],
      ),

      // ================= BODY =================
      body: _activeUser == null ? _buildChatList() : _buildChat(),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: const BottomNavBar(selectedIndex: 3),
    );
  }

  // ================= CHAT LIST =================
  Widget _buildChatList() {
    return ListView.separated(
      itemCount: _users.length,
      separatorBuilder: (_, __) =>
          const Divider(height: 1, color: Colors.black12),
      itemBuilder: (context, index) {
        final user = _users[index];
        return InkWell(
          onTap: () => _openChat(user['name']!),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: const Color(0xFFFFEBEE),
                  child: Text(
                    user['name']![0],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFE91E63),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user['name']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87, // ✅ gray name
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user['lastMessage']!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  user['time']!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ================= CHAT UI =================
  Widget _buildChat() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final msg = _messages[index];
              return Align(
                alignment: msg['isMe']
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: msg['isMe']
                        ? const Color(0xFFE91E63)
                        : const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    msg['text'],
                    style: TextStyle(
                      fontSize: 15,
                      color:
                          msg['isMe'] ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // ================= INPUT =================
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: const Color(0xFFE91E63),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
