import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(CameraNotInitializedState());

  initilizeCamera() async {
    try {
      List<CameraDescription> cameras = await availableCameras();
      CameraDescription camera = cameras.first;
      CameraController cameraController =
          CameraController(camera, ResolutionPreset.low);
      await cameraController.initialize();
      emit(CameraInitializedState(
          camera: camera, cameraController: cameraController));
    } catch (e) {
      print('=================================');
      print('UnAble to initilize Camera');
      print(e.toString());
      print('=================================');
      emit(CameraNotInitializedState());
    }
  }
}
