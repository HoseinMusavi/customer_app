// lib/features/store/presentation/cubit/dashboard_state.dart
part of 'dashboard_cubit.dart';

enum DashboardStatus { initial, loading, success, failure }

class DashboardState extends Equatable {
  final DashboardStatus status;
  final List<PromotionEntity> promotions;
  final List<StoreEntity> stores;
  final String? errorMessage;

  const DashboardState({
    this.status = DashboardStatus.initial,
    this.promotions = const [],
    this.stores = const [],
    this.errorMessage,
  });

  DashboardState copyWith({
    DashboardStatus? status,
    List<PromotionEntity>? promotions,
    List<StoreEntity>? stores,
    String? errorMessage,
  }) {
    return DashboardState(
      status: status ?? this.status,
      promotions: promotions ?? this.promotions,
      stores: stores ?? this.stores,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, promotions, stores, errorMessage];

  get selectedCategory => null;
}
