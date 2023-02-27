import 'dart:async';
import 'package:base_project/components/appbar_back_button.dart';
import 'package:base_project/helper/timer_helper.dart';
import 'package:base_project/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TimerAction { origin, isPlaying, pause }

class SleepTimerPage extends StatefulWidget {
  const SleepTimerPage({super.key});

  @override
  State<SleepTimerPage> createState() => _SleepTimerPageState();
}

class _SleepTimerPageState extends State<SleepTimerPage> {
  // AppCubit _mainBloc;

  int _hours = 0;
  int _min = 0;

  Duration? _remainDuration;

  TimerAction? _timerAction;

  StreamSubscription? _subscription;

  // @override
  // void initState() {
  //   _subscription = AppCubit.sleepTimerStream.listen((duration) {
  //     setState(() => _remainDuration = duration);
  //   });

  //   _mainBloc = BlocProvider.of<AppCubit>(context);

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // _timerAction = _mainBloc.timerAction;
    final color = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        elevation: 0,
        backgroundColor: color,
        leading: const SizedBox.shrink(),
        title: AppBarBackButton(
          title: 'sleepTimer',
          // LocaleKeys.sleepTimer.tr(),
          onTap: () => Navigator.pop(context),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (_timerAction == TimerAction.origin)
              Container(
                height: 250,
                margin: const EdgeInsets.only(top: 50, bottom: 10),
                child: Stack(
                  children: <Widget>[
                    _buildScrollTime(),
                    Center(
                        child: Container(
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 17),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: AppStyles.grey4),
                          bottom: BorderSide(color: AppStyles.grey4),
                        ),
                      ),
                    )),
                  ],
                ),
              )
            else
              Container(
                height: 250,
                width: double.infinity,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 50, bottom: 10),
                child: Text(
                  TimerHelper.formatDuration(_remainDuration?? const Duration()),
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.headline5(
                    context,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (_timerAction == TimerAction.origin)
              _buildButton(
                title: 'sleepStart',
                // LocaleKeys.sleepStart.tr(),
                onTap: () => _setTimer(),
              ),
            if (_timerAction == TimerAction.isPlaying)
              _buildButton(
                title: 'sleepPause',
                // LocaleKeys.sleepPause.tr(),
                onTap: () => _pauseTimer(),
              ),
            if (_timerAction == TimerAction.pause)
              _buildButton(
                title: 'sleepResume',
                // LocaleKeys.sleepResume.tr(),
                onTap: () => _resumeTimer(),
              ),
            if (_timerAction != TimerAction.origin)
              _buildButton(
                title: 'sleepReset',
                // LocaleKeys.sleepReset.tr(),
                onTap: () => _resetTimer(),
                color: AppStyles.red,
              ),
            // const BottomPaddingPlaying(),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({String? title, VoidCallback? onTap, Color? color}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 16.w),
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          // ignore: deprecated_member_use
          backgroundColor: Theme.of(context).buttonColor
        ),
        onPressed: () => onTap,
        // color: Theme.of(context).buttonColor,
        // padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          title ?? '',
          style: AppStyles.button(context, color: color),
        ),
      ),
    );
  }

  Widget _buildScrollTime() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildWheel(
            totalItem: 24,
            onSelectedItemChanged: (hour) => _hours = hour,
          ),
          _buildTitle(
            'sleepHours'
            // LocaleKeys.sleepHours.tr(),
          ),
          const SizedBox(width: 20),
          _buildWheel(
            totalItem: 60,
            onSelectedItemChanged: (min) => _min = min,
          ),
          _buildTitle(
            'sleepMin',
            // LocaleKeys.sleepMin.tr(),
          ),
        ],
      ),
    );
  }

  Container _buildTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 17),
      child: Text(
        title,
        style: AppStyles.title(context),
      ),
    );
  }

  Widget _buildWheel({int? totalItem, Function(int)? onSelectedItemChanged}) {
    return Expanded(
      child: ListWheelScrollView(
          itemExtent: 40,
          useMagnifier: true,
          diameterRatio: 1.6,
          magnification: 1.5,
          onSelectedItemChanged: onSelectedItemChanged,
          physics: const FixedExtentScrollPhysics(),
          children: List.generate(totalItem ?? 0, (index) {
            return Text(
              '$index',
              style: AppStyles.headline5(context),
            );
          })),
    );
  }

  void _pauseTimer() {
    setState(() => _timerAction = TimerAction.pause);
    // _mainBloc.pauseSleepTime();
  }

  void _resumeTimer() {
    setState(() => _timerAction = TimerAction.isPlaying);
    // _mainBloc.resumeSleepTime();
  }

  void _resetTimer() {
    setState(() => _timerAction = TimerAction.origin);
    // _mainBloc.resetSleepTime();
  }

  void _setTimer() {
    if (_hours == 0 && _min == 0) {
      // Utils.showToast(LocaleKeys.sleepTimeInvalid.tr());
      return;
    }

    _timerAction = TimerAction.origin;

    /// seconds = 2 because delay
    final duration = Duration(hours: _hours, minutes: _min, seconds: 1);
    // _mainBloc.setSleepTime(duration);

    /// reset time
    _hours = 0;
    _min = 0;
  }

  @override
  void dispose() {
    // _subscription.cancel();
    super.dispose();
  }
}
