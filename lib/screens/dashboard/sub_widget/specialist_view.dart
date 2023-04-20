import 'package:flutter/material.dart';

import '../../../classes/master/specialist_master.dart';
import '../specialist_view_more.dart';

class SpecialistView extends StatelessWidget {
  final List<Specialist> specialists;
  const SpecialistView({Key? key, required this.specialists}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 6.0,
          mainAxisSpacing: 6.0,
          childAspectRatio: 0.85,
        ),
        itemCount: specialists.length >= 8 ? 8 : specialists.length,
        itemBuilder: (BuildContext context, int index) {
          if (index ==
              (specialists.length >= 8 ? 8 - 1 : specialists.length - 1)) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => SpecialistViewMore(
                      specialist: specialists,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.blueGrey[200],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.mouse_rounded,
                      size: 30.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("view more",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 16.0,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis)),
                    ),
                  ],
                ),
              ),
            );
          } else {
            var specialist = specialists[index];
            return GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey[200],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.delivery_dining, size: 50.0),
                    const SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(specialist.special_name,
                          style: const TextStyle(
                              fontSize: 16.0, overflow: TextOverflow.ellipsis)),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
