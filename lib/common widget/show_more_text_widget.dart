import 'package:calebshirthum/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:flutter/material.dart';

class ShowMoreText extends StatefulWidget {
  final String text;
  final int wordLimit;
  final TextStyle? style;

  const ShowMoreText({
    super.key,
    required this.text,
    this.wordLimit = 15,
    this.style,
  });

  @override
  State<ShowMoreText> createState() => _ShowMoreTextState();
}

class _ShowMoreTextState extends State<ShowMoreText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final words = widget.text.split(' ');

    final isLong = words.length > widget.wordLimit;
    final visibleText = isLong && !_expanded
        ? words.take(widget.wordLimit).join(' ') + "..."
        : widget.text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
        text:   visibleText,
        ),

        if (isLong)
          GestureDetector(
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                _expanded ? "Show Less" : "Show More",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
