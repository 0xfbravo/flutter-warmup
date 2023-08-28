// 🐦 Flutter imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/core/domain/model/location_model.dart';
import 'package:weather_app/design_system/wa_error.dart';
import 'package:weather_app/design_system/wa_loading.dart';
import 'package:weather_app/features/forecast/presentation/cubit.dart';
import 'package:weather_app/features/forecast/presentation/state.dart';

class ForecastView extends StatelessWidget {
  const ForecastView({
    required this.location,
    super.key,
  });

  final LocationModel location;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForecastCubit>(
      create: (_) => GetIt.I.get<ForecastCubit>(),
      child: _ForecastView(
        location: location,
      ),
    );
  }
}

class _ForecastView extends StatefulWidget {
  const _ForecastView({
    required this.location,
  });

  final LocationModel location;

  @override
  State<_ForecastView> createState() => _ForecastViewState();
}

class _ForecastViewState extends State<_ForecastView> {
  @override
  void initState() {
    context.read<ForecastCubit>().getForecast(location: widget.location);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.location.name),
      ),
      body: BlocBuilder<ForecastCubit, ForecastState>(
        builder: (context, state) {
          if (state is ForecastLoading) {
            return const WALoading();
          }

          if (state is ForecastError) {
            return WAError(
              onRefresh: () => context
                  .read<ForecastCubit>()
                  .getForecast(location: widget.location),
            );
          }

          state as ForecastLoaded;
          return GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            children: state.forecast.map(
              (forecast) {
                final date = DateTime.parse(forecast.date);
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        '${date.month}/${date.day} - ${date.hour}h',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Flexible(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Stack(
                              children: [
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            'https://openweathermap.org/img/wn/${forecast.icon}@2x.png',
                                        fit: BoxFit.cover,
                                        width: 64,
                                        height: 64,
                                        placeholder: (context, url) =>
                                            const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 64,
                                              width: 64,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        forecast.main,
                                        style: const TextStyle(
                                          color: Colors.black38,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${forecast.temperature.toInt()}°',
                                          style: const TextStyle(
                                            color: Colors.black45,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Min: ${forecast.minTemperature.toInt()}°',
                                              style: const TextStyle(
                                                color: Colors.black45,
                                                fontSize: 10,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              'Max: ${forecast.maxTemperature.toInt()}°',
                                              style: const TextStyle(
                                                color: Colors.black45,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
