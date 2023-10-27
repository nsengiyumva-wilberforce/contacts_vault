import 'package:flutter/material.dart';
import 'package:gic_call_center/controllers/auth_controller.dart';
import 'package:gic_call_center/models/Contact.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:gic_call_center/views/components/appbar.dart';
import 'package:gic_call_center/views/contacts/contact-detail.dart';
import 'package:gic_call_center/views/contacts/form.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  ContactsState createState() => ContactsState();
}

class ContactsState extends State<Contacts> {
  late Future<List<Contact>> allContacts;

  List<Contact> displayedContacts = [];

  @override
  void initState() {
    super.initState();
    allContacts = loadContacts();
    filterContacts('');
  }

  Future<List<Contact>> loadContacts() async {
    AuthController authController = AuthController();
    try {
      final response = await authController.getContacts();
      if (response.containsKey("error")) {
        // Handle the case where the 'contacts' field in the API response is null
        print("'contacts' field in API response is null");
        throw Exception("'contacts' field in API response is null");
      } else {
        if (response['contacts'] != null) {
          List<dynamic> contactsData = response['contacts'];
          List<Contact> contacts = contactsData.map((contactData) {
            return Contact(
              firstName: contactData['first_name'] ?? 'Unknown',
              lastName: contactData['last_name'] ?? 'Unknown',
              contactNumber: '0${contactData['contact_number'] ?? 'N/A'}',
              institutionName: contactData['name_of_institution'] ?? 'N/A',
              currentStudyYear: contactData['study_year'] ?? '1900',
              expectedGraduationYear: contactData['graduation_year'] ?? '1900',
            );
          }).toList();

          return contacts;
        } else {
          // Handle the case where the 'contacts' field in the API response is null
          print("'contacts' field in API response is null");
          throw Exception("'contacts' field in API response is null");
        }
      }
    } catch (error) {
      // Handle the case where the 'contacts' field in the API response is null
      print("'contacts' field in API response is null");
      throw Exception("'contacts' field in API response is null");
    }
  }

  Future<void> filterContacts(String query) async {
    List<Contact> allContacts = await loadContacts();
    setState(() {
      displayedContacts.clear();
      if (query.isEmpty) {
        displayedContacts.addAll(allContacts);
      } else {
        List<String> searchTerms = query.toLowerCase().split(' ');
        displayedContacts.addAll(allContacts.where((contact) {
          String fullName =
              '${contact.firstName} ${contact.lastName}'.toLowerCase();

          // Check if any part of the full name matches any search term
          bool fullNameMatch =
              searchTerms.every((term) => fullName.contains(term));

          // Check if any part of the first name or last name matches any search term
          bool firstNameMatch = searchTerms
              .every((term) => contact.firstName.toLowerCase().contains(term));
          bool lastNameMatch = searchTerms
              .every((term) => contact.lastName.toLowerCase().contains(term));

          // Check if the institution name contains any search term
          bool institutionNameMatch = searchTerms.every(
              (term) => contact.institutionName.toLowerCase().contains(term));

          return fullNameMatch ||
              firstNameMatch ||
              lastNameMatch ||
              institutionNameMatch;
        }));
      }
      displayedContacts.sort((a, b) => '${a.firstName} ${a.lastName}'
          .compareTo('${b.firstName} ${b.lastName}'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Contacts'),
      body: FutureBuilder(
          future: allContacts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // If the Future throws an error, display an error message
              return Text('Error loading contacts: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              // If the Future completes successfully but with no data, display a message
              return const Text('No contacts available.');
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search contacts...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {
                        filterContacts(value);
                      }
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: displayedContacts.length,
                      itemBuilder: (context, index) {
                        Contact contact = displayedContacts[index];
                        return ListTile(
                          leading: const Icon(Icons.person), // Person icon
                          title:
                              Text('${contact.firstName} ${contact.lastName}'),
                          subtitle: Text(contact.institutionName),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.phone), // Phone icon
                                onPressed: () {
                                  FlutterPhoneDirectCaller.callNumber(
                                      contact.contactNumber);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ContactForm(
                                        contact: contact,
                                        formMode: FormMode.Edit,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                    Icons.info_outline), // More_vert icon
                                onPressed: () {
                                  // navigate to contact detail page not using named routes just passing the contact object
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ContactCard(contact: contact),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            // Handle contact item tap here if needed
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}
