import 'package:flutter/material.dart';

class CustomNumberWordsWidget extends StatelessWidget {
  const CustomNumberWordsWidget({super.key, required this.words, required this.wordIndex, required this.responseTextController});

  final List<String> words;
  final int wordIndex;
  final TextEditingController responseTextController;

  @override
  Widget build(BuildContext context) {
    var initialText = words.sublist(0, wordIndex);
    List<String> finalText = [];
    if (wordIndex + 1 < words.length - 1) {
      finalText = words.sublist(wordIndex + 1, words.length);
    } else if (wordIndex + 1 == words.length - 1) {
      finalText.add(words[wordIndex + 1]);
    }
    var fontSize = 20.0;
    var weight = FontWeight.w600;
    var width = getTextSize(words[wordIndex], context, fontSize, weight);
    print(words[wordIndex]);

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8.0,
      children: [
        ...initialText.map((e) {
          return Wrap(
            spacing: 8.0,
            children: [
              Text(
                e,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: fontSize, fontWeight: weight),
              ),
            ],
          );
        }),
        SizedBox(
          width: width,
          child: TextField(
            controller: responseTextController,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: fontSize, fontWeight: weight),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
              isDense: true,
            ),
            onChanged: (value) {
              if (value.length == 1) {
                responseTextController.text = value;
              }
            },
          ),
        ),
        ...finalText.map((e) {
          return Wrap(
            spacing: 8.0,
            children: [
              Text(
                e,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: fontSize, fontWeight: weight),
              ),
            ],
          );
        }),
      ],
    );
  }

  double getTextSize(String text, BuildContext context, double fontSize, FontWeight weight) {
    final TextSpan span = TextSpan(
      text: text,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: fontSize, fontWeight: weight),
    );

    final TextPainter painter = TextPainter(
      text: span,
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );

    painter.layout(minWidth: 0, maxWidth: double.infinity);
    return painter.size.width + 20;
  }
}
