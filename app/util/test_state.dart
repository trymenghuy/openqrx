// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:openqrx/widget/errors/pop_up_error.dart';
// import 'package:openqrx/widget/view_state/bottom_dialog.dart';
// import 'package:openqrx/widget/view_state/empty_state_widget.dart';
// import 'package:openqrx/widget/view_state/loading_state_widget.dart';
// import 'package:openqrx/widget/view_state/no_connection.dart';

// enum EState { empty, load, complete, errorPop, errorFull, errorBottom }

// class TestState<T> {
//   final T? data;
//   EState state;
//   final String? message;
//   final VoidCallback? onTap;

//   TestState(
//       {this.state = EState.complete, this.data, this.message, this.onTap});
//   TestState<T> reset({T? data}) {
//     return copyWith(
//       data: data,
//       state: EState.complete,
//     );
//   }

//   // bool get isLoading => !(request?.end == true);
//   TestState<T> loading({required VoidCallback onTap}) {
//     return copyWith(state: EState.load, onTap: onTap);
//   }

//   TestState<T> empty() {
//     return copyWith(state: EState.empty);
//   }

//   TestState<T> error(String message,
//       {required VoidCallback onTap, EState? state}) {
//     return copyWith(
//         message: message, state: state ?? EState.errorPop, onTap: onTap);
//   }

//   TestState<T> copyWith({
//     EState? state,
//     String? message,
//     VoidCallback? onTap,
//     T? data,
//   }) {
//     return TestState(
//       state: state ?? this.state,
//       message: message ?? this.message,
//       onTap: onTap ?? this.onTap,
//       data: data ?? this.data,
//     );
//   }

//   Widget build({required Function(T) builder, Widget? placeholder}) {
//     Widget? pop;
//     if (data == null) state = EState.empty;
//     if (state == EState.empty) {
//       return placeholder ?? const EmptyStateWidget();
//     } else if (state == EState.errorFull) {
//       return NoConnection(onTap: onTap);
//     } else if (state == EState.load) {
//       pop = const LoadingStateWidget();
//     } else if (state == EState.errorPop) {
//       pop = PopUpError(
//           title: 'Error occur',
//           onTap: onTap,
//           body: message ?? 'Something went wrong');
//     } else if (state == EState.errorBottom) {
//       pop = BottomDialog(
//         title: message,
//         onTap: onTap,
//       );
//     }
//     return Scaffold(
//       body: builder(data as T),
//       extendBody: true,
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
//       bottomNavigationBar: pop,
//       resizeToAvoidBottomInset: false,
//       //test for text field
//     );
//   }
// }
