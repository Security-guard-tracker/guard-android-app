import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgt/presentation/map_screen/map_screen.dart';
import 'package:sgt/presentation/work_report_screen/cubit/addImage/add_image_cubit.dart';
import '../../utils/const.dart';
import 'cubit/addpeople/addpeople_cubit.dart';
import 'cubit/addwitness/addwitness_cubit.dart';
import 'widget/edit_location.dart';
import 'widget/success_popup.dart';

class EmergencyReportScreen extends StatefulWidget {
  const EmergencyReportScreen({super.key});

  @override
  State<EmergencyReportScreen> createState() => _EmergencyReportScreenState();
}

class _EmergencyReportScreenState extends State<EmergencyReportScreen> {
  var value;

  final ImagePicker _picker = ImagePicker();
  List<XFile>? imageFileList = [];
  List imageNames = [];
  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(context.read<AddImageCubit>().state.imageList);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Emergency Report',
            style: TextStyle(color: primaryColor),
            textScaleFactor: 1.0,
          ),
          elevation: 0,
          backgroundColor: white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 26,
                    ),
                    Text(
                      'Title',
                      style: TextStyle(
                        fontSize: 17,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                      textScaleFactor: 1.0,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(top: 0, bottom: 0, left: 10),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: seconderyMediumColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: primaryColor)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: seconderyMediumColor)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: seconderyMediumColor)),
                        filled: true,
                        fillColor: seconderyMediumColor,
                        hintText: 'Something here',
                        hintStyle: TextStyle(color: Colors.grey),
                        focusColor: primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    Text(
                      'Emergency Date & Time',
                      style: TextStyle(
                        fontSize: 17,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                      textScaleFactor: 1.0,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Date',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textScaleFactor: 1.0,
                                ),
                                TextFormField(
                                  controller: dateinput,
                                  decoration: InputDecoration(
                                    hintText: '00/00/00',
                                    hintStyle: TextStyle(color: primaryColor),
                                    focusColor: primaryColor,
                                  ),
                                  readOnly:
                                      true, //set it true, so that user will not able to edit text
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(
                                            2000), //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2101));

                                    if (pickedDate != null) {
                                      print(
                                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      print(
                                          formattedDate); //formatted date output using intl package =>  2021-03-16
                                      //you can implement different kind of Date Format here according to your requirement

                                      setState(() {
                                        dateinput.text = formattedDate;
                                      });
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Time',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textScaleFactor: 1.0,
                                ),
                                TextFormField(
                                  controller: timeinput,
                                  decoration: InputDecoration(
                                    hintText: '00:00',
                                    hintStyle: TextStyle(color: primaryColor),
                                    focusColor: primaryColor,
                                  ),
                                  readOnly:
                                      true, //set it true, so that user will not able to edit text
                                  onTap: () async {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      initialTime: TimeOfDay.now(),
                                      context: context,
                                    );

                                    if (pickedTime != null) {
                                      print(pickedTime.format(context));
                                      DateTime parsedTime = DateFormat.jm()
                                          .parse(pickedTime
                                              .format(context)
                                              .toString());
                                      //converting to DateTime so that we can further format on different pattern.
                                      print(
                                          parsedTime); //output 1970-01-01 22:53:00.000
                                      String formattedTime =
                                          DateFormat('HH:mm:ss')
                                              .format(parsedTime);
                                      print(formattedTime); //output 14:59:00
                                      //DateFormat() is from intl package, you can format the time on any pattern you need.

                                      setState(() {
                                        timeinput.text =
                                            formattedTime; //set the value of text field.
                                      });
                                    } else {
                                      print("Time is not selected");
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Row(
                      children: [
                        Icon(Icons.my_location, color: primaryColor),
                        SizedBox(width: 5),
                        Text(
                          'Location',
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  fontSize: 15.sp,
                                  color: black,
                                  fontWeight: FontWeight.bold)),
                          textScaleFactor: 1.0,
                        ),
                        SizedBox(width: 135),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EditLocationScreen()));
                          },
                          child: Text(
                            'Edit Location',
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: 12.sp,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold)),
                            textScaleFactor: 1.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Container(height: 150, child: MapScreen()),
                    const SizedBox(
                      height: 10,
                    ),
                    // Row(
                    //   children: [
                    //     Icon(
                    //       Icons.location_on,
                    //       color: primaryColor,
                    //       size: 30,
                    //     ),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    // SizedBox(
                    //   width: 250,
                    //   child: Text(
                    //       'G??ntherstra??e 42A, 60528 Frankfurt am Main, Germany'),
                    // )
                    //   ],
                    // ),
                    const SizedBox(
                      height: 28,
                    ),
                    Text(
                      'Emergency Details',
                      style: TextStyle(
                          fontSize: 17,
                          color: primaryColor,
                          fontWeight: FontWeight.w500),
                      textScaleFactor: 1.0,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: seconderyColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: primaryColor)),
                        hintText: 'Something here',
                        hintStyle: TextStyle(color: Colors.grey),
                        focusColor: primaryColor,
                      ),
                    ),
                    // Text(
                    //   'Action Taken',
                    //   style: GoogleFonts.montserrat(
                    //       textStyle:
                    //           TextStyle(fontSize: 17.sp, color: Colors.grey)),
                    //   textScaleFactor: 1.0,
                    // ),
                    // const SizedBox(
                    //   height: 18,
                    // ),
                    // TextFormField(
                    //   maxLines: 8,
                    //   decoration: InputDecoration(
                    //       border: OutlineInputBorder(
                    //           borderSide: BorderSide(color: grey)),
                    //       hintText: 'Something here',
                    //       hintStyle: TextStyle(color: grey),
                    //       focusColor: primaryColor),
                    // ),
                    const SizedBox(
                      height: 28,
                    ),
                    Text(
                      'People Involved',
                      style: TextStyle(
                          fontSize: 17,
                          color: black,
                          fontWeight: FontWeight.w500),
                      textScaleFactor: 1.0,
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Container(
                      height: 170 *
                          context
                              .read<AddpeopleCubit>()
                              .state
                              .peopleNo
                              .toDouble(),
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              context.watch<AddpeopleCubit>().state.peopleNo,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  'Name',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500),
                                  textScaleFactor: 1.0,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Something here',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: seconderyColor)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: primaryColor)),
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      focusColor: primaryColor),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  'Phone Number',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500),
                                  textScaleFactor: 1.0,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Something here',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: seconderyColor)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: primaryColor)),
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      focusColor: primaryColor),
                                ),
                              ],
                            );
                          }),
                    ),

                    InkWell(
                      onTap: () {
                        context.read<AddpeopleCubit>().addPeople();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          'Add peoples +',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Witness',
                      style: TextStyle(
                          fontSize: 17,
                          color: black,
                          fontWeight: FontWeight.w500),
                      textScaleFactor: 1.0,
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Container(
                      height: 170 *
                          context
                              .read<AddwitnessCubit>()
                              .state
                              .witness
                              .toDouble(),
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              context.watch<AddwitnessCubit>().state.witness,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  'Name',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500),
                                  textScaleFactor: 1.0,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Something here',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: seconderyColor)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: primaryColor)),
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      focusColor: primaryColor),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  'Phone Number',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500),
                                  textScaleFactor: 1.0,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Something here',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: seconderyColor)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: primaryColor)),
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      focusColor: primaryColor),
                                ),
                              ],
                            );
                          }),
                    ),

                    InkWell(
                      onTap: () {
                        context.read<AddwitnessCubit>().addwitness();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          'Add peoples +',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    Text(
                      'Action Taker',
                      style: TextStyle(
                          fontSize: 17,
                          color: primaryColor,
                          fontWeight: FontWeight.w500),
                      textScaleFactor: 1.0,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: seconderyColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: primaryColor)),
                        hintText: 'Something here',
                        hintStyle: TextStyle(color: Colors.grey),
                        focusColor: primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Police Report#',
                      style: TextStyle(
                          fontSize: 17,
                          color: primaryColor,
                          fontWeight: FontWeight.w500),
                      textScaleFactor: 1.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Something here',
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: seconderyColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primaryColor)),
                          hintStyle: const TextStyle(color: Colors.grey),
                          focusColor: primaryColor),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Officer Name#',
                      style: TextStyle(
                          fontSize: 17,
                          color: primaryColor,
                          fontWeight: FontWeight.w500),
                      textScaleFactor: 1.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Something here',
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: seconderyColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primaryColor)),
                          hintStyle: const TextStyle(color: Colors.grey),
                          focusColor: primaryColor),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Officer#',
                      style: TextStyle(
                          fontSize: 17,
                          color: primaryColor,
                          fontWeight: FontWeight.w500),
                      textScaleFactor: 1.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Something here',
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: seconderyColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primaryColor)),
                          hintStyle: const TextStyle(color: Colors.grey),
                          focusColor: primaryColor),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Towed',
                      style: TextStyle(
                          fontSize: 17,
                          color: primaryColor,
                          fontWeight: FontWeight.w500),
                      textScaleFactor: 1.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: ['Yes', 'No'].map((String val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          }).toList(),
                          hint: Text(
                            'Select Yes or No',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          onChanged: (v) {},
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    imageFileList!.isNotEmpty
                        ? Text(
                            'Media',
                            style: TextStyle(fontSize: 17, color: primaryColor),
                          )
                        : Container(),
                    // context.watch<AddImageCubit>().state.imageList!.isNotEmpty
                    imageFileList!.isNotEmpty
                        ? SizedBox(
                            height: 110 * imageFileList!.length.toDouble(),
                            // height: 110 *
                            //     context
                            //         .watch<AddImageCubit>()
                            //         .state
                            //         .imageList!
                            //         .length
                            //         .toDouble(),
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: imageFileList!.length,
                                // itemCount: context
                                //     .read<AddImageCubit>()
                                //     .state
                                //     .imageList!
                                //     .length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 20),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.all(5),
                                            height: 60,
                                            width: 60,
                                            alignment: Alignment.center,
                                            child: Image.file(
                                              // File(context
                                              //       .read<AddImageCubit>()
                                              //       .state
                                              //       .imageList![index]
                                              //       .path)
                                              File(imageFileList![index].path),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  width: 190,
                                                  child: Text(imageNames[index],
                                                      style: TextStyle())),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 4,
                                                    width: 200,
                                                    decoration: BoxDecoration(
                                                        color: primaryColor),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Icon(
                                                    Icons.check_circle_outline,
                                                    color: greenColor,
                                                    size: 20,
                                                  ),
                                                  // Text('100 %',
                                                  //     style: TextStyle(
                                                  //         fontSize: 12)),
                                                  SizedBox(width: 5),
                                                  InkWell(
                                                    onTap: () {
                                                      print('remove');

                                                      setState(() {
                                                        imageFileList!
                                                            .removeAt(index);
                                                        // imageNames.removeAt(index);
                                                      });
                                                      print(index);
                                                      print(imageFileList);
                                                      // imageNames
                                                      //     .add(path.dirname(photo.path));
                                                    },
                                                    child: Container(
                                                        height: 15,
                                                        width: 15,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            border: Border.all(
                                                                color:
                                                                    primaryColor)),
                                                        child: Icon(Icons.close,
                                                            size: 12)),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ]),
                                  );
                                }),
                          )
                        : Container(),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      'Upload Record Sample',
                      style: TextStyle(fontSize: 17.sp, color: primaryColor),
                      textScaleFactor: 1.0,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 25),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Select Media From?',
                                      textScaleFactor: 1.0,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const Text(
                                      'Use camera or select file from device gallery',
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color.fromARGB(
                                              255, 109, 109, 109)),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            // Capture a photo
                                            final XFile? photo =
                                                await _picker.pickImage(
                                                    source: ImageSource.camera);
                                            if (photo != null) {
                                              imageFileList?.add(photo);

                                              imageNames.add(
                                                  path.dirname(photo.path));
                                              setState(() {});
                                            }
                                            print(
                                                '$imageFileList   $imageNames');
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  color: grey,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: const Icon(
                                                  Icons.camera_alt,
                                                  size: 30,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              const Text(
                                                'Camera',
                                                textScaleFactor: 1.0,
                                              )
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            // Pick multiple images
                                            final List<XFile>? images =
                                                await _picker.pickMultiImage();
                                            if (images != null) {
                                              for (var i = 0;
                                                  i < images.length;
                                                  i++) {
                                                imageFileList?.add(images[i]);
                                              }
                                              imageNames.add(images[0].name);
                                              setState(() {});
                                            }
                                            print(
                                                '$imageFileList   $imageNames');
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  color: white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 5,
                                                      blurRadius: 7,
                                                      offset: const Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: const Icon(
                                                  Icons.folder_open_outlined,
                                                  size: 30,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              const Text(
                                                'Gallery',
                                                textScaleFactor: 1.0,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        color: Colors.blue,
                        strokeWidth: 2,
                        dashPattern: [10, 3],
                        radius: Radius.circular(10),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                              child: Text(
                            'Choose a File',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                child: Center(
                  child: CupertinoButton(
                      disabledColor: seconderyColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 150, vertical: 15),
                      color: primaryColor,
                      child: const Text(
                        'Next',
                        style: TextStyle(fontSize: 20),
                        textScaleFactor: 1.0,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => SuccessPopup());
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return const ReportSuccessScreen(
                        //     isSubmitReportScreen: false,
                        //   );
                        // }));
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
