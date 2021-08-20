import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:highview/patient/doctor_list.dart';

class DoctorTypeList extends StatefulWidget {
  const DoctorTypeList({Key key}) : super(key: key);

  @override
  _DoctorTypeListState createState() => _DoctorTypeListState();
}

class _DoctorTypeListState extends State<DoctorTypeList> {
  @override
  Widget build(BuildContext context) {
    int columnCount = 2;
    List<String> typesOfDoctors = [
      'General practitioner',
      'Gynaecologist',
      'Psychiatrist',
      'Dentist',
      'General surgeon',
      'Dermatologist',
      'Cardiologists',
      'Gastroenterologists',
      'Hematologists'
    ];

    List<String> specialityIcons = [
      'https://www.nicepng.com/png/detail/20-206990_primary-care-doctor-doctor-png.png',
      'https://w7.pngwing.com/pngs/621/257/png-transparent-obstetrics-and-gynaecology-obstetrics-and-gynaecology-clinic-hospital-obstetrics-s-purple-blue-text-thumbnail.png',
      'https://image.flaticon.com/icons/png/512/421/421278.png',
      'https://img.icons8.com/color/452/dentist.png',
      'https://image.flaticon.com/icons/png/512/387/387628.png',
      'https://www.hi-techmedicalrkl.org/images/icons/Dermatology.png',
      'https://icons.iconarchive.com/icons/medicalwp/medical/256/Cardiology-blue-icon.png',
      'https://www.pngitem.com/pimgs/m/79-794802_medico-gastroenterologo-logo-hd-png-download.png',
      'https://img2.pngio.com/blood-donation-healthcare-hematology-icon-hematology-png-512_512.png',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a Doctor'),
      ),
      body: AnimationLimiter(
        child: GridView.count(
          crossAxisCount: columnCount,
          children: List.generate(
            typesOfDoctors.length,
            (int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: columnCount,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: yourListChild(
                          typesOfDoctors[index], specialityIcons[index]),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  GestureDetector yourListChild(String type, String imageUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorList(
              docType: type,
            ),
          ),
        );
        // Get.to(DoctorList()) ;
      },
      child: Container(
        width: 150,
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: CachedNetworkImageProvider(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(.5),
                Colors.black.withOpacity(.5),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Wrap(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      type,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
