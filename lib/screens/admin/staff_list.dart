import 'package:clinic_app/models/staff_model.dart';
import 'package:clinic_app/screens/admin/staff_detail.dart';
import 'package:clinic_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../shared/colors.dart';
import '../../shared/typography.dart';

class StaffList extends StatefulWidget {
  const StaffList({Key? key}) : super(key: key);

  @override
  State<StaffList> createState() => _StaffListState();
}

class _StaffListState extends State<StaffList> {
  bool isLoading = false;
  List<StaffModel> staffList = [];

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    staffList = Provider.of<List<StaffModel>>(context);
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
        backgroundColor: staffList.isEmpty
            ? Colors.white
            : Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 2,
          title: Text(
            'Staff List',
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
            : staffList.isEmpty
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('assets/void.png'))
                    ],
                  )
                : ListView.builder(
                    itemCount: staffList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  StaffDetail(staff: staffList[index])));
                        },
                        child: staffTile(
                          staffList[index].staffName,
                          staffList[index].staffProfPic,
                          staffList[index].staffPhone,
                          staffList[index].email,
                          staffList[index].staffRating,
                        ),
                      );
                    }));
  }
}

Widget staffTile(
    String name, String photoUrl, String no, String email, String rating) {
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
                      'email : ',
                      style: theme(sz: 13, clr: Colors.blueGrey),
                    ),
                    Text(
                      email,
                      style: theme(sz: 13, clr: Colors.blueGrey),
                    ),
                  ],
                ),
                SizedBox(height: 5.w),
                Row(
                  children: [
                    Text(
                      'Rating : ',
                      style: theme(sz: 13, clr: Colors.blueGrey),
                    ),
                    Text(
                      '$rating⭐',
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
      ));
}
