import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add Firestore for user info
import '../firebase_options.dart';
import 'package:intl/intl.dart';
import '../gradient_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forum Diskusi Kesehatan',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: ForumDiskusiKesehatanPage(),
    );
  }
}

class ForumDiskusiKesehatanPage extends StatefulWidget {
  @override
  _ForumDiskusiKesehatanPageState createState() =>
      _ForumDiskusiKesehatanPageState();
}

class _ForumDiskusiKesehatanPageState extends State<ForumDiskusiKesehatanPage> {
  final DatabaseReference _questionsRef =
  FirebaseDatabase.instance.reference().child('questions');

  final TextEditingController _questionController = TextEditingController();
  User? _currentUser;
  String _accountName = ''; // To hold the user's name

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch user's name from Firestore or FirebaseAuth
  }

  Future<void> _fetchUserData() async {
    _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        setState(() {
          _accountName = userDoc.get('fullName') ?? 'Anonymous';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forum Diskusi Kesehatan', style: TextStyle(fontSize: 22)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: buildGradient(), // Call the gradient function here
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _questionsRef.onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.data != null &&
                    snapshot.data!.snapshot.value != null) {
                  Map<dynamic, dynamic> data = Map<dynamic, dynamic>.from(
                      snapshot.data!.snapshot.value as Map);
                  List items = [];

                  data.forEach((key, value) {
                    items.add(value);
                  });

                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          title: Text(
                            items[index]['title'] ?? 'No title',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Ditanyakan Oleh: ${items[index]['askedBy'] ?? 'Anonymous'} pada ${DateFormat('dd MMM yyyy, HH:mm').format(DateTime.fromMillisecondsSinceEpoch(items[index]['timestamp']))}',
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuestionDetailScreen(
                                    questionId: items[index]['id'] ?? ''),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('Tidak Ada Aertanyaan',
                        style: TextStyle(fontSize: 18)),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _questionController,
                    decoration: InputDecoration(
                      hintText: 'Tanyakan Pertanyaan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_questionController.text.isNotEmpty) {
                      String key = _questionsRef.push().key!;
                      _questionsRef.child(key).set({
                        'id': key,
                        'title': _questionController.text,
                        'timestamp': DateTime.now().millisecondsSinceEpoch,
                        'askedBy': _accountName,
                      });
                      _questionController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(14),
                    backgroundColor: Colors.orange,
                  ),
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}

class QuestionDetailScreen extends StatefulWidget {
  final String questionId;
  QuestionDetailScreen({required this.questionId});

  @override
  _QuestionDetailScreenState createState() => _QuestionDetailScreenState();
}

class _QuestionDetailScreenState extends State<QuestionDetailScreen> {
  final TextEditingController _replyController = TextEditingController();
  final DatabaseReference _repliesRef =
  FirebaseDatabase.instance.reference().child('replies');
  User? _currentUser;
  String _accountName = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        setState(() {
          _accountName = userDoc.get('fullName') ?? 'Anonymous';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pertanyaan'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: buildGradient(), // Call the gradient function here
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseDatabase.instance
                  .reference()
                  .child('questions')
                  .child(widget.questionId)
                  .onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.data != null &&
                    snapshot.data!.snapshot.value != null) {
                  var question =
                  snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          question['title'] ?? 'No title',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder(
                          stream: _repliesRef
                              .child(widget.questionId)
                              .onValue,
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.data != null &&
                                snapshot.data!.snapshot.value != null) {
                              Map<dynamic, dynamic> data =
                              Map<dynamic, dynamic>.from(
                                  snapshot.data!.snapshot.value as Map);
                              List items = [];

                              data.forEach((key, value) {
                                items.add(value);
                              });

                              return ListView.builder(
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                        items[index]['reply'] ?? 'No reply yet'),
                                    subtitle: Text(
                                        'Dijawab oleh: ${items[index]['answeredBy'] ?? 'Anonymous'}'),
                                  );
                                },
                              );
                            } else {
                              return Center(
                                child: Text('Masih belum ada jawaban'),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _replyController,
                    decoration: InputDecoration(hintText: 'Write a reply'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_replyController.text.isNotEmpty) {
                      String replyKey =
                      _repliesRef.child(widget.questionId).push().key!;
                      _repliesRef
                          .child(widget.questionId)
                          .child(replyKey)
                          .set({
                        'reply': _replyController.text,
                        'timestamp': DateTime.now().millisecondsSinceEpoch,
                        'answeredBy': _accountName,
                      });
                      _replyController.clear();
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
