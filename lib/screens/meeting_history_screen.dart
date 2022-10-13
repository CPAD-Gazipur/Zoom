import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:zoom_clone/resources/firestore_methods.dart';
import 'package:zoom_clone/utils/colors.dart';

class MeetingHistoryScreen extends StatefulWidget {
  const MeetingHistoryScreen({Key? key}) : super(key: key);

  @override
  State<MeetingHistoryScreen> createState() => _MeetingHistoryScreenState();
}

class _MeetingHistoryScreenState extends State<MeetingHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FireStoreMethods().meetingsHistory,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (snapshot.hasData) {
          dynamic meetingDetails = snapshot.data;
          if (meetingDetails.docs.length > 0) {
            return ListView.builder(
              itemCount: meetingDetails.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: secondaryBackgroundColor,
                    title: Text(
                      'Topic: ${meetingDetails.docs[index]['meetingName']}',
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Meeting ID: ${meetingDetails.docs[index]['roomID']}'),
                        Text(
                          timeago.format(
                            meetingDetails.docs[index]['createdDate'].toDate(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }
        return Container();
      },
    );
  }
}
