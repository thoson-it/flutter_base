import 'package:rxdart/rxdart.dart';
import 'base/bloc_provider.dart';

class MovieBloc extends BlocBase {
  int _currentValue = 1;

  /// In add
  BehaviorSubject<int> _addController = new BehaviorSubject<int>();

  Sink<int> get inLoadMoviesSink => _addController.sink;

  /// Out added
  BehaviorSubject<int> _addedController = new BehaviorSubject<int>();

  Stream<int> get outMoviesStream => _addedController.stream;

  MovieBloc() {
    _addController.stream.listen(_onRequestAdd);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _addController.close();
    _addedController.close();
  }

  void _onRequestAdd(int value) {
    _currentValue += value;
    _onResponseAdded(_currentValue);
  }

  void _onResponseAdded(int value) {
    _addedController.sink.add(value);
  }
}
