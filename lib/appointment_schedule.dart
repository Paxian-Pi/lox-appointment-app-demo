import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lox_mobile/success_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:animated_widgets/widgets/scale_animated.dart';

import 'list_data.dart';

class AppointmentSchedule extends StatefulWidget {

  final ProfileListData profileListData;

  const AppointmentSchedule({Key? key, required this.profileListData}) : super(key: key);

  @override
  _AppointmentScheduleState createState() => _AppointmentScheduleState();
}

class _AppointmentScheduleState extends State<AppointmentSchedule> {

  DateTime? _selectedDay;
  DateTime? _focusedDay = DateTime.now();

  String? _email;

  late SharedPreferences _pref;

  CheckoutResponse? _response;

  var publicKey = 'pk_test_49be27292bc7c5cc6f1959257d5e2a8056658510';
  final plugin = PaystackPlugin();

  @override
  void initState() {
    super.initState();
    plugin.initialize(publicKey: publicKey);
  }

  // PaymentCard _getCardFromUI() {
  //   // Using just the must-required parameters.
  //   return PaymentCard(
  //     number: cardNumber,
  //     cvc: cvv,
  //     expiryMonth: expiryMonth,
  //     expiryYear: expiryYear,
  //   );
  // }
  //
  // _chargeCard(String accessCode) async {
  //   var charge = Charge()
  //     ..accessCode = accessCode
  //     ..card = _getCardFromUI();
  //
  //   final response = await plugin.chargeCard(context, charge: charge);
  //   // Use the response
  // }

