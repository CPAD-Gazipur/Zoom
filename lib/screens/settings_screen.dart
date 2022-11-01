import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/firestore_methods.dart';
import 'package:zoom_clone/utils/utils.dart';
import 'package:zoom_clone/widgets/custom_icon_button.dart';

import '../resources/resources.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FireStoreMethods().userInfo,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (snapshot.hasData) {
                final userInfo = snapshot.data?.data() as Map;
                return Column(
                  children: [
                    Stack(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(userInfo['userImage']),
                              radius: 45,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userInfo['userName'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  '(He/His)',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'Software Engineer @Rokomari',
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )
                          ],
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {
                              showCupertinoDialog(
                                context: context,
                                builder: (_) => CupertinoAlertDialog(
                                  title: const Text('Warning!'),
                                  content: const Text(
                                    'Are you sure to exit Zoom app ?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        AuthMethods().signOut();
                                      },
                                      child: const Text('YES'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('NO'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.exit_to_app_rounded,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Full Time',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 2,
                          color: Colors.grey,
                        ),
                        const Text(
                          'Dhaka, Bangladesh',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 2,
                          color: Colors.grey,
                        ),
                        const Text(
                          'Online',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: secondaryBackgroundColor,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: RichText(
                        text: TextSpan(
                          text: '${userInfo['userName']}\'s Note: ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          children: const [
                            TextSpan(
                              text:
                                  'Office Hours: 08:00 AM - 05:00 PM. Message me for agenda link.',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        CustomIconButton(
                          icon: Icons.chat_bubble,
                          title: 'Chat',
                        ),
                        CustomIconButton(
                          icon: Icons.video_camera_back_rounded,
                          title: 'Meet',
                        ),
                        CustomIconButton(
                          icon: Icons.message,
                          title: 'SMS',
                        ),
                        CustomIconButton(
                          icon: Icons.call,
                          title: 'Call',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
