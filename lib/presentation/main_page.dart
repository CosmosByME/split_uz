import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:split_uz/core/theme/icons.dart';
import 'package:split_uz/presentation/home/home_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      background: Image.asset(
        'assets/background/photo1.jpg',
        fit: BoxFit.cover,
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomePage(),
          Center(child: Text('Bookmarks')),
          Center(child: Text('Persons')),
          Center(child: Text('Person')),
        ],
      ),
      bottomBar: GlassBottomBar(
        iconSize: 28,
        magnification: 1.5,
        glowDuration: Duration(milliseconds: 0),
        quality: GlassQuality.premium,
        tabs: [
          GlassBottomBarTab(icon: AppIcons.grid),
          GlassBottomBarTab(icon: AppIcons.bookmark),
          GlassBottomBarTab(icon: AppIcons.persons),
          GlassBottomBarTab(icon: AppIcons.person),
        ],
        extraButton: GlassBottomBarExtraButton(
          icon: AppIcons.add,
          onTap: () {},
          label: 'Add',
        ),
        selectedIndex: selectedIndex,
        onTabSelected: (index) {
          pageController.jumpToPage(index);
          setState(() {
            selectedIndex = index;
          });
        },
        selectedIconColor: CupertinoColors.black,
        unselectedIconColor: CupertinoColors.white,
        maskingQuality: MaskingQuality.high,
      ),
    );
  }
}
