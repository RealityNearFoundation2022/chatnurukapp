import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/core/framework/globals.dart';
import 'package:reality_near/presentation/bloc/menu/menu_bloc.dart';
import 'package:reality_near/presentation/views/AR/arview.dart';
import 'package:reality_near/presentation/views/noAR/noARSection.dart';
import 'package:reality_near/presentation/views/mapScreen/mapScreen.dart';
import 'package:reality_near/presentation/views/menuScreen/menuScreen.dart';
import 'package:showcaseview/showcaseview.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool status = false;
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  final GlobalKey _three = GlobalKey();
  bool passInitGuide;

  _viewGuide() async {
    (await getPersistData('passInitGuide') == null &&
            await getPersistData('userToken') != null)
        ? WidgetsBinding.instance.addPostFrameCallback(
            (_) =>
                ShowCaseWidget.of(context).startShowCase([_one, _two, _three]),
          )
        : null;
  }

  @override
  void initState() {
    super.initState();
    _viewGuide();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(builder: ((context, state) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: Stack(
            children: [
              state is MenuArState
                  ? const ARSection()
                  : Container(
                      margin: EdgeInsets.only(
                          bottom: 20, top: ScreenWH(context).height * 0.17),
                      height: ScreenWH(context).height * 0.95,
                      width: ScreenWH(context).width,
                      child: const NoArSection(),
                    ),
              // ListView(
              //   children: [
              //     //Header
              //     header(),
              //     state is MenuArState
              //         ? const ARSection()
              //         : Container(
              //       margin: const EdgeInsets.only(bottom: 20),
              //       height: ScreenWH(context).height * 0.95,
              //       width: ScreenWH(context).width,
              //       child:  const NoArSection(),
              //     ),
              //   ],
              // ),
              //Footer
              //MapBTN

              header(),

              Align(
                  alignment: Alignment.bottomLeft,
                  child: MapContainer(
                    showCaseKey: _two,
                  )),
              //MenuBTN
              Align(
                  alignment: Alignment.bottomRight,
                  child: MenuContainer(
                    showCaseKey: _one,
                  )),
            ],
          ),
        ),
      );
    }));
  }

  Widget header() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      width: double.infinity,
      child: Column(
        children: [
          Image.asset(
            "assets/imgs/Logo_sin_fondo.png",
            width: ScreenWH(context).width * 0.5,
            height: ScreenWH(context).height * 0.15,
          ),
          Container(
            width: ScreenWH(context).width * 0.8,
            alignment: Alignment.centerRight,
            child: Showcase(
              key: _three,
              overlayPadding: const EdgeInsets.all(12),
              radius: BorderRadius.circular(100),
              contentPadding: const EdgeInsets.all(15),
              title: 'AR Switch',
              description:
                  "Tap to see profile which contains user's name, profile picture, mobile number and country",
              showcaseBackgroundColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
              titleTextStyle: GoogleFonts.sourceSansPro(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              descTextStyle: GoogleFonts.sourceSansPro(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              shapeBorder: const CircleBorder(),
              child: CupertinoSwitch(
                activeColor: greenPrimary,
                value: status,
                onChanged: (value) {
                  setState(() {
                    status = value;
                    BlocProvider.of<MenuBloc>(context, listen: false)
                        .add(MenuOpenArViewEvent());
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
