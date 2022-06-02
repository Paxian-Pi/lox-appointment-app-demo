import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lox_mobile/profile.dart';
import 'package:lox_mobile/list_data.dart';
import 'package:page_transition/page_transition.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      // body: Center(
      //   child: Container(
      //     padding: const EdgeInsets.all(14.0),
      //     child: _loading
      //         // ? Column(
      //         //     mainAxisAlignment: MainAxisAlignment.center,
      //         //     children: <Widget>[
      //         //       SizedBox(
      //         //         width: size.width * 0.3,
      //         //         height: size.height * 0.15,
      //         //         child: CircularProgressIndicator(
      //         //           strokeWidth: 20,
      //         //           backgroundColor: Constant.accent,
      //         //           valueColor: const AlwaysStoppedAnimation<Color>(
      //         //               Constant.darkGrey),
      //         //           value: _progressValue,
      //         //         ),
      //         //       ),
      //         //       const SizedBox(height: 20),
      //         //       Text(
      //         //         '${(_progressValue * 100).round()}%',
      //         //       ),
      //         //     ],
      //         //   )
      //         ? Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               GestureDetector(
      //                 onTap: () {},
      //                 child: Column(
      //                   children: [
      //                     Column(
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       children: <Widget>[
      //                         SizedBox(
      //                           width: size.width * 0.3,
      //                           height: size.height * 0.15,
      //                           child: SizedBox(
      //                             height: size.height,
      //                             child: Stack(
      //                               alignment: Alignment.center,
      //                               children: [
      //                                 SizedBox(
      //                                   width: size.width,
      //                                   height: size.height,
      //                                   child: CircularProgressIndicator(
      //                                     strokeWidth: 20,
      //                                     backgroundColor: Constant.darkGrey,
      //                                     valueColor: const AlwaysStoppedAnimation<Color>(Constant.accent),
      //                                     value: _progressValue,
      //                                   ),
      //                                 ),
      //                                 Positioned(
      //                                   child: Text(
      //                                     '${(_progressValue * 100).round()}%',
      //                                     style: const TextStyle(fontSize: Constant.fontSizeMidLower),
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           )
      //         : Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               GestureDetector(
      //                 onTap: () {},
      //                 child: Column(
      //                   children: [
      //                     Column(
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       children: <Widget>[
      //                         SizedBox(
      //                           width: size.width * 0.3,
      //                           height: size.height * 0.15,
      //                           child: SizedBox(
      //                             height: size.height,
      //                             child: Stack(
      //                               alignment: Alignment.center,
      //                               children: [
      //                                 SizedBox(
      //                                   width: size.width,
      //                                   height: size.height,
      //                                   child: CircularProgressIndicator(
      //                                     strokeWidth: 20,
      //                                     backgroundColor: Constant.darkGrey,
      //                                     valueColor:
      //                                         const AlwaysStoppedAnimation<
      //                                             Color>(Constant.accent),
      //                                     value: _progressValue,
      //                                   ),
      //                                 ),
      //                                 Positioned(
      //                                   child: Text(
      //                                     '${(_progressValue * 100).round()}%',
      //                                     style: const TextStyle(
      //                                         fontSize:
      //                                             Constant.fontSizeMidLower),
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //   ),
      // ),

      // body: Card(
      //   elevation: 50,
      //   shadowColor: Colors.black,
      //   color: Colors.greenAccent[100],
      //   child: SizedBox(
      //     width: 300,
      //     height: 500,
      //     child: Padding(
      //       padding: const EdgeInsets.all(20.0),
      //       child: Column(
      //         children: [
      //           CircleAvatar(
      //             backgroundColor: Colors.green[500],
      //             radius: 105,
      //             child: const CircleAvatar(
      //               backgroundImage: NetworkImage('https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'),
      //               radius: 100,
      //             ),
      //           ),
      //           const SizedBox(height: 10), //SizedBox
      //           Text(
      //             'GeeksforGeeks',
      //             style: TextStyle(
      //               fontSize: 30,
      //               color: Colors.green[900],
      //               fontWeight: FontWeight.w500,
      //             ), //Textstyle
      //           ), //Text
      //           const SizedBox(height: 10), //SizedBox
      //           const Text(
      //             'GeeksforGeeks is a computer science portal',
      //             style: TextStyle(
      //               fontSize: 15,
      //               color: Colors.green,
      //             ), //Textstyle
      //           ), //Text
      //           const SizedBox(
      //             height: 10,
      //           ), //SizedBox
      //           SizedBox(
      //             width: 80,
      //             child: RaisedButton(
      //               onPressed: () {},
      //               color: Colors.green,
      //               child: Padding(
      //                 padding: const EdgeInsets.all(4.0),
      //                 child: Row(
      //                   children: const [
      //                     Icon(Icons.touch_app),
      //                     Text('Visit'),
      //                   ],
      //                 ), //Row
      //               ), //Padding
      //             ), //RaisedButton
      //           ) //SizedBox
      //         ],
      //       ), //Column
      //     ), //Padding
      //   ), //SizedBox
      // ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Column(
                children: [
                  _homeImage(),
                  _profileList()
                ],
              ),
            ],
          ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              HapticFeedback.vibrate();
              SystemSound.play(SystemSoundType.click);

              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
              size: 28.0,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 100, right: 100),
            width: 100,
            height: 50,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/email.png"),
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Image.asset('assets/email.png')
        ],
      ),
    );
  }

  Widget _homeImage() {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: size.width,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      child: Image.asset('assets/profile_list_image.png'),
    );
  }

  Widget _profileList() {

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 15, bottom: 18, top: 10),
              child: Text("Hire A Nurse", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0)),
            )
          ],
        ),
        ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: profileListData.length,
          // itemCount: 4,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 15);
          },
          itemBuilder: (BuildContext context, int index) {

            return ListTile(
              onTap: () {
                Navigator.of(context).push(
                  PageTransition(
                    child: Profile(profileListData: profileListData[index]),
                    type: PageTransitionType.fade,
                  ),
                );
              },
              leading: profileListData[index].iconPath,
              title: Text(profileListData[index].name),
              subtitle: Text(profileListData[index].location),
              trailing: Text('NGN ${(profileListData[index].charge).toString()}', style: const TextStyle(color: Colors.red)),
            );
          },
        ),
      ],
    );
  }
}
