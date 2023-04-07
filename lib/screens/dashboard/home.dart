import 'dart:developer';
import 'dart:io';

import 'package:easy_patient/screens/dashboard/videoCall/video_calling.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../classes/webRTC/socket_services.dart';
import '../../customs/custom_appbar.dart';
import '../../customs/custom_sliverappbar.dart';
import '../../customs/custom_textfield.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({Key? key}) : super(key: key);

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  final List<String> specialists = [
    'General',
    'Cardiologist',
    'Dermatologist',
    'Endocrinologist',
    'Gastroenterologist',
    'Hematologist',
    'Neurologist',
    'Oncologist',
    'Ophthalmologist',
    'Orthopedist',
    'Pediatrician',
    'Psychiatrist',
    'Pulmonologist',
    'Radiologist',
    'Rheumatologist',
    'Urologist',
  ];

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home'),
    Text('Appointments'),
    Text('Profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return const MyBottomSheet();
      },
    );
  }

  dynamic incomingSDPOffer;
  @override
  void initState() {
    super.initState();
    // TODO: implement initStat
    listen();
  }

  Future listen() async {
    // listen for incoming video call
    SignallingService.instance.socket!.on("newCall", (data) {
      print("data: $data");
      // if (!mounted) {
      // set SDP Offer of incoming call
      setState(() => incomingSDPOffer = data);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: incomingSDPOffer != null
              ? Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text("Incoming call"),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.call_end),
                        color: Colors.redAccent,
                        onPressed: () {
                          setState(() => incomingSDPOffer = null);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.call),
                        color: Colors.greenAccent,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => VideoCalling(
                                        callerId: incomingSDPOffer != null
                                            ? incomingSDPOffer["callerId"]!
                                            : "9231520717",
                                        calleeId: incomingSDPOffer != null
                                            ? "9231520717"
                                            : "9231665466",
                                        offer: incomingSDPOffer != null
                                            ? incomingSDPOffer["sdpOffer"]
                                            : null,
                                      )));
                          // incomingSDPOffer = null;
                          // setState(() => incomingSDPOffer = null);
                          // Navigator.push(
                          //   context,
                          //   SlideRoutingLToR(
                          //     widget: VideoCalling(
                          //       callerId: incomingSDPOffer != null
                          //           ? incomingSDPOffer["callerId"]!
                          //           : Provider.of<DocOck>(context, listen: false)
                          //           .doctor
                          //           .phoneNo,
                          //       calleeId: incomingSDPOffer != null
                          //           ? Provider.of<DocOck>(context, listen: false)
                          //           .doctor
                          //           .phoneNo
                          //           : widget.patient.phone,
                          //       patient: widget.patient,
                          //       offer: incomingSDPOffer != null
                          //           ? incomingSDPOffer["sdpOffer"]
                          //           : null,
                          //     ),
                          //   ),
                          // );
                        },
                      )
                    ],
                  ),
                )
              : null,
        ),

        CustomSliverAppBar(
          leadingIcon: IconButton(
              onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.sliders)),
          title: GestureDetector(
            onTap: _openBottomSheet,
            child: Row(
              children: const [
                Icon(
                  Icons.location_on,
                  color: Colors.black,
                ),
                SizedBox(width: 3.0),
                Text(
                  "location",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => VideoCalling(
                                callerId: incomingSDPOffer != null
                                    ? incomingSDPOffer["callerId"]!
                                    : "9231520717",
                                calleeId: incomingSDPOffer != null
                                    ? "9231520717"
                                    : "9231665466",
                                offer: incomingSDPOffer != null
                                    ? incomingSDPOffer["sdpOffer"]
                                    : null,
                              )));
                },
                icon: const FaIcon(
                  FontAwesomeIcons.bell,
                  size: 20,
                )),
            IconButton(
                onPressed: () {
                  listen();
                },
                icon: const FaIcon(
                  FontAwesomeIcons.ellipsisVertical,
                  size: 20,
                ))
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Tab 1',
              ),
              Tab(
                text: 'Tab 2',
              ),
            ],
          ),
        ),

        ///
        // SliverAppBar(
        //   floating: true,
        //   backgroundColor: Colors.white,
        //   leading: IconButton(
        //       onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.sliders)),
        //   title: GestureDetector(
        //     onTap: _openBottomSheet,
        //     child: Row(
        //       children: const [
        //         Icon(
        //           Icons.location_on,
        //           color: Colors.black,
        //         ),
        //         SizedBox(width: 3.0),
        //         Text(
        //           "location",
        //           style: TextStyle(
        //             color: Colors.black,
        //             fontSize: 18.0,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        //   actions: [
        //     IconButton(
        //         onPressed: () {},
        //         icon: const FaIcon(
        //           FontAwesomeIcons.ellipsisVertical,
        //           size: 20,
        //         ))
        //   ],
        // ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Welcome back!',
                  style: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Patient Name',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CustomTextField(
              hintText: "Search for a doctor or specialist",
              prefixIcon: FontAwesomeIcons.magnifyingGlassLocation,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 6.0,
              mainAxisSpacing: 6.0,
              childAspectRatio: 0.85,
            ),
            itemCount: specialists.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == specialists.length - 1) {
                return GestureDetector(
                  onTap: () {},
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
                          child: Text(specialist,
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  overflow: TextOverflow.ellipsis)),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Book Appointment',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  height: 120.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // scrollDirection: Axis.horizontal,
                    children: [
                      Expanded(
                        child: _buildAppointmentCard(
                          'Book Appointment',
                          Colors.white,
                          context,
                        ),
                      ),
                      Expanded(
                        child: _buildAppointmentCard(
                          'Appointment History',
                          Colors.orangeAccent,
                          context,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),
                // const Text(
                //   'My Medical Records',
                //   style: TextStyle(
                //     fontSize: 18.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                SizedBox(height: 16.0),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     _buildRecordCard(
                //       'Blood Test Results',
                //       'Nov 22, 2022',
                //       Icons.file_copy,
                //       Colors.redAccent,
                //       context,
                //     ),
                //     _buildRecordCard(
                //       'X-Ray Results',
                //       'Oct 15, 2022',
                //       Icons.file_copy,
                //       Colors.orangeAccent,
                //       context,
                //     ),
                //     _buildRecordCard(
                //       'MRI Results',
                //       'Sep 30, 2022',
                //       Icons.file_copy,
                //       Colors.greenAccent,
                //       context,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.blueGrey.shade400,
        unselectedLabelStyle: TextStyle(color: Colors.blueGrey.shade400),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.houseMedicalCircleCheck),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueGrey.shade900,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildAppointmentCard(
      String title, Color color, BuildContext context) {
    return Container(
      width: 240.0,
      margin: const EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(child: Text(title)),
    );
  }
}

class SpecialistCard extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const SpecialistCard({super.key, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(name),
        ),
      ),
    );
  }
}

class MyBottomSheet extends StatefulWidget {
  const MyBottomSheet({super.key});

  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  String _searchText = '';

  final List<String> _popularCities = [
    'New York',
    'London',
    'Paris',
    'Tokyo',
    'Sydney',
    'Los Angeles',
    'Dubai',
    'Singapore',
    'Barcelona',
    'Hong Kong',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Current Location  "),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomTextField(
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
              hintText: 'Search city',
              prefixIcon: FontAwesomeIcons.magnifyingGlassLocation,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _popularCities.length,
              itemBuilder: (BuildContext context, int index) {
                if (_searchText.isNotEmpty &&
                    !_popularCities[index]
                        .toLowerCase()
                        .contains(_searchText.toLowerCase())) {
                  return Container();
                }
                return ListTile(
                  title: Text(_popularCities[index]),
                  onTap: () {
                    // Add your code here
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
