// Mocks generated by Mockito 5.4.2 from annotations
// in weather_app/test/features/current_weather/data/local_datasource_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:weather_app/core/domain/model/location_model.dart' as _i5;
import 'package:weather_app/features/current_weather/data/local_datasource.dart'
    as _i2;
import 'package:weather_app/features/current_weather/domain/model/current_weather_model.dart'
    as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [CurrentWeatherLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockCurrentWeatherLocalDataSource extends _i1.Mock
    implements _i2.CurrentWeatherLocalDataSource {
  @override
  _i3.Future<_i4.CurrentWeatherModel?> hasCached(
          {required _i5.LocationModel? location}) =>
      (super.noSuchMethod(
        Invocation.method(
          #hasCached,
          [],
          {#location: location},
        ),
        returnValue: _i3.Future<_i4.CurrentWeatherModel?>.value(),
        returnValueForMissingStub: _i3.Future<_i4.CurrentWeatherModel?>.value(),
      ) as _i3.Future<_i4.CurrentWeatherModel?>);
  @override
  _i3.Future<List<_i4.CurrentWeatherModel>> getSavedWeathers() =>
      (super.noSuchMethod(
        Invocation.method(
          #getSavedWeathers,
          [],
        ),
        returnValue: _i3.Future<List<_i4.CurrentWeatherModel>>.value(
            <_i4.CurrentWeatherModel>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i4.CurrentWeatherModel>>.value(
                <_i4.CurrentWeatherModel>[]),
      ) as _i3.Future<List<_i4.CurrentWeatherModel>>);
  @override
  _i3.Future<bool> saveWeather({
    required _i5.LocationModel? location,
    required _i4.CurrentWeatherModel? weather,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWeather,
          [],
          {
            #location: location,
            #weather: weather,
          },
        ),
        returnValue: _i3.Future<bool>.value(false),
        returnValueForMissingStub: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
}
