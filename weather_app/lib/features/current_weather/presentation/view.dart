// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/design_system/wa_error.dart';
import 'package:weather_app/design_system/wa_loading.dart';
import 'package:weather_app/features/current_weather/presentation/cubit.dart';
import 'package:weather_app/features/current_weather/presentation/current_weather_widget/view.dart';
import 'package:weather_app/features/current_weather/presentation/state.dart';

class CurrentWeatherPageView extends StatefulWidget {
  const CurrentWeatherPageView({super.key});

  @override
  State<CurrentWeatherPageView> createState() => _CurrentWeatherPageViewState();
}

class _CurrentWeatherPageViewState extends State<CurrentWeatherPageView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentWeatherPageCubit>(
      create: (_) => GetIt.I.get<CurrentWeatherPageCubit>(),
      child: BlocBuilder<CurrentWeatherPageCubit, CurrentWeatherPageState>(
        builder: (context, state) {
          if (state is CurrentWeatherPageLoading) {
            return const WALoading();
          }

          if (state is CurrentWeatherPageError) {
            return const WAError();
          }

          state as CurrentWeatherPageLoaded;
          return RefreshIndicator(
            onRefresh: context.read<CurrentWeatherPageCubit>().getLocations,
            backgroundColor: Colors.amber,
            color: Colors.white,
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return CurrentWeatherView(
                  location: state.locations[index],
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                height: 1,
                thickness: 1,
                color: Colors.transparent,
              ),
              itemCount: state.locations.length,
            ),
          );
        },
      ),
    );
  }
}
