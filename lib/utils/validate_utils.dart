/*
 * zhijian-flutter版
 * (c) 2021 - 2022 @尚真
 * www.wodecun.com
 */

class ValidateUtils {
  ValidateUtils._();

  ///手机号
  static bool isPhone(String input) {
    RegExp exp =
        RegExp(r'^((13\d)|(14\d)|(15\d)|(16\d)|(17\d)|(18\d)|(19\d))\d{8}$');
    return exp.hasMatch(input);
  }

  //6-16数字字母符号
  static bool isLoginPassword(String input) {
    RegExp mobile = RegExp(r"[\dA-Za-z-*/+.~!@#$%^&()]{6,16}$");
    return mobile.hasMatch(input);
  }

  //6位数字验证码
  static bool isValidateCaptcha(String input) {
    RegExp mobile = RegExp(r"\d{6}$");
    return mobile.hasMatch(input);
  }

  //身份证
  static bool isCardId(String cardId) {
    if (cardId.length != 18) {
      return false; // 位数不够
    }
    // 身份证号码正则
    RegExp postalCode = RegExp(
        r'^\d{6}(18|19|20)?\d{2}(0[1-9]|1[12])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$');
    // 通过验证，说明格式正确，但仍需计算准确性
    if (!postalCode.hasMatch(cardId)) {
      return false;
    }
    //将前17位加权因子保存在数组里
    final List idCardList = [
      "7",
      "9",
      "10",
      "5",
      "8",
      "4",
      "2",
      "1",
      "6",
      "3",
      "7",
      "9",
      "10",
      "5",
      "8",
      "4",
      "2"
    ];
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    final List idCardYArray = [
      '1',
      '0',
      '10',
      '9',
      '8',
      '7',
      '6',
      '5',
      '4',
      '3',
      '2'
    ];
    // 前17位各自乖以加权因子后的总和
    int idCardWiSum = 0;

    for (int i = 0; i < 17; i++) {
      int subStrIndex = int.parse(cardId.substring(i, i + 1));
      int idCardWiIndex = int.parse(idCardList[i]);
      idCardWiSum += subStrIndex * idCardWiIndex;
    }
    // 计算出校验码所在数组的位置
    int idCardMod = idCardWiSum % 11;
    // 得到最后一位号码
    String idCardLast = cardId.substring(17, 18);
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if (idCardMod == 2) {
      if (idCardLast != 'x' && idCardLast != 'X') {
        return false;
      }
    } else {
      //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
      if (idCardLast != idCardYArray[idCardMod]) {
        return false;
      }
    }
    return true;
  }
}
