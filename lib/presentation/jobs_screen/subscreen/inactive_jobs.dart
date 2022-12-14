import 'package:flutter/material.dart';
import 'package:sgt/presentation/jobs_screen/widgets/job_tiles.dart';

class InactiveJobsTab extends StatelessWidget {
  const InactiveJobsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          return Column(
            children: const [
              JobsTile(
                isActive: false,
              ),
              Divider(
                color: Colors.grey,
              ),
            ],
          );
        });
  }
}
