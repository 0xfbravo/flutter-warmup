// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

// 🌎 Project imports:
import 'package:weather_app/core/domain/model/location_model.dart';
import 'package:weather_app/design_system/wa_error.dart';
import 'package:weather_app/design_system/wa_loading.dart';
import 'package:weather_app/features/current_weather/presentation/current_weather_widget/cubit.dart';
import 'package:weather_app/features/current_weather/presentation/current_weather_widget/state.dart';

class CurrentWeatherView extends StatelessWidget {
  const CurrentWeatherView({
    required this.location,
    super.key,
  });

  final LocationModel location;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentWeatherCubit>(
      create: (_) => GetIt.I.get<CurrentWeatherCubit>(),
      child: _CurrentWeatherView(
        location: location,
      ),
    );
  }
}

class _CurrentWeatherView extends StatefulWidget {
  const _CurrentWeatherView({
    required this.location,
  });

  final LocationModel location;

  @override
  State<_CurrentWeatherView> createState() => _CurrentWeatherViewState();
}

class _CurrentWeatherViewState extends State<_CurrentWeatherView> {
  @override
  void initState() {
    context
        .read<CurrentWeatherCubit>()
        .getCurrentWeather(location: widget.location);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentWeatherCubit, CurrentWeatherState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.black54,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        widget.location.name,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                  if (state is CurrentWeatherLoading) const WALoading(),
                  if (state is CurrentWeatherError) const WAError(),
                  if (state is CurrentWeatherLoaded)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  '${state.weather.temperature.toInt()}°',
                                  style: const TextStyle(
                                    color: Colors.black45,
                                    fontSize: 64,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Min: ${state.weather.minTemperature.toInt()}°',
                                      style: const TextStyle(
                                        color: Colors.black45,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Max: ${state.weather.maxTemperature.toInt()}°',
                                      style: const TextStyle(
                                        color: Colors.black45,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://openweathermap.org/img/wn/${state.weather.icon}@2x.png',
                                  fit: BoxFit.cover,
                                  width: 64,
                                  height: 64,
                                  placeholder: (context, url) => const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  state.weather.main,
                                  style: const TextStyle(
                                    color: Colors.black45,
                                    fontSize: 12,
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
        );
      },
    );
  }
}
