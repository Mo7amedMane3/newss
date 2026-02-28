import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:newss/core/theming/base_colors.dart';
import 'package:newss/core/theming/cubit/states.dart';
import 'package:newss/core/theming/light_colors.dart';

import '../dark_colors.dart';
@injectable
class ThemingCubit extends Cubit<ThemingStates> {

  ThemingCubit() : super(ThemingInitStates());
BaseColors colors=LightColors();
static ThemingCubit get(context)=>BlocProvider.of(context);
void changeTheming(){
  if(colors is LightColors){
    colors=DarkColors();
  }else{
    colors=LightColors();
  }
  emit(ChangeThemingStates());
}
}

