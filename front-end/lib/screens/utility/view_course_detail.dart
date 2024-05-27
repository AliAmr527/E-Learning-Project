import 'package:ecom_ass/server/api_handler.dart';
import 'package:ecom_ass/server/models/course.dart';
import 'package:flutter/material.dart';

class ViewCourseDetail extends StatefulWidget {
  const ViewCourseDetail({
    super.key,
    required this.course,
    required this.userId,
    required this.role,
    required this.userName,
  });
  final CourseModel course;
  final String userId;
  final String userName;
  final String role;

  @override
  State<ViewCourseDetail> createState() => _ViewCourseDetailState();
}

class _ViewCourseDetailState extends State<ViewCourseDetail> {
  Future<void> applyForCourse() async {
    var response = await ApiHandler.applyForCourse(
      widget.course.id,
      widget.userName,
      widget.userId,
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Applied for course successfully!'),
          duration: Duration(seconds: 7),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.body)),
      );
    }
    Navigator.pop(context);
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
                      Text(
                        widget.course.name,
                        style: const TextStyle(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(widget.course.duration.toString()),
                          const Text('Duration',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          Text(widget.course.category),
                          const Text('Category',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          Text(widget.course.rating.toString()),
                          const Text('Rating',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          Text(widget.course.capacity.toString()),
                          const Text('Capacity',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          Text(widget.course.enrolledStudents.toString()),
                          const Text('Enrolled',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Reviews: ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Visibility(
                    visible: widget.course.reviews.isNotEmpty,
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: widget.course.reviews.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(widget.course.reviews[index].createdBy),
                            subtitle: Text(widget.course.reviews[index].review),
                            leading:
                                const CircleAvatar(child: Icon(Icons.person)),
                          );
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.course.reviews.isEmpty,
                    child: const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('No reviews yet'),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.role == 'student',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: applyForCourse,
                          child: const Text('Apply for course'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
