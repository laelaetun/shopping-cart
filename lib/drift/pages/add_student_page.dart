import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:shopping_cart/drift/database.dart';

class AddStudentPage extends StatefulWidget {
  final AppDatabase db;
  final Student? student;

  const AddStudentPage({super.key, required this.db, this.student});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController ageController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.student?.name ?? '');
    ageController = TextEditingController(
      text: widget.student?.age.toString() ?? '',
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.student != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Edit Student" : "Add Student")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (val) => val!.isEmpty ? "Name required" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Age"),
                validator: (val) => val!.isEmpty ? "Age required" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  final name = nameController.text;
                  final age = int.tryParse(ageController.text) ?? 0;

                  if (isEdit) {
                    final updated = widget.student!.copyWith(
                      name: name,
                      age: age,
                    );
                    await widget.db.updateStudent(updated);
                  } else {
                    await widget.db.addStudent(
                      StudentsCompanion(name: Value(name), age: Value(age)),
                    );
                  }

                  Navigator.pop(context);
                },
                child: Text(isEdit ? "Update" : "Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
