import 'package:flutter/material.dart';
import 'package:gic_call_center/models/Contact.dart';
import 'package:intl/intl.dart';

enum FormMode {
  Add,
  Edit,
}

class ContactForm extends StatefulWidget {
  final Contact? contact;
  final FormMode formMode;

  const ContactForm({super.key, this.contact, required this.formMode});

  @override
  ContactFormState createState() {
    return ContactFormState();
  }
}

class ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _institutionNameController =
      TextEditingController();
  final TextEditingController _currentStudyYearController =
      TextEditingController();
  final TextEditingController _expectedGraduationYearController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    // Check the form mode and populate the form fields accordingly
    if (widget.formMode == FormMode.Edit && widget.contact != null) {
      _firstNameController.text = widget.contact!.firstName;
      _lastNameController.text = widget.contact!.lastName;
      _contactNumberController.text = widget.contact!.contactNumber;
      _institutionNameController.text = widget.contact!.institutionName;
      _currentStudyYearController.text = widget.contact!.currentStudyYear;
      _expectedGraduationYearController.text =
          widget.contact!.expectedGraduationYear;
      _selectedDate = widget.contact?.expectedGraduationYear != null
          ? DateFormat('yyyy').parse(widget.contact!.expectedGraduationYear)
          : null;
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _contactNumberController.dispose();
    _institutionNameController.dispose();
    _currentStudyYearController.dispose();
    _expectedGraduationYearController.dispose();
    super.dispose();
  }

  //The function that gets the form values and saves them to the database
  void _saveForm() async {
    //get form values
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final contactNumber = _contactNumberController.text;
    final institutionName = _institutionNameController.text;
    final currentStudyYear = _currentStudyYearController.text;
    final expectedGraduationYear = _expectedGraduationYearController.text;
    //print the values
    print(firstName);
    print(lastName);
    print(contactNumber);
    print(institutionName);
    print(currentStudyYear);
    print(expectedGraduationYear);
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 10),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), // Back arrow icon
            onPressed: () {
              Navigator.of(context).pop(); // Pop the current screen
            },
          ),
          title: Text(
            widget.formMode == FormMode.Add ? 'Add Contact' : 'Edit Contact',
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                            hintText: 'First Name',
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'First Name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                            hintText: 'Last Name',
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Last Name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _contactNumberController,
                        decoration: const InputDecoration(
                            hintText: 'Contact Number',
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Contact Number is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _institutionNameController,
                        decoration: const InputDecoration(
                            hintText: 'Institution Name',
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Institution Name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _currentStudyYearController,
                        keyboardType: TextInputType
                            .number, // This sets the keyboard type to a number pad.
                        decoration: const InputDecoration(
                          hintText: 'Current Study Year',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Study Year is required';
                          }
                          // Validate if the input is a valid integer.
                          if (int.tryParse(value) == null) {
                            return 'Invalid Study Year';
                          }
                          // You can add additional validation logic here if needed.
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: IgnorePointer(
                          child: TextFormField(
                            controller: _expectedGraduationYearController,
                            decoration: InputDecoration(
                              labelText: 'Expected Graduation Year',
                              hintText: _selectedDate != null
                                  ? DateFormat('yyyy').format(_selectedDate!)
                                  : 'Select Year',
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            validator: (value) {
                              if (_selectedDate == null) {
                                return 'Expected Graduation Year is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            minimumSize: const Size.fromHeight(50)),
                        onPressed: () {
                          _saveForm();
                        },
                        child: Text(widget.formMode == FormMode.Add
                            ? 'Add Contact'
                            : 'Update Contact'),
                      )
                    ],
                  )),
            ],
          ),
        ),
      );
  }
}
