import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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

    return Row(
      children: [
        ...initialText.map((e) => Row(
          children: [
            Text(
              e,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12.0, fontWeight: FontWeight.w400),
            ),
            const Gap(10),
          ],
        )),
        const SizedBox(width: 5.0),
        Flexible(
          child: TextField(
            controller: responseTextController,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12.0, fontWeight: FontWeight.w400),
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
        ),
        const SizedBox(width: 5.0),
        ...finalText.map((e) => Row(
          children: [
            Text(
                  e,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12.0, fontWeight: FontWeight.w400),
                ),
            const Gap(10),
          ],
        )),
      ],
    );
  }
}
