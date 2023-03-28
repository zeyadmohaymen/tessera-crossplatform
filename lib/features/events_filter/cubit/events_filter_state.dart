part of 'events_filter_cubit.dart';

abstract class EventsFilterState {
  const EventsFilterState();

  // @override
  // List<Object> get props => [];
}

class EventsFilterInitial extends EventsFilterState {}

class SelectionChanged extends EventsFilterState {
  // @override
  // List<Object> get props => [];
}

class FilterCriteriaSelected extends EventsFilterState {
  const FilterCriteriaSelected(this.filterCriteria);

  final List<EventFilterChip> filterCriteria;

  // @override
  // List<Object> get props => [filterCriteria];
}
