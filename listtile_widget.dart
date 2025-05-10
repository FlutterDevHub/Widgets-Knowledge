 ListTile(
            leading: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primairyColor1, width: 1.5),
              ),
              child: ClipOval(
                child: Image(
                  image: AssetImage(AppImages.storyImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: CustomText(title: "Love Story"),
            subtitle: CustomText(
              title: "Created By : Taylor Swift",
              color: AppColors.subTitleColor,
              fontSize: 12,
            ),
            trailing: CustomText(
              title: "01:20",
              color: AppColors.subTitleColor,
              fontSize: 12,
            ),
          );
