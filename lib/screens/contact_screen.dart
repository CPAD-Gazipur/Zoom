import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/firestore_methods.dart';

import '../utils/colors.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: TextField(
            controller: searchController,
            maxLines: 1,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              fillColor: secondaryBackgroundColor,
              filled: true,
              border: InputBorder.none,
              hintText: 'Search',
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
        StreamBuilder(
          stream: FireStoreMethods().userList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (snapshot.hasData) {
              dynamic userList = snapshot.data;
              if (userList.docs.length > 0) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: userList.docs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        tileColor: secondaryBackgroundColor,
                        title: Text(
                          '${userList.docs[index]['userName']}',
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            userList.docs[index]['userImage'],
                          ),
                        ),
                        trailing: const Icon(
                          Icons.call,
                        ),
                      ),
                    );
                  },
                );
              }
              return Container();
            }
            return Container();
          },
        ),
      ],
    );
  }
}
