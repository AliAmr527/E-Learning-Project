import 'package:ecom_ass/server/api_handler.dart';
import 'package:ecom_ass/server/models/request.dart';
import 'package:flutter/material.dart';

class CourseRequests extends StatefulWidget {
  const CourseRequests({super.key, required this.instructorId});
  final String instructorId;

  @override
  State<CourseRequests> createState() => CourseRequestsState();
}

class CourseRequestsState extends State<CourseRequests> {
  List<RequestModel> requests = [];
  @override
  void initState() {
    super.initState();
    getRequests();
  }

  Future<void> getRequests() async {
    requests = await ApiHandler.getRequests(widget.instructorId);
    setState(() {});
  }

  Future<void> manageRequest(var name, var studentId, var courseId) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          TextButton(
              onPressed: () async {
                var response = await ApiHandler.approveRequest(
                    widget.instructorId, courseId, name, studentId);
                if (response.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('$name\'s Request approved Successfully!'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(response.body),
                  ));
                }
                Navigator.pop(context);
              },
              child: const Text("Approve")),
          TextButton(
              onPressed: () async {
                var response = await ApiHandler.denyRequest(
                    widget.instructorId, courseId, name, studentId);
                if (response.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('$name\'s Request denied Successfully!'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(response.body),
                  ));
                }
                Navigator.pop(context);
              },
              child: const Text("Reject"))
        ],
        title: const Text('Manage Request'),
        contentPadding: const EdgeInsets.all(15.0),
        content: Text('Would you like to approve $name\'s request?'),
      ),
    );
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
                        "Enrollment Requests",
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
                  Visibility(
                    visible: requests.isNotEmpty,
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: requests.length,
                        itemBuilder: (context, requestIndex) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${requests[requestIndex].name} (${requests[requestIndex].students.length}): ",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 10),
                                  child: SizedBox(
                                    height: 125,
                                    child: ListView.builder(
                                      itemCount: requests[requestIndex]
                                          .students
                                          .length,
                                      itemBuilder: (context, studentIndex) {
                                        return ListTile(
                                          title: Text(requests[requestIndex]
                                              .students[studentIndex]
                                              .name),
                                          leading: const CircleAvatar(
                                            child: Icon(Icons.person),
                                          ),
                                          trailing: const Icon(
                                              Icons.chevron_right_outlined),
                                          onTap: () async {
                                            await manageRequest(
                                                requests[requestIndex]
                                                    .students[studentIndex]
                                                    .name,
                                                requests[requestIndex]
                                                    .students[studentIndex]
                                                    .id,
                                                requests[requestIndex].id);
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CourseRequests(
                                                            instructorId: widget
                                                                .instructorId)));
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: requests.isEmpty,
                    child: const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("No requests found"),
                        ],
                      ),
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
