import 'package:ecom_ass/screens/admin/view_admin_course.dart';
import 'package:ecom_ass/server/api_handler.dart';
import 'package:ecom_ass/server/models/admin_course.dart';
import 'package:flutter/material.dart';

class ViewAdminCoursesScreen extends StatefulWidget {
  const ViewAdminCoursesScreen({super.key});

  @override
  State<ViewAdminCoursesScreen> createState() => _ViewAdminCoursesState();
}

class _ViewAdminCoursesState extends State<ViewAdminCoursesScreen> {
  List<AdminCourseModel> courses = [];
  @override
  void initState() {
    super.initState();
    getAllCourses();
  }

  Future<void> getAllCourses() async {
    courses = await ApiHandler.getAdminCourses();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
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
                        "View all courses",
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
                  const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                            width: 130,
                            child: Center(
                              child: Text('Name',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            )),
                        SizedBox(
                            width: 70,
                            child: Center(
                              child: Text('Duration',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            )),
                        SizedBox(
                            width: 230,
                            child: Center(
                              child: Text('Category',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            )),
                        SizedBox(
                            width: 90,
                            child: Center(
                              child: Text('Published',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            )),
                      ]),
                  Expanded(
                    child: ListView.builder(
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewAdminCourseScreen(
                                    course: courses[index],
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 130,
                                    child: Center(
                                      child: Text(
                                        courses[index].name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 70,
                                    child: Center(
                                      child: Text(
                                        courses[index].duration.toString(),
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 230,
                                    child: Center(
                                      child: Text(
                                        courses[index].category,
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 90,
                                    child: Center(
                                      child: Text(
                                        courses[index].published.toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: courses[index].published
                                                ? Colors.green
                                                : Colors.red),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
