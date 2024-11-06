import 'package:flutter/material.dart';
import 'package:fluttertest/Database helper.dart'; // Make sure this path is correct
import 'package:fluttertest/Add page.dart'; // Make sure this path is correct
import 'package:fluttertest/Database Model.dart';
import 'package:fluttertest/Edit%20page.dart'; // Make sure this path is correct

class AddEditPage extends StatefulWidget {
  final NoteModel note;

  const AddEditPage({Key? key, required this.note}) : super(key: key);

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final DBhelper dbHelper = DBhelper();

  Future<void> _deleteNote() async {
    if (widget.note.id != null) {
      try {
        await dbHelper.delete(widget.note.id!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Note deleted successfully')),
        );
        Navigator.pop(context);
      } catch (error) {
        print('Error deleting note: ${error.toString()}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting note: ${error.toString()}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid note ID')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: const Text(
          'Practitioner detail',
          style: TextStyle(fontFamily: 'inknut'),
        ),
        actions: [
          IconButton(onPressed: _deleteNote, icon: const Icon(Icons.delete))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Name: ${widget.note.name}',
              style: const TextStyle(fontSize: 15, fontFamily: 'inknut'),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Title: ${widget.note.title}',
              style: const TextStyle(fontSize: 15, fontFamily: 'inknut'),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Category: ${widget.note.category}',
              style: const TextStyle(fontSize: 15, fontFamily: 'inknut'),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Time: ${widget.note.duration} minutes',
              style: const TextStyle(fontSize: 15, fontFamily: 'inknut'),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Type: ${widget.note.type}',
              style: const TextStyle(fontSize: 15, fontFamily: 'inknut'),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Price: ${widget.note.price} R.s',
              style: const TextStyle(fontSize: 15, fontFamily: 'inknut'),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Description: ${widget.note.description}',
              style: const TextStyle(fontSize: 15, fontFamily: 'inknut'),
            ),
          ),
          const Divider(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30)),
          color: Colors.grey,
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddPage()),
                );
              },
              child: const Text('Add'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPage(note: widget.note),
                  ),
                );
              },
              child: const Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }
}
