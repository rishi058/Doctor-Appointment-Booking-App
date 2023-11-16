// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clinic_app/models/staff_model.dart';
import 'package:clinic_app/services/database.dart';
import 'package:clinic_app/shared/loading.dart';
import 'package:clinic_app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../models/appointment_model.dart';
import '../../shared/colors.dart';
import '../../shared/typography.dart';

class DeleteStaff extends StatefulWidget {
  const DeleteStaff({Key? key}) : super(key: key);

  @override
  State<DeleteStaff> createState() => _DeleteStaffState();
}

class _DeleteStaffState extends State<DeleteStaff> {
  bool isLoading = false;
  List<StaffModel> allStaff = [];

  List<AppointmentModel> appointmentsList = [];

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    appointmentsList = Provider.of<List<AppointmentModel>>(context).toList()
        .where((element) => element.status == 'pending' || element.status == 'assigned')
        .toList();

    allStaff = Provider.of<List<StaffModel>>(context);

    isLoading = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: allStaff.isEmpty
            ? Colors.white
            : Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Delete a Staff',
            style: theme(sz: 20),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: primaryColor,
            ),
          ),
        ),
        body: isLoading
            ? const Loading()
            : allStaff.isEmpty
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('assets/void.png'))
                    ],
                  )
                : SingleChildScrollView(
                  child: Column(
          mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 40.h,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 3)
                            ]),
                        child: Container(
                          margin: EdgeInsets.only(top: 7.5.h, left: 10.w),
                          child: RichText(
                            text: TextSpan(
                                text: 'Note :- Complete all pending and assigned appointments before deleting a Staff.',
                                style: TextStyle(color: Colors.deepPurple, fontSize: 13.sp)
                            ),
                          ),
                        ),
                      ), //
                      ListView.builder(
                        shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: allStaff.length,
                          itemBuilder: (context, index) {
                            return staffTile(
                              allStaff[index].staffUid,
                              allStaff[index].staffName,
                              allStaff[index].staffProfPic,
                              allStaff[index].staffPhone,
                              allStaff[index].staffAddress,
                              context,
                            );
                          }),
                    ],
                  ),
                ));
  }
}

Widget staffTile(
    String uid,
    String name,
    String photoUrl,
    String no,
    String address,
    BuildContext context) {

  return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10.w),
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              image: photoUrl==''?const DecorationImage(image: AssetImage('assets/profile.png')) :
              DecorationImage(image: NetworkImage(photoUrl)),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 1, color: buttonColor),
            ),
            width: 60.w,
            height: 60.w,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Name : ',
                      style: theme(sz: 13, clr: Colors.blueGrey),
                    ),
                    Text(
                      name,
                      style: theme(sz: 13, clr: Colors.blueGrey),
                    ),
                  ],
                ),
                SizedBox(height: 5.w),
                Row(
                  children: [
                    Text(
                      'Phone No. : ',
                      style: theme(sz: 13, clr: Colors.blueGrey),
                    ),
                    Text(
                      no,
                      style: theme(sz: 13, clr: Colors.blueGrey),
                    ),
                  ],
                ),
                SizedBox(height: 5.w),
                Row(
                  children: [
                    Text(
                      'Address : ',
                      style: theme(sz: 13, clr: Colors.blueGrey),
                    ),
                    Text(
                      address,
                      style: theme(sz: 13, clr: Colors.blueGrey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
            onPressed: () {
              AwesomeDialog(
                      dialogType: DialogType.warning,
                      borderSide: BorderSide(color: primaryColor, width: 2),
                      dismissOnTouchOutside: true,
                      dismissOnBackKeyPress: false,
                      animType: AnimType.leftSlide,
                      title: 'Delete Staff',
                      desc: 'Are you sure you want to delete this staff?',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () async {
                        bool isSuccess = await Database().deleteStaff(
                          uid,
                          context,
                        );
                        if (isSuccess) {
                          Shared()
                              .snackbar(context, 'Staff Deleted Successfully');
                        }
                      },
                      btnCancelColor: Colors.grey,
                      btnOkColor: primaryColor,
                      context: context)
                  .show();
            },
          )
        ],
      ));
}
