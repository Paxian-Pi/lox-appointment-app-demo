import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import 'appointment_schedule.dart';
import 'list_data.dart';

class Profile extends StatefulWidget {

  final ProfileListData profileListData;

  const Profile({Key? key, required this.profileListData}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey.shade200,
      body: Container(
        width: size.width,
        height: size.height,
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/genmote_main.png"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: Column(
          children: [
            _appBar(),
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  _profileImageCard(),
                  const SizedBox(height: 20),
                  _profileStatisticsCard(),
                  _profileFeedback(),
                  const SizedBox(height: 20),
                  _makeAppointmentButton()
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       _loading = !_loading;
      //       _updateProgress();
      //     });
      //   },
      //   child: const Icon(Icons.cloud_download),
      // ),
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

  Widget _profileImageCard() {
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
            children: [
              Image.asset('assets/profile_image.png'),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.profileListData.name,  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  const Text('Nurse', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.people,
                        color: Colors.blue.shade300,
                        size: 35,
                      ),
                      Column(
                        children: const [
                          Text('Parent', style: TextStyle(fontSize: 11)),
                          Text('345+',  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                        ],
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileStatisticsCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: const [
                    Text('275',  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                    Text('Articles',  style: TextStyle(fontSize: 18)),
                  ],
                ),Column(
                  children: const [
                    Text('234',  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                    Text('Following',  style: TextStyle(fontSize: 18)),
                  ],
                ),Column(
                  children: const [
                    Text('123',  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                    Text('Followers',  style: TextStyle(fontSize: 18)),
                  ],
                ),
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

  Widget _makeAppointmentButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                PageTransition(
                  child: AppointmentSchedule(profileListData: widget.profileListData),
                  type: PageTransitionType.fade,
                ),
              );
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
                width: MediaQuery.of(context).size.width,
                height: 50,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.timer_rounded, color: Colors.white, size: 25),
                    SizedBox(width: 10),
                    Text(
                      'Make An Appointment',
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
        ),
      ),
    );
  }
}
