import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/topic.dart';
import '../widgets/animated_topic_card.dart';
import 'questions_screen.dart';

class TopicsScreen extends StatefulWidget {
  const TopicsScreen({super.key});

  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen>
    with SingleTickerProviderStateMixin {
  List<Topic> topics = [];
  late AnimationController _controller;
  final List<Color> cardColors = [
    const Color(0xFF1abc9c),
    const Color(0xFF2ecc71),
    const Color(0xFF3498db),
    const Color(0xFF9b59b6),
    const Color(0xFFf1c40f),
    const Color(0xFFe67e22),
    const Color(0xFFe74c3c),
  ];

  @override
  void initState() {
    super.initState();
    loadTopics();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> loadTopics() async {
    final String response =
        await rootBundle.loadString('assets/questions.json');
    final data = await json.decode(response);
    setState(() {
      topics = (data['topics'] as List)
          .map((topic) => Topic.fromJson(topic))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Выберите тему',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.primary.withOpacity(0.05),
            ],
          ),
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: topics.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: AnimatedTopicCard(
                    topic: topics[index],
                    color: cardColors[index % cardColors.length],
                    animation: _controller,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              QuestionsScreen(topic: topics[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
