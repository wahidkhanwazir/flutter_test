import 'package:flutter/material.dart';
import 'package:fluttertest/Add%20page.dart';
import 'Database Model.dart';
import 'Add_Edit Page.dart';
import 'Database helper.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final DBhelper dbHelper = DBhelper();
  List<NoteModel> notes = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final fetchedNotes = await dbHelper.getAllNotes();
    setState(() {
      notes = List<NoteModel>.from(fetchedNotes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Header section
          Container(
            height: 110,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
              color: Colors.grey,
            ),
            child: const Padding(
              padding: EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Practitioners',
                    style: TextStyle(fontSize: 25, fontFamily: 'inknut'),
                  ),
                  Text(
                    'Offerings.',
                    style: TextStyle(fontSize: 25, fontFamily: 'inknut'),
                  ),
                ],
              ),
            ),
          ),
          // List of offerings
          Expanded(
            child: notes.isEmpty
                ? const Center(child: Text('No offerings found', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
                : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade300,
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditPage(note: note),
                          ),
                        ).then((_) {
                          _fetchData(); // Call _fetchData to refresh the offerings
                        });
                      },
                      title: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name: ${note.name}'),
                            Text('Title: ${note.title}'),
                          ],
                        ),
                      ),
                      trailing: Text('Time: ${note.duration} minutes'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPage()))
              .then((_) {
            _fetchData(); // Refresh the list after adding a new note
          });
        },
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
              color: Colors.blueGrey, borderRadius: BorderRadius.circular(20)),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
