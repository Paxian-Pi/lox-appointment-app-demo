import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lox_mobile/list_data.dart';
import 'package:lox_mobile/list_data.dart';
import 'package:lox_mobile/list_data.dart';
import 'package:lox_mobile/list_data.dart';
import 'package:lox_mobile/list_data.dart';
import 'package:page_transition/page_transition.dart';
import 'package:table_calendar/table_calendar.dart';

class ViewAppointments extends StatefulWidget {
  const ViewAppointments({Key? key}) : super(key: key);

  @override
  _ViewAppointmentsState createState() => _ViewAppointmentsState();
}

class _ViewAppointmentsState extends State<ViewAppointments> {

  DateTime? _selectedDay;
  DateTime? _focusedDay = DateTime.now();

  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Column(
                children: [
                  _appBar(),
                  _dateCard(),
                  const SizedBox(height: 10),
                  _calendar(),
                  _appointmentList()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 50),
      width: size.width,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                HapticFeedback.vibrate();
                SystemSound.play(SystemSoundType.click);

                Navigator.pop(context);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.blue.shade300,
                    size: 25.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat('MMMM dd, yyyy').format(DateTime.now()), style: const TextStyle(fontSize: 12)),
                      const Text('Today', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).pushReplacement(
                  //   PageTransition(
                  //     child: const BottomNav(),
                  //     type: PageTransitionType.fade,
                  //   ),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black,
                  shadowColor: Colors.grey,
                  elevation: 3,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade300, Colors.blue.shade300],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 40,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 25.0,
                        ),
                        Text(
                          'Add',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _calendar() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 3,
        child: TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime.now(),
          calendarBuilders: CalendarBuilders(
            dowBuilder: (context, day) {
              if (day.weekday == DateTime.sunday) {
                final text = DateFormat.E().format(day);

                return Center(
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.green.shade300),
                  ),
                );
              }
              return null;
            },
          ),
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              if (kDebugMode) print(DateFormat('EEEE dd MMMM, yyyy').format(_focusedDay!));
            });
          },
        ),
      ),
    );
  }

  Widget _appointmentList() {

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 15, bottom: 18, top: 10),
              child: Text("Appointments", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0)),
            )
          ],
        ),
        ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: appointmentData.length,
          // itemCount: 4,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 15);
          },
          itemBuilder: (BuildContext context, int index) {

            return ListTile(
              onTap: () {},
              leading: appointmentData[index].iconPath1,
              title: Text(appointmentData[index].name),
              subtitle: Text(appointmentData[index].time),
              trailing: Checkbox(
                value: appointmentData[index].value,
                checkColor: Colors.black54,
                activeColor: Colors.grey.shade200,
                onChanged: (value) {
                  setState(() {
                    appointmentData[index].value = value!;
                  });
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _saveLoginDetails() {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
      child: Row(
        children: [
          Theme(
            data: ThemeData(
              unselectedWidgetColor: Colors.grey,
            ),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.grey,
              activeColor: Colors.grey,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          // Text(
          //   rememberMe,
          //   style: const TextStyle(
          //     color: Constant.darkGrey,
          //     fontSize: Constant.fontSizeSmaller,
          //   ),
          // ),
        ],
      ),
    );
  }
}
