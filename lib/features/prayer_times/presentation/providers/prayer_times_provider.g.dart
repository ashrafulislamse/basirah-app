// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_times_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$prayerCalculationServiceHash() =>
    r'726413f05318d1fb00951b1b6eb2b8dbdf154dc4';

/// Prayer calculation service provider
///
/// Copied from [prayerCalculationService].
@ProviderFor(prayerCalculationService)
final prayerCalculationServiceProvider =
    AutoDisposeProvider<PrayerCalculationService>.internal(
      prayerCalculationService,
      name: r'prayerCalculationServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$prayerCalculationServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PrayerCalculationServiceRef =
    AutoDisposeProviderRef<PrayerCalculationService>;
String _$prayerTimeRepositoryHash() =>
    r'b5ff9c5623050fc442a65bc25c73b50ef9ed176e';

/// Prayer time repository provider
///
/// Copied from [prayerTimeRepository].
@ProviderFor(prayerTimeRepository)
final prayerTimeRepositoryProvider =
    AutoDisposeFutureProvider<PrayerTimeRepository>.internal(
      prayerTimeRepository,
      name: r'prayerTimeRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$prayerTimeRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PrayerTimeRepositoryRef =
    AutoDisposeFutureProviderRef<PrayerTimeRepository>;
String _$currentPrayerHash() => r'45248ebf7511eea17d500e401787779b7412436a';

/// Current prayer provider - gets the next upcoming prayer
///
/// Copied from [currentPrayer].
@ProviderFor(currentPrayer)
final currentPrayerProvider = AutoDisposeFutureProvider<Prayer?>.internal(
  currentPrayer,
  name: r'currentPrayerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentPrayerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentPrayerRef = AutoDisposeFutureProviderRef<Prayer?>;
String _$prayerTimesHash() => r'f031a430325040df6050579cc044f1687177c7d3';

/// Prayer times provider - fetches today's prayer times
///
/// Copied from [PrayerTimes].
@ProviderFor(PrayerTimes)
final prayerTimesProvider =
    AutoDisposeAsyncNotifierProvider<PrayerTimes, List<Prayer>>.internal(
      PrayerTimes.new,
      name: r'prayerTimesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$prayerTimesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PrayerTimes = AutoDisposeAsyncNotifier<List<Prayer>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
