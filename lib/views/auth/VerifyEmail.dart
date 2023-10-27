import 'package:flutter/material.dart';
import 'package:gic_call_center/views/auth/login.dart';
import 'package:gic_call_center/controllers/auth_controller.dart';

class VerificationCodeScreen extends StatefulWidget {
  final String email;

  //add key parameter
  const VerificationCodeScreen({Key? key, required this.email})
      : super(key: key);

  @override
  VerificationCodeScreenState createState() => VerificationCodeScreenState();
}

class VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final TextEditingController _verificationCodeController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enter the 6-digit verification code sent to your email',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _verificationCodeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                hintText: '• • • • • •',
                counterText: '',
              ),
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () async {
                // Validate the entered verification code and proceed accordingly
                num verificationCode =
                    num.parse(_verificationCodeController.text);

                    print('verificationCode: $verificationCode');
                AuthController authController = AuthController();

                // Implement logic to validate the verification code (compare with the stored code)
                if (await authController.verificationCodeIsValid(
                    widget.email, verificationCode)) {
                  AuthController authController = AuthController();
                  //assign contacts
                  var response = await authController.assignContacts(widget.email);

                  if (response.containsKey('error')) {
                    // Handle authentication error
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Failed to assign contacts to you!"),
                    ));
                  } else {
                    // Handle success
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Contacts assigned successfully!"),
                    ));
                  }

                  print('response: $response');

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Login();
                  }));
                } else {
                  // Code is invalid, show an error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Invalid verification code. Please try again.')),
                  );
                }
              },
              child: Text('Verify'),
            ),

            // Add a button to resend the verification code
            TextButton(
              onPressed: () {
                AuthController authController = AuthController();
                authController.resendVerificationCode(widget.email);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'Verification code sent to ${widget.email} again.')),
                );
              },
              child: const Text('Didn\'t get the code?Resend verification code'),
            ),
          ],
        ),
      ),
    );
  }
}
