import 'package:fitness_app/feature/home/presentation/common/widget/tab_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/feature/home/domain/entities/upcoming_workouts_category_entity.dart';

class TabContainerWidget extends StatefulWidget {
  const TabContainerWidget({
    super.key,
    required this.items,
    required this.onTabSelected,
    this.initialIndex = 0,
  });

  final List<MuscleItemGroupEntity> items;
  final Function(MuscleItemGroupEntity category, int index) onTabSelected;
  final int initialIndex;

  @override
  State<TabContainerWidget> createState() => _TabContainerWidgetState();
}

class _TabContainerWidgetState extends State<TabContainerWidget> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.items.length,
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
              setState(() {
                selectedIndex = index;
              });
              widget.onTabSelected(widget.items[index], index);
            },
            tabs: widget.items.map(
                  (source) {
                return TabItemWidget(
                  category: source,
                  isSelected: selectedIndex == widget.items.indexOf(source),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
