part of 'connection_error_bloc.dart';

abstract class ConnectionErrorState extends Equatable {
  const ConnectionErrorState();
  
  @override
  List<Object> get props => [];
}

class ConnectionErrorInitial extends ConnectionErrorState {}
