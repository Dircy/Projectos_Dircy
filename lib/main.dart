import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soulcare/pages/chat.dart';
import 'package:soulcare/pages/login_page.dart';
import 'package:soulcare/pages/suportPage.dart';
import 'package:soulcare/models/Article.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCKMuIL5RmYk79t9pGOG3QfCAird_u3RFE",
        appId: "1:934791390159:web:3ce5bc980b633761eca8ba",
        projectId: "soulcare-1ca84", messagingSenderId: '934791390159',
        // Your web Firebase config options
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Article> articles = [
    Article(
        'Anxiety',
        'People can feel anxious about a lot of things: the first day of school, a job interview, a big event or a first date.',
        'asset/Anxiety.pdf'),
    Article(
        'Depression',
        'Depression is a feeling that nothing matters that can be so strong it interferes with one’s ability to function in the world.',
        'asset/Depression.pdf'),
    Article(
        'Self-Harm',
        'Self-harm isn’t just cutting. It may include self-injury such as, scratching, burning, hitting oneself, pulling out hair, etc.',
        'asset/SelfHarm.pdf'),
    Article(
        'Suicide',
        'There’s no single cause for suicide. Suicide most often occurs when stressors and health issues come together and create feelings of hopelessness and despair.',
        'asset/Suicide.pdf'),
    Article(
        'Understanding relationship abuse',
        'Relationship abuse is a complicated issue with many different levels, and understanding the basics of relationship abuse can help you get support.',
        'asset/RelationshipAbuse.pdf'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SOUL \nCARE',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xFF71C1C8), // Cor do menu
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF71C1C8),
                ),
                child: Text(
                  'SOUL \nCARE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: Text('Home',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
              ListTile(
                title: Text('Finding Support',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SuportPage()),
                  );
                },
              ),
              ListTile(
                title: Text('Community',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return ArticleCard(article: articles[index]);
        },
      ),
    );
  }
}

class ArticleCard extends StatelessWidget {
  final Article article;

  ArticleCard({required this.article});

  void _openPdf(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerPage(pdfPath: article.path),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Colors.white, // Cor de fundo do card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0), // Borda arredondada do card
      ),
      elevation: 0.0, // Sombra do card

      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              article.title,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              article.content,
              style: TextStyle(fontSize: 12.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                _openPdf(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF71C1C8), // Cor do botão
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Borda arredondada do botão
                ),
                minimumSize: Size(50.0, 50.0), // Largura total do botão
              ),
              child: Text(
                'LEARN MORE',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PdfViewerPage extends StatelessWidget {
  final String pdfPath;

  PdfViewerPage({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: SfPdfViewer.asset(
        pdfPath,
      ),
    );
  }
}