import 'package:base_project/components/appbar_back_button.dart';
import 'package:base_project/styles/icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  bool isVietNam = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final locale = EasyLocalization.of(context).locale;
    // final isVietNam = locale?.languageCode?.toLowerCase() == 'vi';
    // const bool isVietNam = true;
    final color = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: color,
        leadingWidth: 0,
        leading: const SizedBox.shrink(),
        title: AppBarBackButton(
          title: 'chooseLanguage',
          // LocaleKeys.chooseLanguage.tr(),
          onTap: () => Navigator.pop(context),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            onTap: () => changeLanguage(
              // context: context,
              isVietNam: isVietNam,
              locale: const Locale('vi', 'VN'),
            ),
            title: const Text('Tiếng Việt'),
            trailing: isVietNam
                ? Image.asset(
                    AppIcons.iCheckCircleEnable,
                    width: 22,
                    height: 22,
                  )
                : null,
          ),
          ListTile(
            onTap: () => changeLanguage(
              isVietNam: isVietNam,
              locale: const Locale('en', 'US'),
            ),
            title: const Text('English'),
            trailing: !isVietNam
                ? Image.asset(
                    AppIcons.iCheckCircleEnable,
                    width: 22,
                    height: 22,
                  )
                : null,
          ),
        ],
      ),
    );
  }

  Future changeLanguage({
    // BuildContext context,
    required Locale locale,
    bool isVietNam = false,
  }) async {
    if (isVietNam && locale.languageCode.toLowerCase() == 'vi') {
      return;
    }

    if (!isVietNam && locale.languageCode.toLowerCase() == 'en') {
      return;
    }

    // try {
    //   await BlocProvider.of<AppCubit>(context).changeLanguage(locale);
    //   DialogHelper.instance.showLoading(context);
    //   EasyLocalization.of(context).locale = locale;
    //   DialogHelper.instance.hideLoading(context);
    // } catch (e, stackTrace) {
    //   debugPrint('$e - $stackTrace');
    //   Utils.showToast(LocaleKeys.error.tr());
    // }
  }
}
