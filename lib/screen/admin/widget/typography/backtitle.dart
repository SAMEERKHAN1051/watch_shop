import 'package:flutter/material.dart';
import 'package:watch_shop/constant/color_constant.dart';

class BackTitle extends StatelessWidget implements PreferredSizeWidget {
  const BackTitle({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    bool canPop = Navigator.of(context).canPop();

    return AppBar(
      backgroundColor: ColorConstant.mainTextColor,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      leading: canPop
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: ColorConstant.subTextColor),
              onPressed: () => Navigator.pop(context),
            )
          : Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu, color: ColorConstant.subTextColor),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.transparent,
            child: ClipOval(
              child: Image.asset(
                "assets/splash_screen_images/1.png",
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
