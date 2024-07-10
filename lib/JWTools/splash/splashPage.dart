part of JWTools;

typedef void goMainBlock(BuildContext context);

class SplashPage extends StatefulWidget {
  List<String> imgs = List<String>.generate(0, (index) => "");
  goMainBlock? goMain;

  SplashPage({required this.imgs, this.goMain, Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    _initBanner();
  }

  final List<Widget> _bannerList =
      List<Widget>.generate(0, (index) => const Text(""));

  TimerUtil? _timerUtil;

  void _initBanner() {
    List<String> arrs = widget.imgs;
    print("banner init ${widget.imgs}");
    for (var i = 0; i < widget.imgs.length; i++) {
      String imgStr = widget.imgs[i];
      if (i == widget.imgs.length - 1) {
        _bannerList.add(Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              imgStr,
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 100),
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
                child: TextButton(
                  onPressed: () {
                    // couBtn.endTimer();
                    widget.goMain?.call(context);
                  },
                  child: Text(
                    "立即体验",
                    style:
                        WBFontStyle.copyWith(color: Colors.white, fontSize: 13),
                  ),
                ),
              ),
            ),
          ],
        ));
      } else {
        _bannerList.add(Image.asset(
          imgStr,
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ));
      }
    }
    print("arr---$_bannerList");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Swiper(
        itemCount: _bannerList.length,
        autoplay: false,
        loop: false,
        pagination: SwiperPagination(
            builder: RectSwiperPaginationBuilder(
                color: textColor,
                activeColor: themeColor,
                size: const Size(12, 4),
                activeSize: const Size(18, 4))),
        itemBuilder: (context, index) => _bannerList[index],
        onIndexChanged: (index) {
          if (index == _bannerList.length - 1) {}
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timerUtil?.cancel();
    super.dispose();
  }
}
