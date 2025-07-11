import 'package:flutter/material.dart';
import 'package:cool_ui/cool_ui.dart';
import 'package:flutter/services.dart';

/// 车牌号键盘输入类型
enum _LicencePlateKeyboardType {
  /// 省份输入（首位）
  province,

  /// 其他输入
  letterAndDigital,
}

class LicencePlateKeyboard extends StatelessWidget {
  static const CKTextInputType inputType =
      const CKTextInputType(name: "LicencePlateKeyboard");

  static double? bottomPadding;

  static double getHeight(BuildContext context) {
    if (bottomPadding == null) {
      bottomPadding = MediaQuery.of(context).padding.bottom;
    }
    return _buttonHeight * _rowLength +
        (bottomPadding ?? 0) +
        _completeButtonHeight;
  }

  /// MARK: 提供外部修改方法

  static List<String> get originProvinceList => _provinceList;

  static List<String> get originLetterAndDigitalList => _letterAndDigitalList;

  /// 更改数据源
  static void updateDataSource({
    List<String>? provinceList,
    List<String>? letterAndDigitalList,
  }) {
    inputProvinceList = provinceList;
    inputLetterAndDigitalList = letterAndDigitalList;
  }

  static List<String>? inputProvinceList;
  static List<String>? inputLetterAndDigitalList;

  /// 完成按钮样式配置
  static ButtonStyle? completeButtonStyle;

  static void updateCompleteButtonStyle({
    ButtonStyle? completeButtonStyle,
  }) {
    LicencePlateKeyboard.completeButtonStyle = completeButtonStyle;
  }

  final KeyboardController controller;

  LicencePlateKeyboard({
    required this.controller,
  });

