import 'package:flutter/material.dart';

class ProfileListData {
  final Icon iconPath;
  final String name;
  final String location;
  final int charge;

  ProfileListData(this.iconPath, this.name, this.location, this.charge);
}

final List<ProfileListData> profileListData = [
  ProfileListData(
      const Icon(Icons.person, color: Colors.black26, size: 50),
      'John Smith',
      'Ikeja, Lagos',
      50000,
  ),

  ProfileListData(
      const Icon(Icons.person, color: Colors.black26, size: 50),
      'Wendy Morr',
      'Ikoyi, Lagos',
      10000,
  ),

  ProfileListData(
      const Icon(Icons.person, color: Colors.black26, size: 50),
      'Sussex Wind',
      'Lekki, Lagos',
      20000,
  ),

  ProfileListData(
      const Icon(Icons.person, color: Colors.black26, size: 50),
      'Paxian Pax',
      'Maryland, Lagos',
      80000,
  ),

  ProfileListData(
      const Icon(Icons.person, color: Colors.black26, size: 50),
      'Wincesslas Steve',
      'Lagos, Nigeria',
      100000,
  ),
];

class AppointmentData {
  final Icon iconPath1;
  final String name;
  final String time;
  late bool value = false;

  AppointmentData(this.iconPath1, this.name, this.time, this.value);
}

final List<AppointmentData> appointmentData = [
  AppointmentData(
      const Icon(Icons.circle_notifications, color: Colors.black26, size: 40),
      'John Smith',
      '09:00',
      true,
  ),

  AppointmentData(
      const Icon(Icons.circle_notifications, color: Colors.black26, size: 40),
      'Wendy Morr',
      '13:45',
      true,
  ),

  AppointmentData(
      const Icon(Icons.circle_notifications, color: Colors.black26, size: 40),
      'Sussex Wind',
      '10:00',
      false,
  ),
];
