import 'package:flutter/material.dart';
import 'package:fluttertest/Database%20Model.dart';
import 'Database helper.dart';
import 'Database Model.dart' as dbModel;


class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final DBhelper dbHelper = DBhelper();
  Duration _selectedDuration = const Duration();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Widget _buildTextField(String hintText, Color borderColor, String labelText, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor, width: 2),
        ),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(color: borderColor),
      ),
    );
  }

  Widget _buildDurationPickerField(Color borderColor) {
    return GestureDetector(
      onTap: () async {
        Duration? pickedDuration = await showDurationPicker(context);
        if (pickedDuration != null) {
          setState(() {
            _selectedDuration = pickedDuration;
          });
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: borderColor, width: 2),
          ),
          labelText: 'Duration',
          labelStyle: TextStyle(color: borderColor),
        ),
        child: Text(
          _selectedDuration.inMinutes == 0
              ? 'Enter Duration'
              : '${_selectedDuration.inHours}h ${_selectedDuration.inMinutes % 60}m',
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Future<Duration?> showDurationPicker(BuildContext context) async {
    int selectedHours = _selectedDuration.inHours;
    int selectedMinutes = _selectedDuration.inMinutes % 60;

    return showDialog<Duration>(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Select Duration'),
        content: SizedBox(
          height: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Selected Duration: ${selectedHours}h ${selectedMinutes}m',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Hours'),
                        DropdownButton<int>(
                          value: selectedHours,
                          items: List.generate(13, (index) => index).map((int value) {
                            return DropdownMenuItem<int>(value: value, child: Text(value.toString()));
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                selectedHours = value;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Minutes'),
                        DropdownButton<int>(
                          value: selectedMinutes,
                          items: List.generate(61, (index) => index).map((int value) {
                            return DropdownMenuItem<int>(value: value, child: Text(value.toString()));
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                selectedMinutes = value;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(null), child: const Text('Cancel')),
          TextButton(onPressed: () {
            Navigator.of(context).pop(Duration(hours: selectedHours, minutes: selectedMinutes));
          }, child: const Text('OK')),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
          title: const Text('Add Offering',
            style: TextStyle(fontFamily: 'inknut'),)
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: _buildTextField('Enter your name', Colors.blue, 'Name', nameController),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: _buildTextField('Enter your title', Colors.blue, 'Title', titleController),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: _buildTextField('Enter Category', Colors.blue, 'Category', categoryController),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: _buildDurationPickerField(Colors.blue),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: _buildTextField('Enter type', Colors.blue, 'Type', typeController),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: _buildTextField('Enter price', Colors.blue, 'Price', priceController),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: _buildTextField('Enter description', Colors.blue, 'Description', descriptionController),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: const Offset(1, 2),
                        blurRadius: 2,
                        spreadRadius: 1,
                      ),
                    ],
                    color: Colors.grey,
                  ),
                  child: InkWell(
                    onTap: () async {
                      if (nameController.text.isEmpty ||
                          titleController.text.isEmpty ||
                          categoryController.text.isEmpty ||
                          _selectedDuration.inMinutes == 0 ||
                          typeController.text.isEmpty ||
                          priceController.text.isEmpty ||
                          descriptionController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please fill all the fields')),
                        );
                        return;
                      }

                      final newNote = dbModel.NoteModel(
                        name: nameController.text,
                        title: titleController.text,
                        category: categoryController.text,
                        duration: _selectedDuration.inMinutes.toString(),
                        type: typeController.text,
                        price: double.tryParse(priceController.text) ?? 0.0,
                        description: descriptionController.text,
                      );

                      try {
                        print('Inserting Note: ${newNote.toMap()}');

                        await dbHelper.insert(newNote as NoteModel);
                        print('Data added successfully.');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Note added successfully!')),
                        );
                        nameController.clear();
                        titleController.clear();
                        categoryController.clear();
                        typeController.clear();
                        priceController.clear();
                        descriptionController.clear();
                        setState(() {
                          _selectedDuration = const Duration();
                        });
                      } catch (error) {
                        print('Error adding data: ${error.toString()}');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error adding note: ${error.toString()}')),
                        );
                      }
                      Navigator.pop(context);
                    },

                    child: const Center(
                      child: Text(
                        'Add',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
