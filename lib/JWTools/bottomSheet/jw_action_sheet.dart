
part of JWTools;
class JWActionSheet extends StatelessWidget {
  String? title;
  List<String> data;
  ValueChanged<int>? callBack;
  JWActionSheet({Key? key,required this.data,this.title,this.callBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color.fromRGBO(114, 114, 114, 1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //为了防止控件溢出
            Flexible(
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.all(Radius.circular(14)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      title?.isNotEmpty == true ?
                      new Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: new Text(
                          title ?? "",
                          textAlign: TextAlign.center,
                        ),
                      ) : Container(),

                      Flexible(
                          child: ListView.builder(
                            /**
                                If you do not set the shrinkWrap property, your ListView will be as big as its parent.
                                If you set it to true, the list will wrap its content and be as big as it children allows it to be. */
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: <Widget>[
                                  new ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                      callBack?.call(index);

                                    },

                                    title: new Text(
                                      data[index],
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  index == data.length - 1
                                      ? Container()
                                      : Divider(
                                    height: 1,
                                    color: Color(0xFFf0f0f0),
                                  ),
                                ],
                              );
                            },
                          )),

                    ],
                  ),
                )),
            SizedBox(
              height: 9,
            ),
            GestureDetector(
              child: Container(
                height: 56,
                width: double.infinity,
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(Radius.circular(14)),
                ),
                child: Text("取消",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 17.0,
                    )),
              ),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );

  }
}
showCustomActionSheet(BuildContext context,String? title,List<String> data,ValueChanged<int> clickRow) {

showModalBottomSheet(context: context,builder: (context){
  return JWActionSheet(data: data,title: title,callBack: clickRow,);
});


}
