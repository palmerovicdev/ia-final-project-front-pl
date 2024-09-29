import 'package:flutter/material.dart';

class CustomNumberWordsWidget extends StatelessWidget {
  const CustomNumberWordsWidget({super.key, required this.words, required this.wordIndex, required this.responseTextController});
  final List<String> words;
  final int wordIndex;
  final TextEditingController responseTextController;

  @override
  Widget build(BuildContext context) {
    var initialText = words.sublist(0, wordIndex).join('');
    var finalText = '';
    if (wordIndex + 1 < words.length - 1) {
      finalText = words.sublist(wordIndex + 1, words.length).join('');
    } else if (wordIndex + 1 == words.length - 1) {
      finalText = words[wordIndex + 1];
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          initialText,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 64.0, fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 5.0),
        TextField(
          controller: responseTextController,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 64.0, fontWeight: FontWeight.w500),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (value) {
            if (value.length == 1) {
              responseTextController.text = value;
            }
          },
        ),
        const SizedBox(width: 5.0),
        Text(
          finalText,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 64.0, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
