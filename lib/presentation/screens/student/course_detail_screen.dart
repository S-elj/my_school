import 'package:flutter/material.dart';
import '/data/models/content_models.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
      ),
      body: ListView(
        children: [
          // Informations du cours
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Chip(label: Text(course.subject)),
                    const SizedBox(width: 8),
                    Chip(label: Text(course.gradeLevel)),
                  ],
                ),
              ],
            ),
          ),

          // Liste des contenus
          ...course.contents.map((content) {
            switch (content.type) {
              case ContentType.video:
                return VideoContentCard(content: content);
              case ContentType.document:
                return DocumentContentCard(content: content);
              case ContentType.presentation:
                return PresentationContentCard(content: content);
              default:
                return const SizedBox.shrink();
            }
          }).toList(),
        ],
      ),
    );
  }
}

class VideoContentCard extends StatelessWidget {
  final Content content;

  const VideoContentCard({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Pas encore implémenté",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              content.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (content.description != null)
              Text(content.description!),
          ],
        ),
      ),
    );
  }
}


class DocumentContentCard extends StatelessWidget {
  final Content content;

  const DocumentContentCard({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: const Icon(Icons.description),
        title: Text(content.title),
        subtitle: content.description != null ? Text(content.description!) : null,
        trailing: const Icon(Icons.download),
        onTap: () {
          // TODO: Ouvrir le document
        },
      ),
    );
  }
}

class PresentationContentCard extends StatelessWidget {
  final Content content;

  const PresentationContentCard({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: const Icon(Icons.slideshow),
        title: Text(content.title),
        subtitle: content.description != null ? Text(content.description!) : null,
        trailing: const Icon(Icons.open_in_new),
        onTap: () {
          // TODO: Ouvrir la présentation
        },
      ),
    );
  }
}