  void _showToast(String msg, ToastGravity toastGravity) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: toastGravity,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[600],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _paysStack() async {
    _pref = await SharedPreferences.getInstance();

    if(_pref.getString('email') != '') {
      _email = _pref.getString('email');
    }
    else {
      _showToast('You did NOT enter your email... Developer\'s email will be used!', ToastGravity.TOP);
      _email = 'paxian.pi@gmail.com';
    }

    int timestamp = DateTime.now().millisecondsSinceEpoch;

    Charge charge = Charge()
      ..amount = widget.profileListData.charge * 100
      ..reference = timestamp.toString()
      // or ..accessCode = _getAccessCodeFrmInitialization()
      ..email = _email;
      _response = await plugin.checkout(
        context,
        method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
        charge: charge,
    ).then((value) {

        Timer(const Duration(milliseconds: 1000), () {

          Navigator.of(context).push(
            PageTransition(
              child: const SuccessScreen(),
              type: PageTransitionType.fade,
            ),
          );
        });
      });
  }

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
              const SizedBox(height: 80),
              Column(
                children: [
                  _dateCard(),
                  const SizedBox(height: 10),
                  _calendar(),
                  const SizedBox(height: 10),
                  _reminderText(),
                  _reminder(),
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
            const Text('Profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            Icon(
              Icons.email,
              color: Colors.blue.shade300,
              size: 28,
            )
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

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _focusedDay = focusedDay;
        _selectedDay = selectedDay;
      });
    }
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

  Widget _reminderText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Reminder',  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          const Text('Don\'t forget schedule for upcoming appointment',  style: TextStyle(fontSize: 14)),
          TextButton(
            onPressed: () {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(2018, 3, 5),
                  maxTime: DateTime(2025, 6, 7),
                  onChanged: (date) {
                    print('change $date');
                  },
                  onConfirm: (date) {
                    print('confirm $date');
                  },
                  currentTime: DateTime.now(), locale: LocaleType.en);
            },
            child: const Text(
              'Schedule Now',
              style: TextStyle(color: Colors.blue),
            ),
          )
        ],
      ),
    );
  }

  Widget _reminder() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Sussex Wind',  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                      const Text('Nurse', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/star.png'),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Rating', style: TextStyle(fontSize: 11)),
                              Text('4.78 out of 5',  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Image.asset('assets/profile_image.png'),
                ],
              ),
              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 5),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100.withOpacity(0.7),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.black,
                      size: 20.0,
                    ),
                    const SizedBox(width: 10),
                    Text(DateFormat('EEEE dd MMMM, yyyy').format(_focusedDay!)),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 5),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {

                      _paysStack();
                      // _bottomDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.black,
                      shadowColor: Colors.grey,
                      elevation: 3,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
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
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text(
                          'Schedule',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.blue.shade300,
                      shadowColor: Colors.grey,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(color: Colors.blue.shade300)
                      ),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.white, Colors.white],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _dialogButton(bool isAccountDialog) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            HapticFeedback.vibrate();
            SystemSound.play(SystemSoundType.click);

            Navigator.of(context).pop();
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFE2E5FF),
                width: 1,
              ),
              // boxShadow: const [
              //   BoxShadow(
              //     color: Constant.accent,
              //     blurRadius: 10,
              //     offset: Offset(1, 1),
              //   ),
              // ],
              color: const Color(0xFFE2E5FF),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Okay',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      decoration: TextDecoration.none),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // void _createBankAccountDialog(BuildContext context) {
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (context) => ScaleAnimatedWidget.tween(
  //       enabled: true,
  //       duration: const Duration(milliseconds: 200),
  //       scaleDisabled: 0.5,
  //       scaleEnabled: 1,
  //       child: Container(
  //         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 200),
  //         decoration: const BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(20),
  //             topRight: Radius.circular(20),
  //             bottomRight: Radius.circular(20),
  //             bottomLeft: Radius.circular(20),
  //           ),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(10.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               const SizedBox(height: 20),
  //               Text(
  //                 !_isBankAccountCreated
  //                     ? 'Create Your Bank Account'
  //                     : 'Account already created',
  //                 textAlign: TextAlign.center,
  //                 style: const TextStyle(
  //                     color: Colors.black,
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold,
  //                     decoration: TextDecoration.none),
  //               ),
  //               const SizedBox(height: 30),
  //               Material(
  //                 child: Column(
  //                   children: [
  //                     Neumorphic(
  //                       style: const NeumorphicStyle(
  //                         depth: 2,
  //                         color: bgColor,
  //                         intensity: 2 * 2,
  //                         shape: NeumorphicShape.flat,
  //                       ),
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: TextFormField(
  //                           controller: _accountNumberController,
  //                           keyboardType: TextInputType.number,
  //                           decoration: const InputDecoration(
  //                               border: InputBorder.none,
  //                               hintText: 'Your phone/no will be your acc/no'),
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(height: 20),
  //                     Neumorphic(
  //                       style: const NeumorphicStyle(
  //                         depth: 2,
  //                         color: bgColor,
  //                         intensity: 2 * 2,
  //                         shape: NeumorphicShape.flat,
  //                       ),
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: TextFormField(
  //                           controller: _transactionPINinController,
  //                           keyboardType: TextInputType.number,
  //                           decoration: const InputDecoration(
  //                               border: InputBorder.none,
  //                               hintText: 'Enter your transaction PIN'),
  //                         ),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //               const SizedBox(height: 40),
  //               _dialogButton(true),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _bottomDialog() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 450),
      curve: Curves.fastOutSlowIn,
      height: 150,
      child: Column(
        children: [
          const SizedBox(height: 15.0),

          const SizedBox(height: 20.0),

          // Enter amount
          Hero(
            tag: 'dialog',
            child: Neumorphic(
              style: NeumorphicStyle(
                depth: 2,
                color: Colors.grey.shade200,
                intensity: 2 * 2,
                shape: NeumorphicShape.flat,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  // controller: _depositAmountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Amount'),
                ),
              ),
            ),
            // child: CardUI(
            //   card: cardData[index],
            // ),
          )
        ],
      )
    );
  }

  Widget _scheduleButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Column(
              children: const [
                Text('Reminder',  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                Text('Don\'t forget schedule for upcoming appointment',  style: TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                      borderRadius: BorderRadius.circular(20),
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
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text(
                        'Follow',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
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
                    onPrimary: Colors.blue.shade300,
                    shadowColor: Colors.grey,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Colors.blue.shade300)
                    ),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.grey.shade200, Colors.grey.shade200],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text(
                        'Message',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }




  Widget _profileFeedback() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: _feedbackWidget(),
        ),
      ),
    );
  }

  Widget _feedbackWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('assets/star.png'),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Rating', style: TextStyle(fontSize: 14)),
                    Text('4.78 out of 5', style: TextStyle(fontWeight: FontWeight.w500),)
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
                  height: 50,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'See all',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        const Divider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.person, color: Colors.black26, size: 35),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Anonymous feedback', style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(height: 10),
                Text('Very competent specialist. I am very happy\nthat there are such professional doctors.\nMy baby is in safe hands.\nMy child\'s health is above all'),

              ],
            )
          ],
        ),
        const SizedBox(height: 5),
        const Divider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Icon(Icons.person, color: Colors.black26, size: 35),
            Image.asset('assets/feedback_image.png', width: 35, height: 35),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Erika Lhee', style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(height: 10),
                Text('Just a wonderful doctor, very happy\nthat she is leading our child,\ncompetent, very smart, nice.'),

              ],
            )
          ],
        ),
      ],
    );
  }

  // Widget _makeAppointmentButton() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 15, right: 15),
  //     child: Card(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(15.0),
  //       ),
  //       elevation: 3,
  //       child: Padding(
  //         padding: const EdgeInsets.all(10.0),
  //         child: ElevatedButton(
  //           onPressed: () {
  //             Navigator.of(context).push(
  //               PageTransition(
  //                 child: const AppointmentSchedule(),
  //                 type: PageTransitionType.fade,
  //               ),
  //             );
  //           },
  //           style: ElevatedButton.styleFrom(
  //             onPrimary: Colors.black,
  //             shadowColor: Colors.grey,
  //             elevation: 3,
  //             padding: EdgeInsets.zero,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(20),
  //             ),
  //           ),
  //           child: Ink(
  //             decoration: BoxDecoration(
  //               gradient: LinearGradient(
  //                 colors: [Colors.blue.shade300, Colors.blue.shade300],
  //               ),
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //             child: Container(
  //               width: MediaQuery.of(context).size.width,
  //               height: 50,
  //               alignment: Alignment.center,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: const [
  //                   Icon(Icons.timer_rounded, color: Colors.white, size: 25),
  //                   SizedBox(width: 10),
  //                   Text(
  //                     'Make An Appointment',
  //                     style: TextStyle(
  //                       fontSize: 18,
  //                       color: Colors.white,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
