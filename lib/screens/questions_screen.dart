import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../models/topic.dart';

class QuestionsScreen extends StatefulWidget {
  final Topic topic;

  const QuestionsScreen({super.key, required this.topic});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late final List<Color> cardColors;

  @override
  void initState() {
    super.initState();
    final random = Random();
    cardColors = List.generate(
      widget.topic.shuffledQuestions.length,
      (_) => Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topic.name),
      ),
      body: widget.topic.shuffledQuestions.isEmpty
          ? const Center(child: Text('Нет вопросов'))
          : Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: CardSwiper(
                  cardBuilder:
                      (context, index, percentThresholdX, percentThresholdY) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: cardColors[index],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.topic.shuffledQuestions[index].question,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          if (widget.topic.shuffledQuestions[index].answer !=
                              null) ...[
                            Text(
                              'Ответ: ${widget.topic.shuffledQuestions[index].answer}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                  cardsCount: widget.topic.shuffledQuestions.length,
                ),
              ),
            ),
    );
  }
}
