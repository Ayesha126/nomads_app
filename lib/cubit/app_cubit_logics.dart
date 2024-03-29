
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomads/cubit/app_cubit_states.dart';
import 'package:nomads/pages/welcome_page.dart';

import '../pages/detail_page.dart';
import '../pages/home_page.dart';
import '../pages/navpages/main_page.dart';
import 'app_cubits.dart';

class AppCubitLogics extends StatefulWidget {
  const AppCubitLogics({Key? key}): super(key:key);

  @override
  _AppCubitLogicsstate createState() => _AppCubitLogicsstate();
}

class _AppCubitLogicsstate extends State<AppCubitLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: BlocBuilder<AppCubits,CubitStates>(
      builder:(context,state){
        if(state is WelcomeState ){
          return WelcomePage() ;
        }if(state is DetailState ){
          return DetailPage() ;
        }if(state is LoadedState ){
          return MainPage()  ;
        }
        if(state is LoadingState ){
          return Center(child: CircularProgressIndicator (),)  ;
        }
        else{
          return Container();
        }
      },
    ),
    );
  }
}