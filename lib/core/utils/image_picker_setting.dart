import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:fitness_app/core/enum/status.dart' show SourceImage;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class SelectImagePicker {

  static final ImagePicker _imagePicker = ImagePicker();

  ///Select one image from camera or gallery
 static  Future<File?> chooseOneImage(SourceImage source) async {
    
    final result=await  _checkPermission(source);
    if(!result){
      return null;
    }

    final photo = await _imagePicker.pickImage(
        source: source == SourceImage.camera
            ? ImageSource.camera
            : ImageSource.gallery);
    return photo != null ? File(photo.path) : null;
  }

 static  Future<bool> _checkPermission(SourceImage source) async {
    final PermissionStatus status;

    ///camera
    if (source == SourceImage.camera) {
      status = await Permission.camera.request();
    }

    ///gallery
    else {
      if (Platform.isAndroid) {
        final andriodInfo = await DeviceInfoPlugin().androidInfo;
        ///for andriod above 13+
        if (andriodInfo.version.sdkInt >= 33) {
          status = await Permission.photos.request();
        } 
        ///for andriod under 12
        else {
          status = await Permission.storage.request();
        }
      }
       
      ///ios or another platform 
      else {
        status = await Permission.photos.request();
      }
    }

    if (status == PermissionStatus.granted) {
        return true;
      } else if (status == PermissionStatus.permanentlyDenied) {
        await openAppSettings();
      }
      return false;
  }
}
