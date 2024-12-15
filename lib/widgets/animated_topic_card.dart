import 'package:flutter/material.dart';
import '../models/topic.dart';

class AnimatedTopicCard extends StatefulWidget {
  final Topic topic;
  final Color color;
  final Animation<double> animation;
  final VoidCallback onTap;

  const AnimatedTopicCard({
    super.key,
    required this.topic,
    required this.color,
    required this.animation,
    required this.onTap,
  });

  @override
  State<AnimatedTopicCard> createState() => _AnimatedTopicCardState();
}

class _AnimatedTopicCardState extends State<AnimatedTopicCard> {
  bool _isHovered = false;

  Color get cardColor =>
      _isHovered ? Color.lerp(widget.color, Colors.white, 0.2)! : widget.color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          onHover: (value) => setState(() => _isHovered = value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 120,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(0.3),
                  blurRadius: 8 + (widget.animation.value * 8),
                  spreadRadius: 2 + (widget.animation.value * 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -20,
                  top: -20,
                  child: Transform.rotate(
                    angle: widget.animation.value * 2 * 3.14159,
                    child: Icon(
                      Icons.question_answer_rounded,
                      size: 100,
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.topic.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${widget.topic.questions.length} вопросов',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
