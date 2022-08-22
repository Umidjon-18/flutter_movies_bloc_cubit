
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'connection_error_event.dart';
part 'connection_error_state.dart';

class ConnectionErrorBloc extends Bloc<ConnectionErrorEvent, ConnectionErrorState> {
  ConnectionErrorBloc() : super(ConnectionErrorInitial()) {
    on<ConnectionErrorEvent>((event, emit) {
    });
  }
}
