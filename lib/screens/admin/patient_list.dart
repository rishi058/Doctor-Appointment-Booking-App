import 'package:clinic_app/shared/loading.dart';
import 'package:clinic_app/models/patient_model.dart';
import 'package:clinic_app/screens/admin/patient_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../shared/colors.dart';
import '../../shared/typography.dart';

class PatientList extends StatefulWidget {
  const PatientList({Key? key}) : super(key: key);

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  bool isLoading = false;
  List<PatientModel> patientList = [];

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    patientList = Provider.of<List<PatientModel>>(context);
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: patientList.isEmpty
          ? Colors.white
          : Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 2,
        title: Text(
          'Patient List',
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
          : patientList.isEmpty
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('assets/void.png'))
                    // patientTile('RAvi', '+91', "UP", "90"),
                  ],
                )
              : ListView.builder(
                  itemCount: patientList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                PatientDetail(patient: patientList[index])));
                      },
                      child: patientTile(
                          patientList[index].patientName,
                          patientList[index].patientPhone,
                          patientList[index].patientAddress,
                          patientList[index].patientProfilePic),
                    );
                  }),
    );
  }
}

Widget patientTile(String name, String no, String address, String photoUrl) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.all(10.w),
    padding: EdgeInsets.all(10.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.white,
    ),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                image: photoUrl == ''
                    ? const DecorationImage(
                        image: AssetImage('assets/profile.png'))
                    : DecorationImage(image: NetworkImage(photoUrl)),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 1, color: buttonColor),
              ),
              width: 60.w,
              height: 60.w,
            ),
            SizedBox(width: 10.w),
            Expanded(
              // height: 80.w,
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              child: Icon(
                Icons.arrow_forward_ios_sharp,
                color: Colors.black26,
              ),
            )
          ],
        ),
      ],
    ),
  );
}
