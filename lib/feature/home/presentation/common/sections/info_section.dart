import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/common/widget/custom_cache_network_image.dart';
import 'package:fitness_app/core/dummy/dummy_constant.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

/// this the static data waiting for api response to be future
/// can be get from shared preference but not in this case
class InfoSection extends StatelessWidget {
  const InfoSection({
    super.key,
  });

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
                text: '${LocaleKeys.Home_hi.tr()} Ahmed,\n',
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
        const CustomCacheNetworkImage(
          imageUrl: dummyImageProfileUrl,
          isCircular: true,
          width: 40,
          height: 40,
        ),
      ],
    );
  }
}
