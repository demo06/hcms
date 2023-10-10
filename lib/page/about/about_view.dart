import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'about_logic.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({Key? key}) : super(key: key);

  @override
  State<AboutMePage> createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  final logic = Get.put(AboutLogic());
  final state = Get.find<AboutLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutLogic>(
      assignId: true,
      builder: (logic) {
        return Container(
          child: const Padding(
            padding: EdgeInsets.only(top: 60.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 100,
                            backgroundImage: AssetImage('assets/images/author.jpg'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 12.0),
                          child: Text(
                            "WenBin",
                            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 26),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12.0),
                          child: Text(
                            "高级软件开发工程师",
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12.0),
                          child: Expanded(
                            child: Text("微信:demo06", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12.0),
                          child: Expanded(
                              child: Text("邮箱:wenbin@buildapp.fun",
                                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24))),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12.0),
                          child: Expanded(
                              child:
                                  Text("手机号:15639700383", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24))),
                        ),
                      ],
                    ))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 80.0),
                  child: Text(
                    '''
专注于创造出色的数字体验。
为您带来强大、创新和高度定制化的软件解决方案。
我们的软件开发服务不仅仅是编写代码，
更是与您合作，理解您的业务需求，并将其转化为高效、可靠的应用程序。
无论您是初创企业还是大型企业，我们都能够为您提供卓越的软件开发服务。
让我们一起合作，将您的创意变成现实，实现业务的成功和增长。
联系我们，让我们开始共同打造卓越的软件解决方案！
                    ''',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, letterSpacing: 3, height: 2),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    Get.delete<AboutLogic>();
    super.dispose();
  }
}
