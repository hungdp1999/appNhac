import 'package:base_project/pages/setting/setting_page.dart';
import 'package:base_project/pages/trending/trending_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'helper/custom_bottom_bar.dart';
import 'pages/playlist/playlist_page.dart';
import 'pages/search/search_page.dart';
import 'styles/icons.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
      fallbackLocale: const Locale('en', 'US'),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (ctx, __) => MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: ctx.locale,
          supportedLocales: ctx.supportedLocales,
          localizationsDelegates: ctx.localizationDelegates,
          home: const SplashScreen(),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
        ),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainView();
    // IntroView(
    //   child: MainView(),
    // );
  }
}

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late List<TabItem> pages;
  final pageController = PageController();
  final _tabNavigator = GlobalKey<TabNavigatorState>();
  final _tab1 = GlobalKey<NavigatorState>();
  final _tab2 = GlobalKey<NavigatorState>();
  final _tab3 = GlobalKey<NavigatorState>();
  final _tab4 = GlobalKey<NavigatorState>();

  var _tabSelectedIndex = 0;
  var _tabPopStack = false;

  @override
  void initState() {
    pages = [
      TabItem(_tab1, const PlaylistPage()),
      TabItem(_tab2, const SearchPage()),
      TabItem(_tab3, const TrendingPage()),
      TabItem(_tab4, const SettingPage()),
    ];
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _setIndex(int index) {
    setState(() {
      _tabPopStack = _tabSelectedIndex == index;
      _tabSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bgColorTab = Theme.of(context).scaffoldBackgroundColor;
    return WillPopScope(
        onWillPop: () async => !await _tabNavigator.currentState!.maybePop(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              TabNavigator(
                key: _tabNavigator,
                tabs: pages,
                selectedIndex: _tabSelectedIndex,
                popStack: _tabPopStack,
              ),
            ],
          ),
          bottomNavigationBar: AnimatedContainer(
            width: MediaQuery.of(context).size.width,
            height: 100,
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            child: Container(
              color: bgColorTab,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  BottomNavigationBar(
                    elevation: 0,
                    backgroundColor: bgColorTab,
                    type: BottomNavigationBarType.fixed,
                    currentIndex: _tabSelectedIndex,
                    selectedItemColor: Colors.deepOrangeAccent,
                    onTap: _setIndex,
                    items: [
                      _buildItemNavigationBar(
                        AppIcons.iPlaylist,
                        AppIcons.iPlaylistActive,
                        'barPlaylist'.tr(),
                      ),
                      _buildItemNavigationBar(
                        AppIcons.iSearch,
                        AppIcons.iSearchActive,
                        'barSearch'.tr(),
                      ),
                      _buildItemNavigationBar(
                        AppIcons.iTrending,
                        AppIcons.iTrendingActive,
                        'barTrending'.tr(),
                      ),
                      _buildItemNavigationBar(
                        AppIcons.iMore,
                        AppIcons.iMoreActive,
                        'barMore'.tr(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  BottomNavigationBarItem _buildItemNavigationBar(
      String icon, String iconActive, String title) {
    const size = 24.0;
    return BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Image(
            image: AssetImage(icon),
            width: size,
            height: size,
          ),
        ),
        activeIcon: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Image(
            image: AssetImage(iconActive),
            width: size,
            height: size,
          ),
        ),
        label: title);
  }
}
