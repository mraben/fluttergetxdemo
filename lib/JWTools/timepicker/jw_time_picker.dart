part of JWTools;

enum JWTimePickerMode { monthYear, dayMonthYear, time,dateAndTime, area }
typedef myBlock = Function(DateTime yearStr);

class JWTimePicker extends StatefulWidget {
  final JWTimePickerMode type;
  myBlock? block;
  DateTime? inputTime = DateTime.now();
  JWTimePicker({Key? key, this.type = JWTimePickerMode.time, this.block,this.inputTime})
      : super(key: key);

  var yeardistance = DateTime.now().year - 1969;
  @override
  _JWTimePickerState createState() => _JWTimePickerState();

  static void showYearMonthPicker(BuildContext context, JWTimePickerMode type,
      {Function(DateTime yearStr)? myfunc,DateTime? inputTime}) {
    showBottomSheetWindow(
        context: context,
        emptyDismissable: true,
        windowBuilder: (BuildContext con, Animation<double> animation,
            Animation<double> secondrayAnimation) {
          var tween = Tween(begin: const Offset(0, 1), end: const Offset(0, 0));
          return SlideTransition(
              position: animation.drive(tween),
              child: JWTimePicker(
                type: type,
                block: myfunc,
                inputTime: inputTime,
              ));
        });
  }
}

class _JWTimePickerState extends State<JWTimePicker> {
  ///年月选择器
  late FixedExtentScrollController yearController;
  late FixedExtentScrollController monthController;

  ///选择的时间
  DateTime _selTimeStr = DateTime.now();
  @override
  void initState() {
    super.initState();
    yearController =
        FixedExtentScrollController(initialItem: widget.yeardistance);
    var month = DateTime.now().month - 1;
    monthController = FixedExtentScrollController(initialItem: month);
    if (widget.inputTime != null) {
      _selTimeStr = widget.inputTime!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: Colors.white),
      child: Column(
        children: [
          _bottomBtns(),
          _getPicker(),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  Widget _getPicker() {
    switch (widget.type) {
      case JWTimePickerMode.monthYear:
        {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(0),
                height: 210,
                child: CupertinoPicker.builder(
                  itemExtent: 44,
                  useMagnifier: true,
                  magnification: 1.2,
                  offAxisFraction: -0.5,
                  scrollController: yearController,
                  onSelectedItemChanged: (position) {
                    print("${widget.type}选中的position$position");
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Text("${index + 1970}年");
                  },
                  childCount: widget.yeardistance,
                  selectionOverlay: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: textColor2, width: 0.5),
                          bottom: BorderSide(color: textColor2, width: 0.5)),
                    ),
                  ),
                ),
              )),
              Expanded(
                  child: Container(
                height: 210,
                child: CupertinoPicker.builder(
                  itemExtent: 44,
                  useMagnifier: true,
                  magnification: 1.2,
                  offAxisFraction: 0.5,
                  scrollController: monthController,
                  onSelectedItemChanged: (position) {
                    print("${widget.type}月份 选中的position$position");
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Text("${index + 1}月");
                  },
                  childCount: 12,
                  selectionOverlay: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: textColor2, width: 0.5),
                          bottom: BorderSide(color: textColor2, width: 0.5)),
                    ),
                  ),
                ),
              ))
            ],
          );
        }
      case JWTimePickerMode.dayMonthYear:
        return Container(
          height: 210,
          child: CupertinoDatePicker(
            onDateTimeChanged: (dateTime) {
              _selTimeStr = dateTime;
            },
            mode: CupertinoDatePickerMode.date,
            initialDateTime: widget.inputTime,
          ),
        );

      case JWTimePickerMode.time:
        return Container(
          height: 210,
          child: CupertinoDatePicker(
            onDateTimeChanged: (dateTime) {
              _selTimeStr = dateTime;
            },
            mode: CupertinoDatePickerMode.time,
            use24hFormat: true,
            initialDateTime: widget.inputTime,
          ),
        );
        case JWTimePickerMode.dateAndTime:
          return Container(
            height: 210,
            child: CupertinoDatePicker(
              onDateTimeChanged: (dateTime) {
                _selTimeStr = dateTime;
              },
              mode: CupertinoDatePickerMode.dateAndTime,

              initialDateTime: widget.inputTime,
            ),
          );
      case JWTimePickerMode.area:
        // TODO: Handle this case.
        break;
    }
    return const Text("未知类型");
  }

  Widget _bottomBtns() {
    // var width = (MediaQuery.of(context).size.width-15*3)/2;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 40,

          child: TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(0)),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "取消",
              style: WBFontStyle.copyWith(
                  fontSize: 16, color: themeColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 60,
          height: 40,


          child: TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
            ),
            onPressed: () {
              if (widget.type == JWTimePickerMode.monthYear) {
                print("年份：${yearController.selectedItem + 1970}---月份：${monthController.selectedItem + 1}");
                widget.block?.call(DateTime(yearController.selectedItem + 1970,
                    monthController.selectedItem + 1));
              } else if (widget.type == JWTimePickerMode.dayMonthYear) {
                widget.block?.call(_selTimeStr);
              }else if (widget.type == JWTimePickerMode.time || widget.type
              == JWTimePickerMode.dateAndTime) {
                widget.block?.call(_selTimeStr);
              }

              Navigator.pop(context);
            },
            child: Text(
              "确定",
              style: WBFontStyle.copyWith(
                  fontSize: 16,
                  color: themeColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
