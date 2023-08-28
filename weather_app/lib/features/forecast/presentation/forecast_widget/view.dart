// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/core/domain/model/location_model.dart';
import 'package:weather_app/design_system/wa_error.dart';
import 'package:weather_app/design_system/wa_loading.dart';
import 'package:weather_app/features/forecast/presentation/forecast_widget/cubit.dart';
import 'package:weather_app/features/forecast/presentation/forecast_widget/state.dart';

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
    return BlocBuilder<ForecastCubit, ForecastState>(
      builder: (context, state) {
        if (state is ForecastLoading) {
          return const WALoading();
        }

        if (state is ForecastError) {
          return const WAError();
        }

        state as ForecastLoaded;
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Placeholder(
                fallbackWidth: 30,
                fallbackHeight: 30,
              ),
            ],
          ),
        );
      },
    );
  }
}
