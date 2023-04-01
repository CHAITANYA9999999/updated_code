import 'package:flutter/material.dart';
import 'package:punchmepartner/models/service_m.dart';
import 'package:punchmepartner/res/app_colors.dart';
import 'package:punchmepartner/res/app_styles.dart';
import 'package:punchmepartner/utils/currency.dart';
import 'package:punchmepartner/utils/size_config.dart';
import 'sizedbox.dart';
import 'text.dart';

class ServiceTile extends StatefulWidget {
  final ServiceM serviceM;

  const ServiceTile({super.key, required this.serviceM});

  @override
  _ServiceState createState() => _ServiceState();
}

class _ServiceState extends State<ServiceTile>
    with SingleTickerProviderStateMixin {
  bool isSelected = false;
  late AnimationController _controller;
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.25);
  late Animation<double> _iconTurns;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String offerInfo(ServiceM serviceM) {
    return '${serviceM.punch ? 'Punch' : 'Collect'} ${serviceM.doIt} ${serviceM.punch ? 'and get' : 'points and get'},\n${serviceM.getIt} for free ';
  }

  @override
  Widget build(BuildContext context) {
    animation = Tween(begin: -20.0, end: 40.0).animate(_controller);
    final serviceM = widget.serviceM;
    return Material(
      color: AppColors.black,
      child: InkWell(
        splashColor: AppColors.yellow.withOpacity(0.6),
        onTap: () {
          setState(() {
            isSelected = !isSelected;
            if (isSelected) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
          });
        },
        child: ClipRRect(
          child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              height:
                  isSelected ? SizeConfig.height * 30 : SizeConfig.height * 13,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.network(serviceM.images[0],
                              width: SizeConfig.width * 25)),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          JxText(
                            serviceM.name,
                            color: AppColors.yellow,
                            isBold: true,
                          ),
                          SizedBox(height: 2),
                          JxText(
                            offerInfo(serviceM),
                            maxLines: 2,
                            size: 3.8,
                          ),
                        ],
                      ),
                      Spacer(),
                      AnimatedOpacity(
                        opacity: isSelected ? 0.2 : 1.0,
                        duration: Duration(milliseconds: 800),
                        child: RotationTransition(
                          turns: _iconTurns,
                          //angle: isSelected ? math.pi / 2 : -math.pi / 120,
                          child: Icon(
                            Icons.navigate_next,
                            color: AppColors.yellow,
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      JxSizedBox(
                        height: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(3, 12, 0, 0),
                        child: JxText(
                          serviceM.description,
                          maxLines: 5,
                          size: 4,
                        ),
                      ),
                      JxSizedBox(),
                      Row(
                        children: [
                          Expanded(child: PriceBox(serviceM)),
                          Expanded(
                              child: DoItBox(
                            serviceM.doIt,
                          )),
                          Expanded(child: GetItBox(serviceM)),
                        ],
                      )
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}

class PriceBox extends StatelessWidget {
  PriceBox(this.serviceM);
  final ServiceM serviceM;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: AppStyles.minimalBorderRadius,
          border: Border.all(width: 1, color: AppColors.yellow)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          JxText(
            'Price:',
            maxLines: 5,
            size: 3.5,
          ),
          JxText(
            getCurrency(serviceM.price),
            maxLines: 5,
            size: 7,
            isBold: true,
            color: AppColors.yellow,
          ),
        ],
      ),
    );
  }
}

class DoItBox extends StatelessWidget {
  DoItBox(this.doIt);
  final int doIt;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.yellow.withOpacity(0.15),
        borderRadius: AppStyles.minimalBorderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          JxText(
            'Scan:',
            maxLines: 5,
            size: 3.5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              JxText(
                doIt.toString(),
                maxLines: 5,
                size: 7.5,
                isBold: true,
                color: AppColors.yellow,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, bottom: 3),
                child: JxText(
                  'times',
                  size: 3,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class GetItBox extends StatelessWidget {
  GetItBox(this.serviceM);
  final ServiceM serviceM;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.yellow.withOpacity(0.15),
        borderRadius: AppStyles.minimalBorderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          JxText(
            'And get:',
            maxLines: 5,
            size: 3.5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              JxText(
                serviceM.getIt.toString(),
                maxLines: 5,
                size: 7.5,
                isBold: true,
                color: AppColors.yellow,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, bottom: 3),
                child: JxText(
                  serviceM.punch ? 'times' : 'points',
                  size: 3,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
