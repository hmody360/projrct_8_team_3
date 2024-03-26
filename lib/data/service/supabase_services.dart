// import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:project_8_team3/data/model/medicattion_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DBService {
  // ------ Data Storage -----

  final box = GetStorage();
  String token = '';

  String id = '';

  String name = '';

  late int pill;
  late int days;
  late int counts;

  DBService() {
    getToken();
  }

  addToken() async {
    if (token.isNotEmpty) {
      await box.write("token", token);
    }
    box.save();
  }

  getToken() {
    if (box.hasData("token")) {
      if (token.isEmpty) {
        token = box.read("token");
      }
    }
  }

  final supabase = Supabase.instance.client;

//--- SignUp func
  Future SignUp(
      {required String email,
      required String password,
      required String userName}) async {
    print(" before: ");
    final respons = await supabase.auth.signUp(
      data: {'Name': userName},
      email: email,
      password: password,
    );
    print("in the signup: ${respons.hashCode}");
    // Send email verification
    // await supabase.auth.resetPasswordForEmail(email);
  }

  Future SignIn({required String email, required String password}) async {
    await supabase.auth.signInWithPassword(email: email, password: password);
    token = supabase.auth.currentSession!.accessToken;
    id = supabase.auth.currentSession!.user.id;
    addToken();
  }

  //Future SignOut
  Future SignOut() async {
    await supabase.auth.signOut();
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    final response = await supabase.auth.resetPasswordForEmail(email);
    return response;
  }

  // ------ Data Services -----

  // ------ User data Services -----

  // Get Current session info
  Future<Session?> getCurrentSession() async {
    final session = supabase.auth.currentSession;
    return session;
  }

  // Get Current User Id
  Future<String> getCurrentUser() async {
    final currentUser = supabase.auth.currentSession!.user.id;
    id = currentUser;
    return id;
  }

  // Get User Profile Data
  Future<Map<String, dynamic>> getUserProfilee() async {
    print("hi");
    final prifileData =
        await supabase.from('users').select().eq('id', id).single();
    print("in profile before $prifileData");
    name = prifileData["name"];
    print("in profile after $name");

    return prifileData;
  }

  Future getUserName() async {
    final response = await supabase
        .from('users')
        .select('name')
        .eq('id', supabase.auth.currentUser!.id);

    name = response.first['name'];
    print("in the name :------ $name");
    return name;
  }

  // ------ medication data Services -----

  // Get User Medications Data
  Future<List<MedicationModel>> getMedications() async {
    final medication =
        await supabase.from('medication').select('*').match({'userId': id});
    final List<MedicationModel> medications = [];
    for (var element in medication) {
      medications.add(MedicationModel.fromJson(element));
    }
    return medications;
  }

  ///-- add user name
  Future addUserName({
    required String name,
    required String id,
  }) async {
    await supabase.from('users').insert(
      {
        "name": name,
        "id": id,
      },
    );
  }

  // Add Medications to Data
  Future addMedications({
    required String name,
    required int pills,
    required int days,
    required String before,
    required String time,
  }) async {
    await supabase.from('medication').insert(
      {
        "medicationName": name,
        "pills": pills,
        "days": days,
        "userId": id,
        "before": before,
        "time": time,
        "isCompleted": false,
        "todayPills": false,
        "isUpdate": false,
        "updateTime": "",
        "UpdateTimeDate": "",
      },
    );
  }

  // Edit User Medications Data
  Future editMedications({
    required String name,
    required int pills,
    required int days,
    required String before,
    required MedicationModel medication,
    required String time,
  }) async {
    await supabase.from('medication').update(
      {
        "medicationName": name,
        "pills": pills,
        "days": days,
        "userId": id,
        "before": before,
        "time": time,
        "isCompleted": medication.isCompleted,
        "todayPills": medication.todayPills,
        "isUpdate": medication.isUpdate,
        "updateTime": medication.updateTime,
        "UpdateTimeDate": medication.updateTimeDate,
      },
    ).match({'medicationId': medication.medicationId});
  }

  // Edit User Medications Data
  Future editIsCompleted(
      {required MedicationModel medication, required bool isCompleted}) async {
    await supabase.from('medication').update(
      {
        "medicationName": medication.medicationName,
        "pills": medication.pills,
        "days": medication.days,
        "userId": medication.userId,
        "before": medication.before,
        "time": medication.time,
        "isCompleted": isCompleted,
        "todayPills": true,
        "isUpdate": false,
        "updateTime": medication.updateTime,
        "UpdateTimeDate": DateTime.now().toString(),
      },
    ).match({'medicationId': medication.medicationId});
  }

  Future editUpdate(
      {required MedicationModel medication,
      required bool isUpdate,
      required String updateTime,
      required String date}) async {
    await supabase.from('medication').update(
      {
        "medicationName": medication.medicationName,
        "pills": medication.pills,
        "days": medication.days,
        "userId": medication.userId,
        "before": medication.before,
        "time": medication.time,
        "isCompleted": medication.isCompleted,
        "todayPills": true,
        "isUpdate": isUpdate,
        "updateTime": updateTime,
        "UpdateTimeDate": date,
      },
    ).match({'medicationId': medication.medicationId});
  }

  Future editNotUpdate({
    required MedicationModel medication,
  }) async {
    await supabase.from('medication').update(
      {
        "medicationName": medication.medicationName,
        "pills": medication.pills,
        "days": medication.days,
        "userId": medication.userId,
        "before": medication.before,
        "time": medication.time,
        "isCompleted": medication.isCompleted,
        "todayPills": false,
        "isUpdate": medication.isUpdate,
        "updateTime": medication.updateTime,
        "UpdateTimeDate": medication.updateTimeDate,
      },
    ).match({'medicationId': medication.medicationId});
  }

  // Delete Medication
  Future deleteMedications({required midId}) async {
    await supabase.from('medication').delete().match({'medicationId': midId});
  }
}
