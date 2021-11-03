import 'package:flutter/material.dart';
import 'package:recycle_hub/style/theme.dart';

class Style {
  const Style();

  static const Color mainColor = const Color(0xFFFFFFFF);
  static const Color secondColor = const Color(0xFFedf5da);
  static const Color grey = const Color(0xFFc2c2c2);
  static const Color background = const Color(0xFFf0f1f6);
  static const Color titleColor = const Color(0xFF001629);
  static const Color standardTextColor = const Color(0xFF00d08c);
  // static const primaryGradient = const LinearGradient(
  //   colors: const [Color(0xFF111428), Color(0xFF29304a)],
  //   stops: const [0.0, 1.0],
  //   begin: Alignment.centerLeft,
  //   end: Alignment.centerRight,
  // );
}

final kHintTextStyle = TextStyle(
  color: Color(0xFFc5c8cf),
  fontFamily: 'GilroyMedium',
);

final kLabelStyle = TextStyle(
  color: Style.titleColor,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFFF7F7F7),
  borderRadius: BorderRadius.circular(kBorderRadius),
  boxShadow: [
    BoxShadow(
      color: kColorWhite,
      blurRadius: 0,
      offset: Offset(0, 1),
    ),
  ],
);

final kOfferPointScreenInputDecor = BoxDecoration(
  color: kColorWhite,
  borderRadius: BorderRadius.circular(kBorderRadius),
  border: Border.all(width: 2, color: Color(0xFFECECEC)),
);

final kListItemBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(25.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final kAppBarTextStyle = TextStyle(
  color: Style.titleColor,
  fontWeight: FontWeight.normal,
  fontSize: 18,
  fontFamily: 'OpenSans',
);
final kAppBarDisableTextStyle = TextStyle(
  color: Style.standardTextColor,
  fontWeight: FontWeight.normal,
  fontSize: 15,
  fontFamily: 'OpenSans',
);
final kAppBarEnableTextStyle = TextStyle(
  color: Style.titleColor,
  fontWeight: FontWeight.normal,
  fontSize: 15,
  fontFamily: 'OpenSans',
);

final kDataTextStyle = TextStyle(
  color: Style.standardTextColor,
  //
  fontSize: 18,
  fontFamily: 'OpenSans',
);

final kExitStyleText = TextStyle(
  color: Colors.red,
  fontSize: 16,
  fontFamily: 'OpenSans',
);

final kSpanTextStyle = TextStyle(
  color: Style.titleColor,
  fontSize: 12,
  fontFamily: 'OpenSans',
);
final kServiceMenuItemTextStyle = TextStyle(
  color: Style.titleColor,
  fontSize: 12,
  fontFamily: 'OpenSans',
);

final kBoxImageBackgroundStyle = BoxDecoration(
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final kLeftButtonBottomRadius = BorderRadius.only(topLeft: Radius.circular(10));
final kRightButtonBottomRadius =
    BorderRadius.only(topRight: Radius.circular(10));

final kEcoCoinString =
    "Тут вы можете выполнять задания и получать внутреннюю валюту для последующего обмена на услуги и товары партнеров в магазине";
