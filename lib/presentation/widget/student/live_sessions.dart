import 'package:flutter/material.dart';

class LiveSession {
  final String id;
  final String title;
  final String subject;
  final String teacherName;
  final DateTime startTime;
  final DateTime endTime;
  final String description;
  final bool isStarted;

  LiveSession({
    required this.id,
    required this.title,
    required this.subject,
    required this.teacherName,
    required this.startTime,
    required this.endTime,
    required this.description,
    this.isStarted = false,
  });
}

class LiveSessionsList extends StatelessWidget {
  const LiveSessionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'À venir'),
              Tab(text: 'En cours'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _LiveSessionList(upcoming: true),
                _LiveSessionList(upcoming: false),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LiveSessionList extends StatelessWidget {
  final bool upcoming;

  const _LiveSessionList({required this.upcoming});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) => LiveSessionCard(
        session: LiveSession(
          id: '1',
          title: 'Révisions Mathématiques',
          subject: 'Mathématiques',
          teacherName: 'M. Dupont',
          startTime: DateTime.now().add(upcoming ? const Duration(days: 1) : Duration.zero),
          endTime: DateTime.now().add(upcoming ? const Duration(days: 1, hours: 1) : const Duration(hours: 1)),
          description: 'Session de révision des concepts clés',
          isStarted: !upcoming,
        ),
      ),
      itemCount: 5,
    );
  }
}

class LiveSessionCard extends StatelessWidget {
  final LiveSession session;

  const LiveSessionCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    session.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Chip(
                  label: Text(
                    session.isStarted ? 'En cours' : 'À venir',
                    style: TextStyle(
                      color: session.isStarted ? Colors.white : null,
                    ),
                  ),
                  backgroundColor: session.isStarted ? Colors.green : null,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Prof: ${session.teacherName}'),
            Text('Matière: ${session.subject}'),
            const SizedBox(height: 8),
            Text(
              session.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Début: ${_formatDateTime(session.startTime)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                ElevatedButton(
                  onPressed: session.isStarted
                      ? () => _joinSession(context, session)
                      : null,
                  child: Text(session.isStarted ? 'Rejoindre' : 'En attente'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month} ${dateTime.hour}:${dateTime.minute}';
  }

  void _joinSession(BuildContext context, LiveSession session) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LiveSessionScreen(session: session),
      ),
    );
  }
}

class LiveSessionScreen extends StatelessWidget {
  final LiveSession session;

  const LiveSessionScreen({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(session.title)),
      body: Column(
        children: [
          // Zone de streaming/vidéo
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.black87,
              child: const Center(
                child: Icon(Icons.video_call, size: 64, color: Colors.white),
              ),
            ),
          ),
          // Chat
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: 0,
                    itemBuilder: (context, index) => const ChatMessage(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Poser une question...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        title: Text('Message du chat'),
      ),
    );
  }
}