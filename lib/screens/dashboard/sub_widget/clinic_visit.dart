import 'package:easy_patient/classes/doctors/doctor_master.dart';
import 'package:easy_patient/classes/doctors/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../classes/doctors/doctor_chamber_model.dart';
import '../../../classes/master/administrator.dart';

class ClinicVisit extends StatefulWidget {
  final Doctor doctor;
  final DateTime selectedDate;
  const ClinicVisit(
      {Key? key, required this.doctor, required this.selectedDate})
      : super(key: key);

  @override
  State<ClinicVisit> createState() => _ClinicVisitState();
}

class _ClinicVisitState extends State<ClinicVisit> {
  var doctorMaster;
  List<DoctorChamberModel> doctorChambers = [];
  List times = [];
  late List timeSlot;
  int selectedIndex = 0;
  bool hasSlot = false;
  int selectedDateIndex = 0;

  @override
  void initState() {
    super.initState();
    print("joy");
    doctorMaster = Provider.of<DoctorMaster>(context, listen: false);

    doctorChambers = doctorMaster.getDoctorChambars(widget.doctor.doc_id);
    showSlotAvailable(doctorChambers[0]);
  }

  void showSlotAvailable(DoctorChamberModel doctorChamber) {
    print(widget.selectedDate.weekday);

    hasSlot = Provider.of<Administrator>(context, listen: false)
        .selectedDateAvailable(widget.selectedDate, doctorChamber);
    hasSlot
        ? times = Provider.of<Administrator>(context, listen: false)
            .getTimeSlots(doctorChamber.timing[0].from_time,
                doctorChamber.timing[0].to_time)
        : null;
    timeSlot = List.filled(times.length, false);
  }

  @override
  Widget build(BuildContext context) {
    showSlotAvailable(doctorChambers[0]);
    var textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        ...doctorChambers
            .map(
              (e) => Card(
                child: ListTile(
                  onTap: () {},
                  title: Text(
                    e.chamber_name,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  trailing: Text(
                    "\u{20B9} ${e.fee}",
                    style: GoogleFonts.atma(color: Colors.red.shade900),
                  ),
                  subtitle: Wrap(
                    children: [],
                  ),
                ),
              ),
            )
            .toList(),

        /// TODO: 8:30 to 12:30 12 slot available
        Row(
          children: const [Text("")],
        ),
        hasSlot
            ? Wrap(
                spacing: 8.0,
                children: List<Widget>.generate(
                  times.length,
                  (int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Card(
                        color: selectedIndex != index
                            ? Colors.green.shade50
                            : Colors.green.shade900,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${times[index]}",
                            style: textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: selectedIndex == index
                                    ? Colors.white
                                    : Colors.brown),
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              )
            : const SizedBox(
                child: Text("No Slot Available"),
              ),
      ],
    );
  }
}
