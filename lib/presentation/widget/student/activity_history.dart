import 'package:flutter/material.dart';
import '/data/models/content_models.dart';

class ActivityHistoryList extends StatelessWidget {
  const ActivityHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Tout'),
              Tab(text: 'Cours'),
              Tab(text: 'Exercices'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _ActivityList(filter: null),
                _ActivityList(filter: ContentType.video),
                _ActivityList(filter: ContentType.qcm),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityList extends StatelessWidget {
  final ContentType? filter;

  const _ActivityList({this.filter});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) => ActivityCard(
        activity: ActivityHistory(
          id: '1',
          contentId: '1',
          contentTitle: 'Mathématiques - Chapitre 1',
          contentType: filter ?? ContentType.video,
          startTime: DateTime.now().subtract(const Duration(days: 1)),
          endTime: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
          progress: 0.8,
          score: 85,
        ),
      ),
      itemCount: 10,
    );
  }
}

class ActivityCard extends StatelessWidget {
  final ActivityHistory activity;

  const ActivityCard({super.key, required this.activity});

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
              children: [
                Icon(_getIconForType(activity.contentType)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    activity.contentTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (activity.progress != null) ...[
              LinearProgressIndicator(value: activity.progress),
              const SizedBox(height: 4),
              Text('${(activity.progress! * 100).toInt()}% complété'),
            ],
            if (activity.score != null) ...[
              const SizedBox(height: 4),
              Text('Score: ${activity.score}%'),
            ],
            const SizedBox(height: 8),
            Text(
              'Démarré le ${_formatDateTime(activity.startTime)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForType(ContentType type) {
    switch (type) {
      case ContentType.video:
        return Icons.play_circle;
      case ContentType.document:
        return Icons.description;
      case ContentType.presentation:
        return Icons.slideshow;
      case ContentType.qcm:
        return Icons.quiz;
      case ContentType.questionAnswer:
        return Icons.question_answer;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month} à ${dateTime.hour}:${dateTime.minute}';
  }
}