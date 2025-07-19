import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/common/widget/custom_cache_network_image.dart';
import 'package:fitness_app/core/dummy/dummy_constant.dart';
import 'package:fitness_app/core/storage_helper/app_shared_preference_helper.dart';
import 'package:fitness_app/feature/auth/domain/entities/login/response/user_data_entity.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

/// this the static data waiting for api response to be future
/// can be get from shared preference but not in this case
class InfoSection extends StatefulWidget {
  const InfoSection({
    super.key,
  });

  @override
  State<InfoSection> createState() => _InfoSectionState();
}

class _InfoSectionState extends State<InfoSection> {
  UserDataEntity? dataUser;
  @override
  void initState() {
    getDataUserPref();
    super.initState();
  }

  void getDataUserPref() async {
    dataUser = await SharedPreferencesHelper.getDataUserPref();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
          TextSpan(
            children: [
              TextSpan(
                text: '${LocaleKeys.Home_hi.tr()} ${dataUser?.firstName ?? 'Mohamed'},\n',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(height: 1.40, fontWeight: FontWeight.w500),
              ),
              TextSpan(
                text: LocaleKeys.Home_LetsStartYourDay.tr(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(height: 1.40, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        CustomCacheNetworkImage(
          imageUrl: dataUser?.photo ?? dummyImageProfileUrl,
          isCircular: true,
          width: 40,
          height: 40,
        ),
      ],
    );
  }
}
