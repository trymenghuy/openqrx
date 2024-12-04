import 'package:flutter/material.dart';
import 'package:openqrx/feature/shared/test/floor_test.dart';
import 'package:openqrx/feature/shared/widgets/app_state/empty_app_state.dart';
import 'package:openqrx/feature/shared/widgets/app_state/init_app_state.dart';

class AppState<T> {
  final T? data;
  final Widget? float;
  final bool noLoad;
  final bool? isEmpty;

  const AppState({
    this.data,
    this.float,
    this.noLoad = false,
    this.isEmpty,
  });

  Widget build({
    required Widget Function(T) builder,
    Widget? placeholder,
  }) {
    if (data == null) {
      if (isEmpty == true) {
        return const FloorTest();
        return const EmptyAppState();
      }
      if (!noLoad) {
        return placeholder ?? const InitAppState();
      }
    }
    return Stack(
      children: [
        builder(data as T),
        if (float != null) float!,
      ],
    );
    // return Scaffold(
    //   body: builder(data as T),
    //   extendBody: true,
    //   floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
    //   bottomNavigationBar: float,
    //   resizeToAvoidBottomInset: false,
    // );
  }

  AppState<T> copyWith({
    T? data,
    Widget? float,
    bool? noLoad,
    bool? isEmpty,
  }) {
    return AppState<T>(
      data: data,
      float: float,
      // float: float ?? this.float,
      noLoad: noLoad ?? this.noLoad,
      isEmpty: isEmpty ?? this.isEmpty,
    );
  }

  AppState<T> empty() => copyWith(data: null, float: null, isEmpty: true);
  AppState<T> init([T? newData]) =>
      copyWith(data: newData, float: null, isEmpty: false);
  AppState<T> set([T? newData]) => copyWith(data: newData);
  AppState<T> alert(Widget? pop) => copyWith(float: pop, data: data);
  AppState<T> popFloat() => copyWith(float: null, data: data);
}
