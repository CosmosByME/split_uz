import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

class OwingStatus extends StatelessWidget {
  const OwingStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      quality: GlassQuality.premium,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 6,
                child: Text(
                  'Siz to\'lashingiz kerak',
                  style: TextStyle(
                    fontSize: 22,
                    color: CupertinoColors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(flex: 1, child: SizedBox()),
              Expanded(
                flex: 3,
                child: Text(
                  '120,000 UZS',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Divider(color: CupertinoColors.systemGrey4),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 6,
                child: Text(
                  'Sizga to\'lashadi',
                  style: TextStyle(
                    fontSize: 22,
                    color: CupertinoColors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(flex: 1, child: SizedBox()),
              Expanded(
                flex: 3,
                child: Text(
                  '220,000 UZS',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
