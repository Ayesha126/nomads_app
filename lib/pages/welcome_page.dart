import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomads/cubit/app_cubits.dart';
import 'package:nomads/widgets/responsive_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List<String> images = [
    "w1.jpg",
    "w2.jpg",
    "w3.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: images.length,
          itemBuilder: (_, index){
            return Container(
              width: double.maxFinite,
              height: double.maxFinite ,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "img/${images[index]}"
                  ),
                  fit: BoxFit .cover
                )
              ) ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 680, left: 125, right: 99),
                    child: GestureDetector (
                      onTap: (){
                        BlocProvider .of<AppCubits >(context ).getData() ;
                      },
                        child: Container(
                            child: ResponsiveButton()
                        )),
                  ),
                ],
              ),

            );
      }),
    );
  }
}
