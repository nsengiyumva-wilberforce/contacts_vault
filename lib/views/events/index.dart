import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GIC Events'),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 20), // Add space only at the top
        children: const <Widget>[
          ElevatedCard("GIC Event 1"),
          SizedBox(height: 20),
          ElevatedCard("GIC Event 2"),
          SizedBox(height: 20),
          ElevatedCard("GIC Event 3"),
          SizedBox(height: 20),
          ElevatedCard("No University"),
        ],
      ),
    );
  }
}

class ElevatedCard extends StatelessWidget {
  final String text;

  const ElevatedCard(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
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
