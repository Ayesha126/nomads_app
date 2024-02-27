import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomads/cubit/app_cubit_states.dart';
import 'package:nomads/cubit/app_cubits.dart';
import 'package:nomads/misc/colors.dart';
import 'package:nomads/widgets/app_button.dart';
import 'package:nomads/widgets/app_large_text.dart';
import 'package:nomads/widgets/app_text.dart';
import 'package:nomads/widgets/responsive_button.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}): super(key:key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int gottenStars=4;
  int selectedIndex=-1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits ,CubitStates >(builder:(context ,state){
      DetailState detail = state as DetailState ;
      return Scaffold(
        body: Container(
          width: double.maxFinite ,
          height : double.maxFinite ,

          child: Stack (
            children: [

              Positioned(
                  left:0,
                  right:0,
                  child:  Container(
                    width: double.maxFinite ,
                    height:350,
                    decoration: BoxDecoration (
                      image: DecorationImage(
                        image:NetworkImage ("http://mark.bslmeiyu.com/uploads/"+detail.place.img),
                        fit: BoxFit.cover ,
                      ),

                    ),
                  )),
              Positioned(
                  left:10,
                  top:50,
                  child:  Row(
                    children: [
                      IconButton(onPressed: (){
                        BlocProvider.of<AppCubits >(context).goHome();
                      }, icon: Icon(Icons.menu),color: Colors.white,),
                    ],
                  )),
              Positioned(

                  top:320,
                  child:  Container (
                      padding: const EdgeInsets.only(top:20,left:20,right:20) ,
                      width:MediaQuery.of( context ).size.width ,
                      height:500,
                      decoration: BoxDecoration (
                          color:Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular( 30),
                            topRight: Radius.circular( 30),
                          )
                      ) ,
                      child: Column (
                        crossAxisAlignment: CrossAxisAlignment.start ,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                            children: [
                              AppLargeText(text: detail.place.name,color:Colors.black.withOpacity( 0.7) ),
                              AppLargeText(text:  "\$" +detail.place.price.toString() ,color:AppColors.mainColor ),
                            ],
                          ),
                          SizedBox(height:8,),
                          Row(
                            children: [
                              Icon(Icons.location_on_sharp ,color:AppColors .mainColor,),
                              SizedBox(width:5,),
                              AppText(text:  detail.place.location ,color:AppColors.textColor1 ,)
                            ],
                          ),
                          SizedBox(height:12,),
                          Row(
                            children: [
                              Wrap(
                                  children: List.generate( 5, (index){
                                    return Icon(Icons.star,color:index<detail.place.stars? AppColors .startColor:AppColors.textColor2 );
                                  })
                              ),
                              SizedBox(width:8,),
                              AppText(text:  "(5.0)",color:AppColors.textColor2 ,)
                            ],
                          ),
                          SizedBox(height:15,),
                          AppLargeText(text:  "People",color:Colors.black54.withOpacity(0.7),size:20, ),
                          SizedBox(height:5,),
                          AppText(text:  "Number of People in your Group",color:AppColors.mainTextColor ,),
                          SizedBox(height:10,),
                          Wrap(
                              children: List.generate( 5, (index) {
                                return InkWell(
                                  onTap: (){
                                    setState((){
                                      selectedIndex =index ;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right:10) ,
                                    child: AppButtons(
                                      color: selectedIndex==index?Colors.white:Colors.black ,
                                      size: 50,
                                      backgroundcolor: selectedIndex==index?Colors.black:AppColors.buttonBackground ,
                                      bordercolor: selectedIndex==index?Colors.black:AppColors.buttonBackground,
                                      text:(index+1).toString() ,
                                    ),
                                  ),
                                ) ;
                              })
                          ),
                          SizedBox(height:20,),
                          AppLargeText(text:"Description",color:Colors.black54.withOpacity(0.7),size:20,),
                          SizedBox(height:10,),
                          AppText(text:  detail.place.description ,color:AppColors.mainTextColor ,),
                          SizedBox(height:10,),

                        ],
                      )
                  )),
              Positioned(
                bottom:5,
                left:20,
                right: 20,
                child:  Row(
                  children: [
                    AppButtons(
                        color:AppColors.textColor2 ,
                        size: 45,
                        backgroundcolor: Colors.white ,
                        bordercolor: AppColors.textColor2,
                        isIcon: true,
                        icon: Icons.favorite_border_outlined
                    ),
                    SizedBox(width: 20),
                    ResponsiveButton(
                      width: 10,
                      isResponsive: true,
                    )
                  ],
                ),),
            ],
          ),
        ),
      ) ;
    });
  }
}
