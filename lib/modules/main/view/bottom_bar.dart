part of 'main_screen.dart';

extension BottomBar on MainScreen {
  Widget _bottomBar() {
    return BottomBarFloating(
      items: controller.itemsBottomBar,
      backgroundColor: AppColor.colorBackgroundApp,
      color: AppColor.colorTextGrey,
      colorSelected: Colors.blueAccent,
      indexSelected: controller.indexBottomBar.value,
      paddingVertical: 30,
      animated: true,
      blur: 0,
      onTap: (int index) {
        if (controller.indexBottomBar.value == index) return;

        switch (index) {
          case 0:
            controller.mainWidget.value = HomeScreen();
            break;
          case 1:
            controller.mainWidget.value = ListChatScreen();
            break;
          case 2:
            controller.mainWidget.value = AccountScreen();
            break;
          default:
            controller.mainWidget.value = HomeScreen();
            break;
        }

        controller.indexBottomBar.value = index;
      },
    );
  }
}
