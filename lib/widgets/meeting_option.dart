import 'package:flutter/material.dart';
import 'package:zoom_clone/utils/utils.dart';

class MeetingOption extends StatelessWidget {
  final String text;
  final bool isMute;
  final Function(bool) onChanged;

  const MeetingOption({
    Key? key,
    required this.text,
    required this.isMute,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: secondaryBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Switch.adaptive(
              value: isMute,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
