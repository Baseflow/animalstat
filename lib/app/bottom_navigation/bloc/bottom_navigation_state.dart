part of 'bottom_navigation_bloc.dart';

@immutable
abstract class BottomNavigationState {
  BottomNavigationState(this.currentPage);

  final BottomNavigationEvent currentPage;
}

class BottomNavigationInitial extends BottomNavigationState {
  BottomNavigationInitial() : super(BottomNavigationEvent.treatmentsPage);
}

class BottomNavigationCurrent extends BottomNavigationState {
  BottomNavigationCurrent(BottomNavigationEvent currentPage)
      : super(currentPage);
}
