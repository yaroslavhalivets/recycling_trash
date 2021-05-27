import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/presentation/screens/app_drawer/app_drawer_bloc.dart';
import 'package:retrash_app/presentation/bloc/bloc_provider.dart';
import 'package:retrash_app/presentation/resources/app_colors.dart';
import 'package:retrash_app/presentation/resources/app_images.dart';

class DrawerHead extends StatelessWidget{
  const DrawerHead();

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
        child: FutureBuilder<String?>(
          future: BlocProvider.of<AppDrawerBloc>(context).getProfilePhoto(),
          builder: (context, snapshot){
            return CircleAvatar(
              backgroundImage: _image(snapshot.data),
              radius: 50.0,
              backgroundColor: AppColors.mineShaft.withOpacity(0.4),
            );
          },
        ),
    );
  }

  ImageProvider _image(String? url) {
    if(url != null){
      return NetworkImage(url);
    }
    return AssetImage(AppImages.userAvatar);
  }

}