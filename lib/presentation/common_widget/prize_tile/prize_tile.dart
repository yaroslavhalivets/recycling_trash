import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/data/api/prize_api/prize_api.dart';
import 'package:retrash_app/presentation/bloc/bloc_provider.dart';
import 'package:retrash_app/presentation/common_widget/main_button/main_button.dart';
import 'package:retrash_app/presentation/resources/app_strings.dart';
import 'package:retrash_app/presentation/screens/presents_screen/presents_bloc.dart';

class PrizeTile extends StatelessWidget {
  final PrizeApi prize;

  const PrizeTile({Key? key, required this.prize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(prize.name, style: Theme.of(context).textTheme.subtitle2),
          const SizedBox(
            height: 20.0,
          ),
          Image.network(prize.imageUrl,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3),
          const SizedBox(
            height: 20.0,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(AppStrings.requiredPoints(prize.requiredPoints),
                  style: Theme.of(context).textTheme.bodyText1),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(AppStrings.partnerName(prize.partnerName),
                  style: Theme.of(context).textTheme.bodyText1),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: MainButton.fromText(
              AppStrings.chooseThisPrize,
              onTap: () =>
                  BlocProvider.of<PresentsBloc>(context).setUserPrize(prize.id),
            ),
          ),
        ],
      ),
    );
  }
}
