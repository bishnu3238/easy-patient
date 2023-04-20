import 'dart:developer';

import 'package:easy_patient/classes/master/specialist_master.dart';
import 'package:easy_patient/customs/custom_textfield.dart';
import 'package:easy_patient/screens/dashboard/booked_appointment.dart';
import 'package:easy_patient/screens/dashboard/sub_widget/search_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../classes/doctors/doctor_master.dart';
import '../../classes/location/location_service.dart';

class SpecialistViewMore extends StatelessWidget {
  final List<Specialist> specialist;
  const SpecialistViewMore({Key? key, required this.specialist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var doctor = Provider.of<DoctorMaster>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        leadingWidth: 35,
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "location",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.shopping_cart_rounded))
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                  hintText: "Search doctor, diseases etc ...",
                  hintStyle:
                      TextStyle(fontSize: 10, fontWeight: FontWeight.w200),
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  suffix: FaIcon(FontAwesomeIcons.microphone)),
              autofocus: true,
              onChanged: (searching) {},
              onSubmitted: (data) {},
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // SliverAppBar(
              //   backgroundColor: Colors.blueGrey.shade900,
              //   pinned: true,
              //   // snap: true,
              //   // floating: true,
              //   iconTheme: const IconThemeData(color: Colors.white),
              //   title: const Text(
              //     "location",
              //     style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 20,
              //         fontWeight: FontWeight.w900),
              //   ),
              //   actions: [
              //     IconButton(
              //         onPressed: () {},
              //         icon: const Icon(Icons.shopping_cart_rounded))
              //   ],
              //   bottom: PreferredSize(
              //     preferredSize: Size.fromHeight(
              //         kToolbarHeight + MediaQuery.of(context).padding.top),
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: TextField(
              //         cursorColor: Colors.black,
              //         decoration: const InputDecoration(
              //             hintText: "Search doctor, diseases etc ...",
              //             hintStyle: TextStyle(
              //                 fontSize: 10, fontWeight: FontWeight.w200),
              //             fillColor: Colors.white,
              //             filled: true,
              //             focusedBorder: InputBorder.none,
              //             enabledBorder: InputBorder.none,
              //             errorBorder: InputBorder.none,
              //             disabledBorder: InputBorder.none,
              //             contentPadding: EdgeInsets.only(
              //                 left: 15, bottom: 11, top: 11, right: 15),
              //             suffix: FaIcon(FontAwesomeIcons.microphone)),
              //         autofocus: true,
              //         onChanged: (searching) {},
              //         onSubmitted: (data) {},
              //       ),
              //       // CustomTextField(
              //       //   hintText: "search doctor, specialities or disease",
              //       //   prefixIcon: Icons.search,
              //       //   onTap: () {
              //       //     Navigator.push(
              //       //         context,
              //       //         MaterialPageRoute(
              //       //             builder: (ctx) => const SearchPage()));
              //       //   },
              //       // ),
              //     ),
              //   ),
              //   expandedHeight: (kToolbarHeight * 2),
              // ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      color: Colors.grey.shade100,
                      child: const Text(
                        "Top Specialities",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
              SliverGrid.builder(
                  itemCount: specialist.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        var patientCity =
                            Provider.of<LocationService>(context, listen: false)
                                .place[0]
                                .locality;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => BookedAppointment(
                                      doctor:
                                          doctor.getDoctorAccordingToSpecialist(
                                              "${specialist[index].id}"),
                                      category: {
                                        "type": "specialities",
                                        "department":
                                            specialist[index].special_name
                                      },
                                    )));
                      },
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
                              child: Text(specialist[index].special_name,
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      overflow: TextOverflow.ellipsis)),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              const SliverToBoxAdapter(child: Divider()),
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 8),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  color: Colors.grey.shade100,
                  child: const Text(
                    "Other Symptoms",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: 8,
                  (ctx, ind) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        tileColor: Colors.grey.shade100,
                        title: const Text("Specialities"),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.diamondTurnRight,
                            size: 18,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        dense: true,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.grey.shade600,
                            ),
                            borderRadius: BorderRadius.circular(18.0)),
                      ),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: const [
                    Divider(),
                    SizedBox(
                      height: 100.0,
                      child: Center(
                        child: Text("EazyTechno"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
