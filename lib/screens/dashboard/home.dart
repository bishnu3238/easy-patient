import 'dart:developer';
import 'dart:io';
import 'package:easy_patient/classes/location/location_service.dart';
import 'package:easy_patient/classes/master/administrator.dart';
import 'package:easy_patient/classes/master/specialist_master.dart';
import 'package:easy_patient/screens/dashboard/specialist_view_more.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:easy_patient/screens/dashboard/sub_widget/search_page.dart';
import 'package:easy_patient/screens/dashboard/sub_widget/specialist_view.dart';
import 'package:easy_patient/screens/dashboard/videoCall/video_calling.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../classes/util/customSnackBar.dart';
import '../../classes/webRTC/socket_services.dart';
import '../../customs/custom_appbar.dart';
import '../../customs/custom_sliverappbar.dart';
import '../../customs/custom_textfield.dart';
import 'booked_appointment.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({Key? key}) : super(key: key);

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage>
    with SingleTickerProviderStateMixin {
  // late final tabController = TabController(length: 2, vsync: this);

  // final List<String> specialists = [
  //   'General',
  //   'Cardiologist',
  //   'Dermatologist',
  //   'Endocrinologist',
  //   'Gastroenterologist',
  //   'Hematologist',
  //   'Neurologist',
  //   'Oncologist',
  //   'Ophthalmologist',
  //   'Orthopedist',
  //   'Pediatrician',
  //   'Psychiatrist',
  //   'Pulmonologist',
  //   'Radiologist',
  //   'Rheumatologist',
  //   'Urologist',
  // ];

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
    CustomSnackBar.initialize(context);
    incomingCallStatus();
  }

  void incomingCallStatus() async {
    var data = await SignallingService.instance.listenIncomingCall(context);
    if (data != null && mounted) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (ctx) => VideoCalling(
                    callerId: incomingSDPOffer != null
                        ? incomingSDPOffer["callerId"]!
                        : "9231520717",
                    calleeId:
                        incomingSDPOffer != null ? "9231520717" : "9231665466",
                    offer: incomingSDPOffer != null
                        ? incomingSDPOffer["sdpOffer"]
                        : null,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Specialist> specialists =
        Provider.of<Administrator>(context, listen: false).specialist;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            leadingIcon: IconButton(
                onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.sliders)),
            title: GestureDetector(
              onTap: _openBottomSheet,
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 3.0),
                  Consumer<LocationService>(
                    builder: (context, location, snapshot) {
                      if (location.place.isEmpty) {
                        return const Text("location");
                      } else {
                        return Text(
                          location.place[0].locality!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                    },
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
                    incomingCallStatus();
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.ellipsisVertical,
                    size: 20,
                  ))
            ],
            bottom: TabBar(
              onTap: (i) {
                print(i);
              },
              tabs: const [
                Tab(
                  text: 'Tab 1',
                ),
                Tab(
                  text: 'Tab 2',
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Welcome back!',
                    style:
                        TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomTextField(
                readOnly: true,
                hintText: "Search for a doctor, specialist or diseases",
                prefixIcon: FontAwesomeIcons.magnifyingGlassLocation,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => SpecialistViewMore(
                                specialist: specialists,
                              )));
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              color: Colors.red.shade50,
              child: const Text(
                "Top Disease Specialities",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SpecialistView(
            specialists: specialists,
          ),
          const SliverToBoxAdapter(
            child: Divider(),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              color: Colors.grey.shade100,
              child: const Text(
                "Consult our top doctors",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 250,
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) => Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  color: Colors.grey.shade100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 110,
                        // width: MediaQuery.of(context).size.width * 1 / 2,
                        child: Center(
                          child: Image.asset(
                            "assets/images/doctors.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text("Dr. Doctor Name"),
                      const Text("Orthopaedic - (MBBS)"),
                      Text(
                        "18 Year Experience",
                        style: GoogleFonts.asul(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      RatingBar.builder(
                        initialRating: 3.5,
                        tapOnlyMode: true,
                        ignoreGestures: true,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemSize: 15,
                        itemCount: 5,
                        unratedColor: Colors.grey.shade300,
                        itemPadding: const EdgeInsets.all(2),
                        itemBuilder: (context, _) => FaIcon(
                          FontAwesomeIcons.solidStar,
                          color: Colors.amber.shade900,
                        ),
                        onRatingUpdate: (_) {},
                      ),
                      Text(
                        "200 user",
                        style: GoogleFonts.palanquin(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline),
                      )
                    ],
                  ),
                ),
              ),
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
                    height: 50.0,
                    width: double.maxFinite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => SpecialistViewMore(
                                          specialist: specialists)));
                            },
                            child: _buildAppointmentCard(
                              'Book Appointment',
                              Colors.white,
                              context,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: _buildAppointmentCard(
                              'Appointment History',
                              Colors.orangeAccent,
                              context,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              color: Colors.grey.shade100,
              child: const Text(
                "Symptoms",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(8),
              height: 100.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: symptoms.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                            radius: 30.0,
                            child: ClipOval(
                              child: FadeInImage.assetNetwork(
                                placeholder: "assets/images/doctor.png",
                                image: symptoms[index]['image']!,
                                fit: BoxFit.cover,
                                height: double.maxFinite,
                                imageErrorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Image.asset('assets/images/pill.png',
                                      fit: BoxFit.fill);
                                },
                              ),
                            )
                            // NetworkImage(symptoms[index]['image']!),
                            ),
                        const SizedBox(height: 5.0),
                        Text(symptoms[index]['name']!),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: const [
                Divider(),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ],
      ),
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
            label: 'Medicines',
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
    return Card(color: color, child: Center(child: Text(title)));
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
      child: Scaffold(
        body: Consumer<LocationService>(builder: (context, location, snapshot) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "${location.place[0].locality} - ${location.place[0].postalCode}",
                  style: GoogleFonts.asar(
                      color: Colors.redAccent.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                child: ListTile(
                  onTap: () {
                    var locations =
                        Provider.of<LocationService>(context, listen: false);
                    locations
                        .getCurrentLocation()
                        .then((value) => Navigator.pop(context))
                        .catchError((err) {
                      CustomSnackBar.showSnackBar("Required permission",
                          Colors.red, context, "OPEN SITTINGS", () {
                        locations.getPermission();
                      }, 5000);

                      print("hello $err");
                    });
                  },
                  dense: true,
                  leading: const Icon(FontAwesomeIcons.locationCrosshairs),
                  title: const Text("Use Current Location"),
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
          );
        }),
      ),
    );
  }
}

final List<Map<String, String>> symptoms = [
  {
    'name': 'Fever',
    'image':
        'https://cdn.pixabay.com/photo/2014/04/03/10/30/fever-310721_960_720.png',
  },
  {
    'name': 'Cough',
    'image':
        'https://cdn.pixabay.com/photo/2023/02/25/11/48/cough-7813056_960_720.png',
  },
  {
    'name': 'Fatigue',
    'image':
        'https://cdn.pixabay.com/photo/2019/03/30/10/05/man-4090877_960_720.png',
  },
  {
    'name': 'Headache',
    'image':
        'https://cdn.pixabay.com/photo/2021/11/05/19/42/angry-6771919_960_720.png',
  },
  {
    'name': 'Shortness of breath',
    'image':
        'https://cdn.pixabay.com/photo/2022/10/12/19/23/heart-attack-7517309_960_720.png',
  },
  {
    'name': 'Muscle aches',
    'image':
        'https://cdn.pixabay.com/photo/2020/05/09/11/03/pain-5149164_960_720.png',
  },
  {
    'name': 'Sore throat',
    'image':
        'https://cdn.pixabay.com/photo/2015/04/16/17/44/sore-726012_960_720.jpg',
  },
];
