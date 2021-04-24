import 'package:travel_app/extensions/list_extensions.dart';

class UIModel<T> {
  final OperationState state;
  final T data;
  final Object error;

  UIModel(this.state, this.data, this.error);

  factory UIModel.success(T data) {
    return UIModel(OperationState.ok, data, null);
  }

  factory UIModel.loading() {
    return UIModel(OperationState.loading, null, null);
  }

  factory UIModel.error(Object error, {Object data}) {
    return UIModel(OperationState.error, data, error);
  }

  bool get isSuccess => state == OperationState.ok;

  bool get isLoading => state == OperationState.loading;

  bool get isError => state == OperationState.error;

  bool compareData(UIModel other) {
    if (data is List) {
      return (data as List).equals(other.data);
    } else {
      return data == other.data;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UIModel && compareData(other) && error == other.error;

  @override
  int get hashCode => state.hashCode ^ data.hashCode ^ error.hashCode;
}

enum OperationState { loading, error, ok }

class UIError extends Error {}
