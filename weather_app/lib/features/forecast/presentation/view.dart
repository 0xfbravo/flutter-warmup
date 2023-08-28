// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/design_system/wa_error.dart';
import 'package:weather_app/design_system/wa_loading.dart';
import 'package:weather_app/features/forecast/presentation/cubit.dart';
import 'package:weather_app/features/forecast/presentation/forecast_widget/view.dart';
import 'package:weather_app/features/forecast/presentation/state.dart';

class ForecastPageView extends StatefulWidget {
  const ForecastPageView({super.key});

  @override
  State<ForecastPageView> createState() => _ForecastPageViewState();
}

class _ForecastPageViewState extends State<ForecastPageView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForecastPageCubit>(
      create: (_) => GetIt.I.get<ForecastPageCubit>(),
      child: BlocBuilder<ForecastPageCubit, ForecastPageState>(
        builder: (context, state) {
          if (state is ForecastPageLoading) {
            return const WALoading();
          }

          if (state is ForecastPageError) {
            return const WAError();
          }

          state as ForecastPageLoaded;
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ForecastView(
                location: state.locations[index],
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              indent: 8,
              endIndent: 8,
              height: 30,
              thickness: 0.1,
              color: Colors.black12,
            ),
            itemCount: state.locations.length,
          );
        },
      ),
    );
  }
}