  static register() {
    CoolKeyboard.addKeyboard(
      inputType,
      KeyboardConfig(
        builder: (
          BuildContext context,
          KeyboardController controller,
          String? param,
        ) {
          return LicencePlateKeyboard(
            controller: controller,
          );
        },
        getHeight: getHeight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LicencePlateKeyboardInput(
      controller: controller,
      type: controller.text.length < 1
          ? _LicencePlateKeyboardType.province
          : _LicencePlateKeyboardType.letterAndDigital,
      provinceList: inputProvinceList ?? _provinceList,
      letterAndDigitalList: inputLetterAndDigitalList ?? _letterAndDigitalList,
    );
  }
}

class LicencePlateKeyboardInput extends StatefulWidget {
  final KeyboardController controller;
  final _LicencePlateKeyboardType type;

  final List<String> provinceList;
  final List<String> letterAndDigitalList;

  const LicencePlateKeyboardInput({
    Key? key,
    required this.controller,
    required this.type,
    this.provinceList = _provinceList,
    this.letterAndDigitalList = _letterAndDigitalList,
  }) : super(key: key);

  @override
  _LicencePlateKeyboardInputState createState() =>
      _LicencePlateKeyboardInputState();
}

class _LicencePlateKeyboardInputState extends State<LicencePlateKeyboardInput> {
  _LicencePlateKeyboardType get type {
    return widget.controller.text.length < 1
        ? _LicencePlateKeyboardType.province
        : _LicencePlateKeyboardType.letterAndDigital;
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// 解决部分手机获取安全区不正确的问题，在构建的时候判断如果不等则重新赋值
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    if (LicencePlateKeyboard.bottomPadding != bottomPadding) {
      LicencePlateKeyboard.bottomPadding = bottomPadding;
    }
    return Material(
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.only(bottom: bottomPadding),
        height: LicencePlateKeyboard.getHeight(context),
        alignment: Alignment.bottomCenter,
        child: _buildKeyboard(),
      ),
    );
  }

  /// 是否为原始数据（原始数据对应特殊index需要跳过）
  bool get originData =>
      (type == _LicencePlateKeyboardType.province &&
          widget.provinceList == _provinceList) ||
      (type == _LicencePlateKeyboardType.letterAndDigital &&
          widget.letterAndDigitalList == _letterAndDigitalList);

  Widget _buildKeyboard() {
    /// 数据数组
    List<String> buttonTitleList = type == _LicencePlateKeyboardType.province
        ? widget.provinceList
        : widget.letterAndDigitalList;

    /// 控件数组
    List<Widget> buttonList = [];

    /// 配置控件数组（添加原始数据）
    for (String buttonTitle in buttonTitleList) {
      if (buttonTitle.isEmpty) {
        /// 空白按钮
        buttonList.add(
          Container(
            color: Color(0xFFF2F2F2),
            width: MediaQuery.of(context).size.width / 10.0,
            height: _buttonHeight,
          ),
        );
      } else {
        /// 其他按钮
        buttonList.add(
          Material(
            child: Container(
              child: Ink(
                color: Color(0xFFF2F2F2),
                width: MediaQuery.of(context).size.width / 10.0,
                height: _buttonHeight,
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () => _onButtonClick(buttonTitle),
                    child: Ink(
                      decoration: buttonTitle.length > 0
                          ? BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(
                                color: Color(0xFFE4E4E4),
                                width: 1.0,
                              ),
                            )
                          : null,
                      child: Center(
                        child: Text(
                          buttonTitle,
                          style: TextStyle(
                            fontSize: 17,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }

    /// 配置控件数组（添加删除按钮）
    buttonList.add(
      Material(
        child: Container(
          child: Ink(
            color: Color(0xFFF2F2F2),
            width: MediaQuery.of(context).size.width / 5.0,
            height: _buttonHeight,
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: InkWell(
                onTap: widget.controller.text.length > 0
                    ? () => _onDelete()
                    : null,
                onLongPress: widget.controller.text.length > 0
                    ? () => _onDeleteAll()
                    : null,
                child: Ink(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                      color: Color(0xFFE4E4E4),
                      width: 1.0,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.backspace,
                      color: widget.controller.text.length > 0
                          ? Color(0xFF333333)
                          : Color(0xFF999999),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    /// wrap 控件无法自动换行，手动改为 column-row 布局
    List<Widget> rows = [];
    for (int i = 0; i < _rowLength; i++) {
      List<Widget> rowChildren = [];
      for (int j = 0; j < _rowCount; j++) {
        /// ignore space button if originData
        if (originData && i == _spaceRowIndex && j > _spaceRowCountMax)
          continue;

        /// add every button of this row
        int index = i * 10 + j;

        /// fix out of range bug
        if (index < buttonList.length) {
          rowChildren.add(buttonList[index]);
        }
      }

      /// add row widget for rows
      rows.add(Row(children: rowChildren));
    }

    /// add complete button
    rows.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(
              height: _completeButtonHeight,
              width: MediaQuery.of(context).size.width,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                onPressed: hideKeyBoard,
                child: Text("完成"),
                style: LicencePlateKeyboard.completeButtonStyle ?? ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2483F9),
                  foregroundColor: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: rows,
      ),
    );
  }

  void _onButtonClick(String title) {
    HapticFeedback.mediumImpact();
    widget.controller.addText(title);
    setState(() {});
  }

  void _onDelete() {
    HapticFeedback.mediumImpact();
    widget.controller.deleteOne();
    setState(() {});
  }

  void _onDeleteAll() {
    HapticFeedback.vibrate();
    widget.controller.clear();
    setState(() {});
  }

  /// 全局收键盘
  void hideKeyBoard() {
    HapticFeedback.mediumImpact();
    widget.controller.doneAction();
  }
}

const double _buttonHeight = 48.0;

const double _completeButtonHeight = _buttonHeight - 16.0;

const int _rowLength = 5;

const int _rowCount = 10;

const int _spaceRowIndex = 4;
const int _spaceRowCountMax = 8;

const List<String> _provinceList = [
  '京',
  '津',
  '晋',
  '冀',
  '蒙',
  '辽',
  '吉',
  '黑',
  '沪',
  '苏',
  '浙',
  '皖',
  '闽',
  '赣',
  '鲁',
  '豫',
  '鄂',
  '湘',
  '粤',
  '桂',
  '琼',
  '渝',
  '川',
  '贵',
  '云',
  '藏',
  '陕',
  '甘',
  '青',
  '宁',
  '新',
  '使',
  '1',
  '2',
  '3',
  'W',
  'V',
  'K',
  'H',
  'B',
  'S',
  'L',
  'J',
  'N',
  'G',
  'C',
  'E',
  'Z',
];

const List<String> _letterAndDigitalList = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '0',
  'Q',
  'W',
  'E',
  'R',
  'T',
  'Y',
  'U',
  'I',
  'O',
  'P',
  'A',
  'S',
  'D',
  'F',
  'G',
  'H',
  'J',
  'K',
  'L',
  '',
  'Z',
  'X',
  'C',
  'V',
  'B',
  'N',
  'M',
  '港',
  '澳',
  '',
  '学',
  '警',
  '挂',
  '领',
  '试',
  '超',
  '练',
  '使',
];
