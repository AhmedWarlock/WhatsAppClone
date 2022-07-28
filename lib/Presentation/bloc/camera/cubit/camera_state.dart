part of 'camera_cubit.dart';

abstract class CameraState extends Equatable {
  const CameraState();

  @override
  List<Object> get props => [];
}

class CameraInitial extends CameraState {}

class CameraInitializedState extends CameraState {
  final CameraDescription camera;
  final CameraController cameraController;
  CameraInitializedState(
      {required this.camera, required this.cameraController});
  @override
  List<Object> get props => [];
}

class CameraNotInitializedState extends CameraState {
  @override
  List<Object> get props => [];
}
