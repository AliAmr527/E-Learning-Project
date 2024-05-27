import 'package:ecom_ass/server/api_handler.dart';
import 'package:ecom_ass/server/models/stats.dart';
import 'package:flutter/material.dart';

class PlatformStatsScreen extends StatefulWidget {
  const PlatformStatsScreen({super.key});

  @override
  State<PlatformStatsScreen> createState() => _PlatformStatsScreenState();
}

class _PlatformStatsScreenState extends State<PlatformStatsScreen> {
  StatsModel stats = StatsModel.withDefaults();
  @override
  void initState() {
    super.initState();
    getStats();
  }

  Future<void> getStats() async {
    stats = await ApiHandler.getStats();
    // await ApiHandler.getStats();
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
                        'Platform Stats',
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
                  const Text(
                    'Top Courses',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            stats.enrolled.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(stats.enrolled.score.toString()),
                          const Text('Top Enrolled',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            stats.rated.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(stats.rated.score.toString()),
                          const Text('Highest Rated',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            stats.reviewed.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(stats.reviewed.score.toString()),
                          const Text('Most Reviewed',
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
                      Text('Course Stats: ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Visibility(
                    visible: stats.courses.isNotEmpty,
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: stats.courses.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(stats.courses[index].name),
                            subtitle: Row(
                              children: [
                                Text('Rating: ${stats.courses[index].rating}'),
                                const SizedBox(width: 10),
                                Text(
                                    'Enrolled: ${stats.courses[index].enrolledStudents}'),
                                const SizedBox(width: 10),
                                Text(
                                    'Reviewed: ${stats.courses[index].reviews}'),
                              ],
                            ),
                            leading: const CircleAvatar(
                                child: Icon(Icons.menu_book_rounded)),
                          );
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: stats.courses.isEmpty,
                    child: const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('No Courses yet'),
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
