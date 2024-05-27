import 'package:ecom_ass/screens/instructor/course_requests.dart';
import 'package:ecom_ass/screens/instructor/create_course.dart';
import 'package:ecom_ass/screens/utility/search_course.dart';
import 'package:ecom_ass/screens/utility/view_all_courses.dart';
import 'package:ecom_ass/screens/utility/sign_in_screen.dart';
import 'package:flutter/material.dart';

class InstructorScreen extends StatefulWidget {
  const InstructorScreen(
      {super.key, required this.instructorName, required this.instructorId});
  final String instructorName;
  final String instructorId;
  @override
  State<InstructorScreen> createState() => _InstructorScreenState();
}

class _InstructorScreenState extends State<InstructorScreen> {
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Column(
                    children: [
                      const Text(
                        "Instructor",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(widget.instructorName,
                          style: const TextStyle(fontSize: 24)),
                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16.0),
                        child: Center(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateCourseScreen(
                                          instructorId: widget.instructorId,
                                        )),
                              );
                            },
                            icon: const Icon(Icons.add),
                            label: const Text('Create course'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16.0),
                        child: Center(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewAllCourses(
                                          userId: widget.instructorId,
                                          role: 'instructor',
                                          userName: widget.instructorName,
                                        )),
                              );
                            },
                            icon: const Icon(Icons.menu_rounded),
                            label: const Text('View all courses'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16.0),
                        child: Center(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchCourseScreen(
                                          userId: widget.instructorId,
                                          role: 'instructor',
                                          userName: widget.instructorName,
                                        )),
                              );
                            },
                            icon: const Icon(Icons.manage_search_rounded),
                            label: const Text('Search for courses'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16.0),
                        child: Center(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CourseRequests(
                                          instructorId: widget.instructorId,
                                        )),
                              );
                            },
                            icon: const Icon(Icons.edit_note_rounded),
                            label: const Text('Manage enrollment requsts'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16.0),
                        child: Center(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("You have been logged out!"),
                              ));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignInScreen()),
                              );
                            },
                            icon: const Icon(Icons.logout_rounded,
                                color: Colors.red),
                            label: const Text('Logout',
                                style: TextStyle(color: Colors.red)),
                          ),
                        ),
                      ),
                    ],
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
