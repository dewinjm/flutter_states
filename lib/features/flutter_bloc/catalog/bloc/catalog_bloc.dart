import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:state_management/common/common.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc({required this.catalogRepository}) : super(CatalogLoading()) {
    on<CatalogStarted>(_onStarted);
  }

  final CatalogRepository catalogRepository;

  void _onStarted(CatalogStarted event, Emitter<CatalogState> emit) async {
    emit(CatalogLoading());
    try {
      final catalog = await catalogRepository.fetch() ?? [];
      emit(CatalogLoaded(catalog));
    } catch (_) {
      emit(CatalogError());
    }
  }
}
