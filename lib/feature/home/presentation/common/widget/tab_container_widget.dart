import 'package:fitness_app/feature/home/domain/entities/upcoming_workouts_category_entity.dart';
import 'package:fitness_app/feature/home/presentation/common/widget/tab_item_widget.dart';
import 'package:flutter/material.dart';

class TabContainerWidget extends StatefulWidget {
  const TabContainerWidget(
      {super.key, required this.upcomingCategory, required this.callBack});
  final List<MuscleItemGroupEntity> upcomingCategory;
  final Function(String id) callBack;

  @override
  State<TabContainerWidget> createState() => _TabContainerWidgetState();
}

class _TabContainerWidgetState extends State<TabContainerWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.upcomingCategory.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            isScrollable: true,
            indicatorColor: Colors.transparent,
            indicator: const BoxDecoration(),
            dividerColor: Colors.transparent,
            labelColor: Colors.transparent,
            padding: EdgeInsets.zero,
            tabAlignment: TabAlignment.start,
            indicatorPadding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
              widget.callBack(widget.upcomingCategory[index].id);
            },
            tabs: widget.upcomingCategory
                .map(
                  (source) => TabItemWidget(
                    category: source,
                    isSelected: selectedIndex == widget.upcomingCategory.indexOf(source),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
