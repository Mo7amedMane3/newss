import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newss/core/theming/cubit/cubit.dart';
import 'package:newss/core/theming/light_colors.dart';

class DrawerView extends StatelessWidget {
  Function onClick;
   DrawerView({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.7,
      color: Colors.white,
      child: Column(

        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: ThemingCubit.get(context).colors.primary,
            child: Center(
              child: Text("News App",
              style: TextStyle(
                color: ThemingCubit.get(context).colors.secondary,
                fontSize: 24,
                fontWeight: FontWeight.w700
              ),),
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 18,left: 5),
              width: double.infinity,
              height: double.infinity,
              color:ThemingCubit.get(context).colors.secondary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                      onClick();
                    },
                    child: Text("Go To Home",
                      style: GoogleFonts.poppins(
                        color: ThemingCubit.get(context).colors.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                    ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Divider(color: Colors.grey,thickness: 1,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Light Theme",
                        style: GoogleFonts.poppins(
                          color: ThemingCubit.get(context).colors.primary,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,

                        ),

                      ),

                      Switch(value:ThemingCubit.get(context).colors is LightColors,
                          onChanged: (value){
                        Navigator.pop(context);
                        ThemingCubit.get(context).changeTheming();

                          }),
                    ],

                  ),
                  SizedBox(height: 12),
                  Divider(color: Colors.grey,thickness: 1,),

                ],

            ),
          )
          )]
      ),
    );
  }
}
