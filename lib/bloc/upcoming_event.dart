part of 'upcoming_bloc.dart';

abstract class UpcomingEvent extends Equatable {
  const UpcomingEvent();

}


class UpcomingLoadDataEvent extends UpcomingEvent {
  const UpcomingLoadDataEvent();
  @override
  List<Object?> get props => [];
}
