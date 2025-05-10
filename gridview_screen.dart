import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:talkiam/core/common/custam_container.dart';
import 'package:talkiam/core/utils/Themes/app_color.dart';
import 'package:talkiam/core/utils/Themes/app_images.dart';

class GridViewScreen extends StatelessWidget {
  GridViewScreen({super.key});

  final List pic = [
    AppImages.image1,
    AppImages.image2,
    AppImages.image3,
    AppImages.image4,
    AppImages.image5,
    AppImages.image6,
    AppImages.image7,
    AppImages.image1,
  ];

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      cir: 15.sp,
      col: AppColors.lightGray,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: MGridViewBuilder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: pic.length,
          mainAxisSpacing: 15.sp,
          crossAxisSpacing: 15.sp,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(pic[index], fit: BoxFit.cover),
            );
          },
        ),  
      ),
    );
  }
}
class MGridViewBuilder extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final int columnCount;
  final EdgeInsets padding;
  final double topPadding;
  final ScrollPhysics physics;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  const MGridViewBuilder({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.columnCount = 2,
    this.padding = const EdgeInsets.all(2),
    this.topPadding = 30,
    this.physics = const BouncingScrollPhysics(),
    this.mainAxisSpacing = 4,
    this.crossAxisSpacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    final List<List<Widget>> columns = List.generate(
      columnCount,
      (_) => <Widget>[],
    );

    for (int i = 0; i < itemCount; i++) {
      final columnIndex = i % columnCount;
      columns[columnIndex].add(
        Padding(
          padding: EdgeInsets.only(bottom: mainAxisSpacing),
          child: itemBuilder(context, i),
        ),
      );
    }

    final effectivePadding = padding.add(EdgeInsets.only(top: topPadding));

    return SingleChildScrollView(
      physics: physics,
      padding: effectivePadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(columnCount, (i) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: i != columnCount - 1 ? crossAxisSpacing : 0,
              ),
              child: Column(children: columns[i]),
            ),
          );
        }),
      ),
    );
  }
}
