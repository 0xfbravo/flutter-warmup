// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

// 🌎 Project imports:
import 'package:weather_app/design_system/wa_error.dart';
import 'package:weather_app/design_system/wa_loading.dart';
import 'package:weather_app/features/current_weather/presentation/cubit.dart';
import 'package:weather_app/features/current_weather/presentation/current_weather_widget/view.dart';
import 'package:weather_app/features/current_weather/presentation/state.dart';
import 'package:weather_app/features/forecast/presentation/view.dart';

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
            return WAError(
              onRefresh: context.read<CurrentWeatherPageCubit>().getLocations,
            );
          }

          state as CurrentWeatherPageLoaded;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: SearchBar(
                  hintText: 'Search',
                  hintStyle: const MaterialStatePropertyAll(
                    TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                  onSubmitted: (String value) => context
                      .read<CurrentWeatherPageCubit>()
                      .searchLocation(query: value),
                ),
              ),
              Flexible(
                child: RefreshIndicator(
                  onRefresh:
                      context.read<CurrentWeatherPageCubit>().getLocations,
                  backgroundColor: Colors.amber,
                  color: Colors.white,
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () => Get.to<void>(
                          () => ForecastView(
                            location: state.locations[index],
                          ),
                        ),
                        child: CurrentWeatherView(
                          location: state.locations[index],
                        ),
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
