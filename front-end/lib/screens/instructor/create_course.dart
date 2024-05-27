import 'package:ecom_ass/server/api_handler.dart';
import 'package:flutter/material.dart';

class CreateCourseScreen extends StatefulWidget {
  const CreateCourseScreen({super.key, required this.instructorId});
  final String instructorId;

  @override
  State<CreateCourseScreen> createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  Future<void> createCourse() async {
    if (_formKey.currentState!.validate()) {
      var response = await ApiHandler.createCourseApi(
          nameController.text,
          durationController.text,
          categoryController.text,
          capacityController.text,
          widget.instructorId);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Course created successfully!'),
            duration: Duration(seconds: 7),
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.body)),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill inputs')),
      );
    }
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                icon: const Icon(Icons.arrow_back_rounded),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            const Text(
                              "Create a course",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 40, width: 40),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Name"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter course name';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: TextFormField(
                            controller: durationController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Duration"),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  num.tryParse(value) == null ||
                                  int.parse(value) < 1) {
                                return 'Please enter course duration';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: TextFormField(
                            controller: categoryController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Category"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter course Category';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: TextFormField(
                            controller: capacityController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Capacity"),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  num.tryParse(value) == null ||
                                  int.parse(value) < 1) {
                                return 'Please enter course capacity';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16.0),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: createCourse,
                              child: const Text('Create course'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
