import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoom_clone/resources/resources.dart';
import 'package:zoom_clone/utils/utils.dart';
import 'package:zoom_clone/widgets/widgets.dart';

class JoinAMeetingScreen extends StatefulWidget {
  const JoinAMeetingScreen({Key? key}) : super(key: key);

  @override
  State<JoinAMeetingScreen> createState() => _JoinAMeetingScreenState();
}

class _JoinAMeetingScreenState extends State<JoinAMeetingScreen> {
  final AuthMethods _authMethods = AuthMethods();

  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  late TextEditingController meetingController;
  late TextEditingController nameController;

  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    meetingController = TextEditingController();
    nameController = TextEditingController(
      text: _authMethods.user.displayName,
    );
    super.initState();
  }

  _joinMeeting() {
    if (meetingController.text.isEmpty) {
      showSnackBar(context, 'Please enter room ID');
    } else if (nameController.text.isEmpty) {
      showSnackBar(context, 'Please enter your name');
    } else {
      _jitsiMeetMethods.createMeeting(
        roomID: meetingController.text,
        userName: nameController.text,
        meetingSubject: '',
        isAudioMuted: isAudioMuted,
        isVideoMuted: isVideoMuted,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    meetingController.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Text(
          'Join a Meeting',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
            child: TextField(
              controller: meetingController,
              maxLines: 1,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: 'Room ID',
              ),
            ),
          ),
          SizedBox(
            height: 60,
            child: TextField(
              controller: nameController,
              maxLines: 1,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: 'Name',
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              onTap: _joinMeeting,
              child: const Center(
                child: Text(
                  'Join',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(
              left: 16,
              bottom: 8,
              top: 8,
            ),
            child: Text(
              'JOIN OPTIONS',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          MeetingOption(
            text: 'Don\'t Connect To Audio',
            isMute: isAudioMuted,
            onChanged: (value) {
              setState(() {
                isAudioMuted = !isAudioMuted;
              });
            },
          ),
          MeetingOption(
            text: 'Turn Off My Video',
            isMute: isVideoMuted,
            onChanged: (value) {
              setState(() {
                isVideoMuted = !isVideoMuted;
              });
            },
          ),
        ],
      ),
    );
  }
}
