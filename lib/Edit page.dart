import 'package:flutter/material.dart';
import 'package:fluttertest/Database%20Model.dart';
import 'package:fluttertest/Database%20helper.dart';


class EditPage extends StatefulWidget {
  final NoteModel note;

  const EditPage({Key? key, required this.note}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final DBhelper dbHelper = DBhelper();
  late TextEditingController _nameController;
  late TextEditingController _titleController;
  late TextEditingController _categoryController;
  late TextEditingController _durationController;
  late TextEditingController _typeController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.note.name);
    _titleController = TextEditingController(text: widget.note.title);
    _categoryController = TextEditingController(text: widget.note.category);
    _durationController = TextEditingController(text: widget.note.duration.toString());
    _typeController = TextEditingController(text: widget.note.type);
    _priceController = TextEditingController(text: widget.note.price.toString());
    _descriptionController = TextEditingController(text: widget.note.description);
  }

  Future<void> _saveNote() async {
    NoteModel updatedNote = NoteModel(
      id: widget.note.id, // Keep the same ID
      name: _nameController.text,
      title: _titleController.text,
      category: _categoryController.text,
      duration: int.parse(_durationController.text),
      type: _typeController.text,
      price: double.parse(_priceController.text),
      description: _descriptionController.text,
    );

    try {
      await dbHelper.update(updatedNote);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Note updated successfully')),
      );
      Navigator.pop(context);
    } catch (error) {
      print('Error updating note');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error updating note')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: const Text('Edit Practitioner Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name')),
              TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
              TextField(controller: _categoryController, decoration: const InputDecoration(labelText: 'Category')),
              TextField(controller: _durationController, decoration: const InputDecoration(labelText: 'Duration (minutes)')),
              TextField(controller: _typeController, decoration: const InputDecoration(labelText: 'Type')),
              TextField(controller: _priceController, decoration: const InputDecoration(labelText: 'Price')),
              TextField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Description')),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){
                  _saveNote();
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
