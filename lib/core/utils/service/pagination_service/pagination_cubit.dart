import 'package:bloc/bloc.dart';

import '../../../data/model/base_response_model.dart';
import '../../failures/base_failure.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'pagination_state.dart';

class PaginationCubit<T> extends Cubit<PaginationState> {
  final Future<Page<T>> Function(int currentPage, int maxResult) loadPage;

  PaginationCubit({required this.loadPage,})
      : super(PaginationState<T>.initial()) {
    getPaginatedList(false);
  }

  getPaginatedList(bool getMore) async {
    try {
      final res = (await loadPage(state.currentPage, 10));
      if (res.list.isEmpty) {
        emit(state.copyWith(
          refreshController: state.refreshController
            ..refreshCompleted()
            ..loadNoData(),
          status: state.currentPage == 1
              ? PaginationStatus.noDataFound
              : state.status,
        ));
      } else {
        emit(state.getListPaginationSuccess(
          res,
          (getMore)
              ? PaginationStatus.loadSuccess
              : PaginationStatus.refreshSuccess,
          state.currentPage + 1,
          getMore,
        ));
        emit(state.copyWith(
          refreshController: state.refreshController
            ..loadComplete()
            ..resetNoData(),
        ));
        (getMore)
            ? emit(state.copyWith(
                refreshController: state.refreshController..loadComplete()))
            : emit(state.copyWith(
                refreshController: state.refreshController
                  ..refreshCompleted()));
      }
    } on Failure catch (l) {
      if (getMore) {
        emit(state.copyWith(
            refreshController: state.refreshController..loadFailed()));
      } else {
        emit(state.paginationError(l));
        emit(state.copyWith(
            refreshController: state.refreshController..refreshFailed()));
      }
    }
  }

  load(bool isLoad) {
    if (!isLoad) {
      emit(state.changePageKey(1));
      emit(state.copyWith(
          refreshController: state.refreshController..resetNoData()));
    }
    //refresh page
    if (state.currentPage == 1) {
      emit(state.copyWith(status: PaginationStatus.refreshing));
      getPaginatedList(isLoad);
    } else {
      emit(state.copyWith(
        status: PaginationStatus.loading,
      ));
      getPaginatedList(isLoad);
    }
  }

  refresh() {
    state.refreshController.refreshCompleted();
    state.refreshController.resetNoData();
  }

  tryAgain() {
    emit(state.copyWith(status: PaginationStatus.initial));
    getPaginatedList(false);
  }

  search() {
    emit(state.copyWith(status: PaginationStatus.initial));
  }
}
