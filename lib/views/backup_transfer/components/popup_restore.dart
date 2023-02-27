import 'package:base_project/helper/const.dart';
import 'package:base_project/styles/styles.dart';
import 'package:flutter/cupertino.dart';

class PopupRestore extends StatelessWidget {
  // final Function? onOverwrite;
  // final Function? onMerge;
  const PopupRestore({super.key, 
    // this.onOverwrite,
    // this.onMerge,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(
        'How would you like to import this backup?',
        style: AppStyles.copyStyle(
          color: Const.colorBgProgress,
        ),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          onPressed: () async {
            Navigator.of(context).pop(0);
            // onOverwrite();
          },
          child: Text(
            'Overwrite Library With Backup',
            style: AppStyles.copyStyle(color: Const.colorPrimary, fontSize: 18),
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () async {
            Navigator.of(context).pop(1);
            // onMerge();
          },
          child: Text(
            'Merge Backup Into Library',
            style: AppStyles.copyStyle(color: Const.colorPrimary, fontSize: 18),
          ),
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(
          'Cancel',
          style: AppStyles.copyStyle(
            color: Const.colorOrange,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
