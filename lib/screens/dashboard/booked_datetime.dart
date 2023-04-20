import 'package:easy_patient/classes/doctors/doctor_chamber_model.dart';
import 'package:easy_patient/classes/master/administrator.dart';
import 'package:easy_patient/screens/dashboard/doctor/doctor_profile.dart';
import 'package:easy_patient/screens/dashboard/sub_widget/clinic_visit.dart';
import 'package:easy_patient/screens/dashboard/sub_widget/video_consult.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../classes/doctors/doctor_master.dart';
import '../../classes/doctors/doctor_model.dart';

class BookedDateTime extends StatefulWidget {
  final Doctor doctor;
  final int index;
  const BookedDateTime({Key? key, required this.doctor, required this.index})
      : super(key: key);

  @override
  State<BookedDateTime> createState() => _BookedDateTimeState();
}

class _BookedDateTimeState extends State<BookedDateTime>
    with SingleTickerProviderStateMixin {
  late TabController tabController =
      TabController(length: 2, vsync: this, initialIndex: widget.index);
  DateTime _selectedDate = DateTime.now();
  int selectedDateIndex = 0;
  var doctor;
  late List<DoctorChamberModel> doctorChamber;
  List times = [];
  late List timeSlot;
  int selectedIndex = 0;
  bool hasSlot = false;

  @override
  void initState() {
    super.initState();

    doctor = Provider.of<DoctorMaster>(context, listen: false);
    doctorChamber = doctor.getDoctorChambars(widget.doctor.doc_id);
    showSlotAvailable();
  }

  void showSlotAvailable() {
    print(_selectedDate.weekday);

    hasSlot = Provider.of<Administrator>(context, listen: false)
        .selectedDateAvailable(_selectedDate, doctorChamber[0]);
    hasSlot
        ? times = Provider.of<Administrator>(context, listen: false)
            .getTimeSlots(doctorChamber[0].timing[0].from_time,
                doctorChamber[0].timing[0].to_time)
        : null;
    timeSlot = List.filled(times.length, false);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Booked Appointment",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.filter))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              dense: true,
              leading: const CircleAvatar(
                radius: 30,
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/150'),
              ),
              title: Text(
                'Dr. John ${widget.doctor.doctor_name}',
                style: GoogleFonts.orbitron(
                    fontWeight: FontWeight.w900,
                    color: Colors.blueGrey.shade900),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Cardiologist'),
                  Text('St. Mary Clinic'),
                  SizedBox(height: 4),
                ],
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Colors.grey.shade400,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) =>
                              DoctorProfile(doctor: widget.doctor)));
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(height: 1),
          TabBar(controller: tabController, tabs: const [
            Tab(
              child: Text("Video Consult"),
            ),
            Tab(
              child: Text("Clinic Visit"),
            )
          ]),
          const SizedBox(height: 10),
          const Divider(height: 1),
          Row(
            children: List.generate(
              7,
              (index) {
                final date = DateTime.now().add(Duration(days: index));
                final dateFormat = DateFormat('EEE\ndd\nMMMM', 'en_US');
                final color = selectedDateIndex == index
                    ? Colors.black
                    : Colors.grey[400];
                final dates = dateFormat.format(date).split('\n');

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDate = date;
                        selectedDateIndex = index;
                        showSlotAvailable();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[400]!,
                            width: 1.5,
                          ),
                          right: BorderSide(
                            color: Colors.grey[400]!,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            dates[0],
                            style: textTheme.bodySmall?.copyWith(color: color),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            dates[1],
                            style: textTheme.titleLarge?.copyWith(color: color),
                          ),
                          Text(
                            dates[2],
                            style: textTheme.bodyMedium?.copyWith(color: color),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )..add(
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      _selectedDate = (await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                          initialDate: DateTime.now()))!;
                      setState(() => selectedDateIndex = 8);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[400]!,
                            width: 1.5,
                          ),
                          right: BorderSide(
                            color: Colors.grey[400]!,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Pick",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.grey.shade400),
                          ),
                          const SizedBox(height: 4.0),
                          const Icon(Icons.calendar_today),
                          Text(
                            "Date",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.grey.shade400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: const BoxDecoration(),
            child: Center(
              child: Text(
                DateFormat.yMMMMd().format(_selectedDate),
                style: textTheme.titleLarge!
                    .copyWith(color: Colors.brown.shade900),
              ),
            ),
          ),


          Expanded(
            child: TabBarView(controller: tabController, children: [
              VideoConsult(),
              ClinicVisit(
                doctor: widget.doctor,
                selectedDate: _selectedDate,
              )
            ]),
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
                    MaterialStatePropertyAll(Colors.redAccent.shade700),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (ctx) => BookedDateTime(doctor: doctor)));
              },
              icon: const Icon(FontAwesomeIcons.moneyBill1),
              label: const Text("Pay and Book Appointment")),
        ),
      ],
    );
  }
}
