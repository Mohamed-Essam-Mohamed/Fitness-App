import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/constants/app_values.dart';
import 'package:fitness_app/core/enum/status.dart';
import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/core/network/common/helper.dart';
import 'package:fitness_app/feature/profile/domain/entities/get_profile_entity.dart';
import 'package:fitness_app/feature/profile/domain/use_cases/get_data_profile_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getDataProfileUseCase) : super(const ProfileState());
  GetDataProfileUseCase _getDataProfileUseCase;

  Future<void> doIntend(ProfileAction action) async {
    switch (action) {
      case GetDataProfileAction():
        await _getProfile();
    }
  }

  Future<void> _getProfile() async {
    emit(state.copyWith(getProfileStatus: Status.loading));
    // not the best get token from shared preference but wait for change this in future
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString(AppValues.token);
    final result = await _getDataProfileUseCase.call(token!);
    switch (result) {
      case SuccessResult<GetProfileEntity>():
        emit(state.copyWith(
          getProfileStatus: Status.success,
          dataUserEntity: result.data.user,
        ));
      case FailureResult<GetProfileEntity>():
        emit(state.copyWith(
          getProfileStatus: Status.failure,
          errorMessage: Helper.getMessageFromException(result.exception),
        ));
    }
  }
}
