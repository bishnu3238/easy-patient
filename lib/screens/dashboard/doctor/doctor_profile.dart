import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../classes/doctors/doctor_model.dart';
import '../booked_datetime.dart';

class DoctorProfile extends StatelessWidget {
  final Doctor doctor;
  const DoctorProfile({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left_outlined),
        ),
        title: Text(
          "Doctor's Profile",
          style: GoogleFonts.orbitron(
              fontWeight: FontWeight.w900, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              "Dr. ${doctor.doctor_name}",
              style: GoogleFonts.orbitron(fontWeight: FontWeight.w900),
            ),
            subtitle: const Text("Neurologist Specialist"),
            trailing: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/doctor.png"),
            ),
          ),
          const SizedBox(height: 30),
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
            "3.5 Out of 5.0",
            style: GoogleFonts.share(fontWeight: FontWeight.w900),
          ),
          const Text("211 Patient review"),
          Container(
            child: Row(
              children: [
                Container(
                  child: IconButton(
                      onPressed: () {}, icon: Icon(Icons.video_call_sharp)),
                ),
              ],
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        Center(
          child: FilledButton.tonalIcon(
              style: ButtonStyle(
                fixedSize: const MaterialStatePropertyAll(
                    Size.fromWidth(double.maxFinite)),
                backgroundColor:
                    MaterialStatePropertyAll(Colors.blueGrey.shade900),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => BookedDateTime(
                              doctor: doctor,
                              index: 0,
                            )));
              },
              icon: const Icon(FontAwesomeIcons.houseChimneyMedical),
              label: const Text(" Request For Appointment")),
        ),
      ],
    );
  }
}
