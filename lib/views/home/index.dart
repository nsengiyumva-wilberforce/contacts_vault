import 'package:flutter/material.dart';
import 'package:gic_call_center/views/components/appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'GIC Call Center'),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(
                'assets/images/happy-young-african-man-guy-making-phone-call-smiling_33839-12044.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.grey.withOpacity(0.5),
                BlendMode.dstATop), // Adds a grey overlay
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: const <Widget>[
            ElevatedCard("50", "Makerere University"),
            SizedBox(height: 20),
            ElevatedCard("10", "Kyambogo University"),
            SizedBox(height: 20),
            ElevatedCard("10", "Kampala International University"),
            SizedBox(height: 20),
            ElevatedCard("30", "No University"),
            SizedBox(height: 20),
            ElevatedCard("30", "Makerere University Business School"),
          ],
        ),
      ),
    );
  }
}



class ElevatedCard extends StatelessWidget {
  final String number;
  final String text;

  const ElevatedCard(this.number, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text(
              number,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
