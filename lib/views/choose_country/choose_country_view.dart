import 'package:base_project/components/appbar_back_button.dart';
import 'package:base_project/components/search_bar.dart';
import 'package:base_project/helper/const.dart';
import 'package:base_project/models/country_model.dart';
import 'package:base_project/styles/icons.dart';
import 'package:base_project/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseCountryView extends StatefulWidget {
  final RegionModel? regionModel;

  const ChooseCountryView({super.key, 
    this.regionModel,
  });

  @override
  State<ChooseCountryView> createState() => _ChooseCountryViewState();
}

class _ChooseCountryViewState extends State<ChooseCountryView> {
  RegionModel? _regionModel;
  // AppCubit _appCubit;
  final FocusNode _focusNode = FocusNode();

  List _countries = [];
  List _countriesTemp = [];

  final _controller = TextEditingController();
  // final _throttle = Throttle<String>(const Duration(milliseconds: 300));

  // @override
  // void initState() {
  //   // _appCubit = BlocProvider.of<AppCubit>(context);

  //   _regionModel = widget.regionModel;
  //   _controller.addListener(() => _throttle.value = _controller.text);

  //   _throttle.values.listen((search) {
  //     setState(() {
  //       _countriesTemp = _countries.where((map) {
  //         return map['name'].toLowerCase().contains(search.toLowerCase())
  //             as bool;
  //       }).toList();
  //     });
  //   });

  //   ApiClient.instance.getCountries(context).then((countries) {
  //     _countriesTemp.addAll(countries as List);
  //     setState(() => _countries = countries as List);
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).scaffoldBackgroundColor;
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: color,
          leadingWidth: 0,
          leading: const SizedBox.shrink(),
          title: AppBarBackButton(
            title: 'chooseCountry',
            // LocaleKeys.chooseCountry.tr(),
            onTap: () => Navigator.pop(context),
          ),
          centerTitle: false,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(Const.paddingHorizon.w),
          ),
          child: Column(
            children: <Widget>[
              SearchBar(
                textEditingController: _controller,
                onChange: onChange,
                onSubmit: onSubmit,
                focusNode: _focusNode,
                hintText: 'Search Country ...',
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final country = _countriesTemp[index];
                    final name = country['name'] as String;
                    final code = country['code']?.toLowerCase() as String;
                    final _region = RegionModel(name: name, code: code);

                    return ListTile(
                      onTap: () {
                        // _appCubit.changeRegion(_region);
                        _focusNode.unfocus();
                        setState(() => _regionModel = _region);
                      },
                      title: Text(
                        name,
                        style: AppStyles.title(
                          context,
                          fontSize: 15,
                        ),
                      ),
                      trailing: _regionModel?.code == _region.code
                          ? Image.asset(
                              AppIcons.iCheckCircleEnable,
                              width: 24,
                              height: 24,
                            )
                          : null,
                    );
                  },
                  itemCount: _countriesTemp.length,
                ),
              ),
              // const PaddingBottomView(),
            ],
          ),
        ),
      ),
    );
  }

  void onChange(String keyword) {}

  void onSubmit(String keyword) {}

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
}
