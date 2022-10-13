import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zoom_clone/utils/colors.dart';

import '../resources/resources.dart';
import '../widgets/widgets.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({Key? key}) : super(key: key);

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  late TextEditingController meetingNameController;
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  createNewMeetings(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 60,
                child: TextField(
                  controller: meetingNameController,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    fillColor: secondaryBackgroundColor,
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Meeting Name',
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                ),
                child: const Text("Start"),
                onPressed: () {
                  if (meetingNameController.text.isNotEmpty) {
                    Navigator.pop(context);

                    var random = Random();
                    String roomName =
                        (random.nextInt(10000000) + 10000000).toString();

                    _jitsiMeetMethods.createMeeting(
                      roomID: roomName,
                      meetingSubject: meetingNameController.text,
                      isAudioMuted: true,
                      isVideoMuted: true,
                    );
                  } else {
                    showSnackBar(
                      context,
                      'Please enter meeting name to create meeting',
                    );
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }

  joinMeeting(BuildContext context) {
    Navigator.pushNamed(context, '/join-meeting');
  }

  @override
  void initState() {
    super.initState();
    meetingNameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    meetingNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMeetingButton(
              onPressed: () => createNewMeetings(context),
              icon: Icons.videocam,
              text: 'New Meeting',
            ),
            HomeMeetingButton(
              onPressed: () => joinMeeting(context),
              icon: Icons.add_box_rounded,
              text: 'Join Meeting',
            ),
            HomeMeetingButton(
              onPressed: () {},
              icon: Icons.calendar_today,
              text: 'Schedule',
            ),
            HomeMeetingButton(
              onPressed: () {},
              icon: Icons.arrow_upward_rounded,
              text: 'Share Screen',
            ),
          ],
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Create/Join meetings with just a click.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
