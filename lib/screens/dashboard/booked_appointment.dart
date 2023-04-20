import 'package:easy_patient/classes/doctors/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../import.dart';
import 'booked_datetime.dart';
import 'doctor/doctor_profile.dart';

class BookedAppointment extends StatelessWidget {
  final Map category;
  final List<Doctor> doctor;
  const BookedAppointment(
      {Key? key, required this.category, required this.doctor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          category['department'],
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              color: Colors.grey.shade50,
              child: const Text(
                "Top doctors clinic near you",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: doctor.length,
              (context, index) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Card(
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            Card(
                                              margin: const EdgeInsets.fromLTRB(
                                                  8, 8, 8, 0),
                                              elevation: 12.0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0)),
                                              child: ClipRRect(
                                                clipBehavior: Clip.antiAlias,
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                child: Image.asset(
                                                  'assets/images/doctors.png',
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.18,
                                                  fit: BoxFit.fill,
                                                  errorBuilder:
                                                      (context, object, trace) {
                                                    return Image.asset(
                                                        'assets/images/logo.png');
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                doctor[index]
                                                    .doctor_name
                                                    .toUpperCase(),
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.aleo(
                                                    fontWeight: FontWeight.w900,
                                                    letterSpacing: 1.2,
                                                    fontSize: 15),
                                              ),
                                              const SizedBox(height: 3.0),
                                              Text(
                                                  "Department ${category["department"]}"),
                                              const Text("7 Years Exp."),
                                              Text(doctor[index].qulifica),
                                              const Text("Fees"),
                                              Text('address',
                                                  textAlign: TextAlign.left,
                                                  style: GoogleFonts
                                                      .ibarraRealNova(
                                                          color: Colors.grey,
                                                          letterSpacing: 1.0,
                                                          fontSize: 12)),
                                              const SizedBox(height: 5.0),
                                              // RichText(
                                              //   text: TextSpan(
                                              //       text: 'Telephone No:  ',
                                              //       style: GoogleFonts.itim(
                                              //           color: Colors.grey[800],
                                              //           fontWeight: FontWeight.w900,
                                              //           fontSize: media.phoneWidth * 0.035,
                                              //           letterSpacing: 1.0),
                                              //       children: const [
                                              //         TextSpan(text: 'mobile_no'),
                                              //       ]),
                                              // ),
                                              Row(
                                                children: [
                                                  RatingBar.builder(
                                                    initialRating: 3.5,
                                                    tapOnlyMode: true,
                                                    ignoreGestures: true,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemSize: 15,
                                                    itemCount: 5,
                                                    unratedColor:
                                                        Colors.grey.shade300,
                                                    itemPadding:
                                                        const EdgeInsets.all(2),
                                                    itemBuilder: (context, _) =>
                                                        FaIcon(
                                                      FontAwesomeIcons
                                                          .solidStar,
                                                      color:
                                                          Colors.amber.shade900,
                                                    ),
                                                    onRatingUpdate: (_) {},
                                                  ),
                                                  const Text(
                                                    " | ",
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  Text(
                                                    "200 user review",
                                                    style:
                                                        GoogleFonts.palanquin(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 5.0),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: FilledButton.tonalIcon(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.blueGrey.shade900),
                                              shape:
                                                  const MaterialStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.zero),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (ctx) =>
                                                          BookedDateTime(
                                                              doctor:
                                                                  doctor[index],
                                                              index: 0)));
                                            },
                                            icon: const Icon(
                                                FontAwesomeIcons.video),
                                            label: const Text(
                                                "Book Consult Online")),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: FilledButton.tonalIcon(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.blueGrey.shade900),
                                            shape:
                                                const MaterialStatePropertyAll(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.zero),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (ctx) =>
                                                        BookedDateTime(
                                                            doctor:
                                                                doctor[index],
                                                            index: 1)));
                                          },
                                          icon: const Icon(FontAwesomeIcons
                                              .houseChimneyMedical),
                                          label: const Text("Visit Clinic"),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Divider(thickness: 2),
                      ],
                    ),
                    Positioned(
                      right: 10.0,
                      top: 0.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => DoctorProfile(
                                        doctor: doctor[index],
                                      )));
                        },
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          color: Colors.redAccent.shade100,
                          child: const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
