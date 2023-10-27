import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:gic_call_center/models/Contact.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;

  const ContactCard({required this.contact, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contact Details'),
        ),
        body: Stack(children: [
          Card(
            elevation: 7,
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text('${contact.firstName} ${contact.lastName}'),
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: Text(contact.contactNumber),
                  onTap: () async {
                    await FlutterPhoneDirectCaller.callNumber(
                        contact.contactNumber);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.school),
                  title: Text(contact.institutionName),
                ),
                ListTile(
                  leading: const Icon(Icons.school),
                  title: Text(contact.currentStudyYear),
                ),
                ListTile(
                  leading: const Icon(Icons.school),
                  title: Text(contact.expectedGraduationYear),
                ),
              ],
            ),
          )
        ]));
  }
}
