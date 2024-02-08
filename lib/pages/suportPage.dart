import 'package:flutter/material.dart';
import 'package:soulcare/models/SupportItem.dart';
import 'package:url_launcher/url_launcher.dart';



class SuportPage extends StatelessWidget {
  final List<SupportItem> supportItems = [
    SupportItem(
      title: 'Crisis Text Line',
      content: 'If you are in crisis, text CONVO to 741741 in the US for free, confidential, 24/7, support.',
      supportLink: 'https://www.crisistextline.org/',
    ),
    SupportItem(
      title: 'TrevorLifeline',
      content: 'The Trevor Projects free and confidential phone support for LGBTQ youth is available 24/7.',
      supportLink: 'https://www.thetrevorproject.org/get-help/',
    ),
    // Adicione mais itens conforme necessário
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Finding Support',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              Text(
                'If you or someone you know needs support, there is help. '
                    'You are not alone. Below you can find information and resources on how to get help.',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.0),
              Expanded(
                child: ListView.builder(
                  itemCount: supportItems.length,
                  itemBuilder: (context, index) {
                    return SupportItemCard(supportItem: supportItems[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SupportItemCard extends StatefulWidget {
  final SupportItem supportItem;

  SupportItemCard({required this.supportItem});

  @override
  State<SupportItemCard> createState() => _SupportItemCardState();
}

class _SupportItemCardState extends State<SupportItemCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      child: Padding(
        padding: EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.supportItem.title,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                _launchURL(widget.supportItem.supportLink);
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF71C1C8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(50.0, 50.0),
              ),
              child: Text('VISIT WEBSITE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.normal),),
            ),
            Text(
              widget.supportItem.content,
              style: TextStyle(fontSize: 16.0,),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
