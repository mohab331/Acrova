import 'package:bloc/bloc.dart';

import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardCubitState> {
  DashboardCubit() : super(const DashboardCubitState.initial());
}
