// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:clinic_app/shared/loading.dart';
import 'package:clinic_app/shared/typography.dart';
import 'package:clinic_app/models/patient_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../shared/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../services/database.dart';
import '../../shared/shared.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  File? _pickedImage;
  String url = '';
  late PatientModel patient;
  bool isLoading = false;
  bool button = false;

  @override
  void initState() {
    isLoading = true;
    setData();
    super.initState();
  }

  void setData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await Database().getUser(uid).then((value) {
      if(value!=null){
        setState(() {
          patient = value;
          nameController.text = patient.patientName;
          phoneController.text = patient.patientPhone;
          ageController.text = patient.patientAge;
          addressController.text = patient.patientAddress;
          isLoading = false;
        });
      }
    });
  }

  void chooseImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxWidth: 300,
    );
    if(pickedImage!=null){
      final pickedImageFile = File(pickedImage.path);
      setState(() {
        _pickedImage = pickedImageFile;
      });
    }
  }

  Future<bool?> uploadTask() async {
      String uid = patient.patientUid;

      try{
        final ref =
        FirebaseStorage.instance.ref().child('patient').child('$uid.jpg');

        await ref.putFile(_pickedImage!).whenComplete(() async {
          await ref.getDownloadURL().then((value){
            setState(() {
              url = value;
            });
          });
        });
        return true;
      }
      on PlatformException{
        return false;
      }
      catch (e){
        return false;
      }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: Loading(),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: primaryColor,
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                'Update Profile',
                style: theme(sz: 18),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(15.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Container(
                            width: 130.h,
                            height: 130.h,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.7, color: buttonColor),
                              shape: BoxShape.circle,
                              image: patient.patientProfilePic == '' && _pickedImage == null
                                  ? const DecorationImage(
                                      image: AssetImage(
                                        'assets/profile.png',
                                      ),
                                      fit: BoxFit.cover)
                                  : _pickedImage == null
                                      ? DecorationImage(
                                          image: NetworkImage(
                                            patient.patientProfilePic,
                                          ),
                                        )
                                      : DecorationImage(
                                          image: FileImage(
                                            _pickedImage!,
                                          ),
                                        ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          InkWell(
                            onTap: () {
                              chooseImage();
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5.h, horizontal: 3.w),
                              child: Text(
                                'Change Profile',
                                style: theme(sz: 13),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
                      child: Text(
                        'Name ',
                        style: theme(sz: 13),
                      ),
                    ),
                    Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.w, horizontal: 7.w),
                        child: TextField(
                          decoration: const InputDecoration(
                              hintText: 'Name', border: InputBorder.none),
                          controller: nameController,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
                      child: Text(
                        'Contact No.  ',
                        style: theme(sz: 13),
                      ),
                    ),
                    Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.w, horizontal: 7.w),
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              hintText: 'Contact No.',
                              border: InputBorder.none),
                          controller: phoneController,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
                      child: Text(
                        'Age ',
                        style: theme(sz: 13),
                      ),
                    ),
                    Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.w, horizontal: 7.w),
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              hintText: 'Age ', border: InputBorder.none),
                          controller: ageController,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
                      child: Text(
                        'Address ',
                        style: theme(sz: 13),
                      ),
                    ),
                    Container(
                      height: 70.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.w, horizontal: 7.w),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                              hintText: 'Address', border: InputBorder.none),
                          controller: addressController,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: button ? Container(
              height: 45.h,
              margin: EdgeInsets.symmetric(vertical: 3.h),
              width: double.infinity,
              child: const Center(child: Loading()),
            ) :
            GestureDetector(
              onTap: () async {
                setState(() {
                  button = true;
                });
                if(_pickedImage!=null) {
                  await uploadTask().then((value){
                    if(value==true){
                      Database().updatePatientProfile(
                          patient.patientUid,
                          url,
                          nameController.text,
                          phoneController.text,
                          addressController.text,
                          ageController.text,
                          context).whenComplete(() {
                            setState(() {
                              button = false;
                            });
                      });
                    }
                    else{
                      Shared().snackbar(context, 'Server Error, Try Again !');
                      setState(() {
                        button = false;
                      });
                    }
                  });
                }
                else{
                  Database().updatePatientProfile(
                      patient.patientUid,
                      patient.patientProfilePic,
                      nameController.text,
                      phoneController.text,
                      addressController.text,
                      ageController.text,
                      context).whenComplete(() {
                        setState(() {
                          button = false;
                        });
                  });
                }

              },
              child: Container(
                height: 35.h,
                margin: EdgeInsets.only(right: 13.w, left: 13.w, bottom: 13.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.w),
                  color: buttonColor,
                ),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Save Changes',
                      style: theme(sz: 15, clr: Colors.white, sp: 2),
                    )),
              ),
            ),
          );
  }
}
