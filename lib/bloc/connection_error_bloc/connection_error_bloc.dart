
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'connection_error_state.dart';

class ConnectionErrorBloc extends Cubit< ConnectionErrorState> {
  ConnectionErrorBloc() : super(ConnectionErrorInitial()) {
   
  }
}
