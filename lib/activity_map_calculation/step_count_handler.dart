import 'package:pedometer/pedometer.dart';

class StepCountHandler {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';

// StepCount
  String? onStepCount(StepCount event) {
    print(event);
    _steps = event.steps.toString();
    print(_steps);
    return _steps;
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    // StatusChanged
    print(event);
    _status = event.status;
    print(_status);
  }

  void onPedestrianStatusError(error) {
    // Error Handle
    print('onPedestrianStatusError: $error');
    _status = 'Pedestrian Status not available';
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    _steps = 'Step Count not available';
    print(_stepCountStream);
  }

  String? getStepCount() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen((onStepCount) {
      _steps = onStepCount.steps.toString();
    });

    return _steps;
  }
}
