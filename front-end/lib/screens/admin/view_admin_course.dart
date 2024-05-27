import 'package:ecom_ass/screens/admin/edit_course_details.dart';
import 'package:ecom_ass/server/api_handler.dart';
import 'package:ecom_ass/server/models/admin_course.dart';
import 'package:flutter/material.dart';

class ViewAdminCourseScreen extends StatefulWidget {
  const ViewAdminCourseScreen({super.key, required this.course});
  final AdminCourseModel course;

  @override
  State<ViewAdminCourseScreen> createState() => _ViewAdminCourseScreenState();
}

class _ViewAdminCourseScreenState extends State<ViewAdminCourseScreen> {
  Future<void> publishCourse() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          TextButton(
              onPressed: () async {
                var response = await ApiHandler.publishCourse(widget.course.id);
                if (response.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Course has been published Successfully!'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(response.body),
                  ));
                }
                Navigator.popUntil(
                    context, (route) => route.settings.name == "/AdminScreen");
              },
              child: const Text("Yes")),
          TextButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: const Text("No"))
        ],
        title: const Text('Publish Course?'),
        contentPadding: const EdgeInsets.all(15.0),
        content: const Text('Are you sure you want to publish this course?'),
      ),
    );
  }

  Future<void> deleteCourse() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          TextButton(
              onPressed: () async {
                var response = await ApiHandler.removeCourse(widget.course.id);
                if (response.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Course has been Deleted Successfully!'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(response.body),
                  ));
                }
                Navigator.popUntil(
                    context, (route) => route.settings.name == "/AdminScreen");
              },
              child: const Text("Yes")),
          TextButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: const Text("No"))
        ],
        title: const Text('Delete Course?'),
        contentPadding: const EdgeInsets.all(15.0),
        content: const Text('Are you sure you want to Delete this course?'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
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
                        'Course',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40, width: 40),
                    ],
                  ),
                  Text(
                    widget.course.name,
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Course Information',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 120,
                              child: Text(
                                'Name',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              ':  ${widget.course.name}',
                              style: const TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 120,
                              child: Text(
                                'Duration',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              ':  ${widget.course.duration}',
                              style: const TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 120,
                              child: Text(
                                'Category',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              ':  ${widget.course.category}',
                              style: const TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 120,
                              child: Text(
                                'Capacity',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              ':  ${widget.course.capacity} students',
                              style: const TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: widget.course.published,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 120,
                                    child: Text(
                                      'Rating',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    ':  ${widget.course.rating}',
                                    style: const TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 120,
                                    child: Text(
                                      'Requested Students',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    ':  ${widget.course.requestedStudents} students',
                                    style: const TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 120,
                                    child: Text(
                                      'Enrolled Students',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    ':  ${widget.course.enrolledStudents} students',
                                    style: const TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 120,
                                    child: Text(
                                      'Past Students',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    ':  ${widget.course.pastStudents} students',
                                    style: const TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 120,
                              child: Text(
                                'Published',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              ':  ${widget.course.published}',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: widget.course.published
                                      ? Colors.green
                                      : Colors.red),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: deleteCourse,
                              child: const Text('Delete course',
                                  style: TextStyle(color: Colors.red)),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditCourseDetailsScreen(
                                            course: widget.course),
                                  ),
                                );
                              },
                              child: const Text('Edit course'),
                            ),
                            const SizedBox(width: 20),
                            Visibility(
                              visible: !widget.course.published,
                              child: ElevatedButton(
                                onPressed: publishCourse,
                                child: const Text('Publish course',
                                    style: TextStyle(color: Colors.green)),
                              ),
                            ),
                          ],
                        )
                      ],
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
