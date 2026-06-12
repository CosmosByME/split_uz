import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

class RecentSplits extends StatelessWidget {
  const RecentSplits({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Mening taqsimlarim',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            GlassButton.custom(
              shape: LiquidRoundedRectangle(borderRadius: 16),
              onTap: () {},
              child: Text('Hammasini ko\'rish', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
        SizedBox(height: 16),
        SplitContainer(
          icon: CupertinoIcons.person,
          title: 'Ali',
          date: '12 sentyabr 2024',
          amount: '50,000 UZS',
          type: SplitType.done,
        ),
        SizedBox(height: 12),
        SplitContainer(
          icon: CupertinoIcons.person,
          title: 'Vali',
          date: '15 sentyabr 2024',
          amount: '70,000 UZS',
          type: SplitType.pending,
        ),
      ],
    );
  }
}

enum SplitType { done, pending }

class SplitContainer extends StatelessWidget {
  final IconData icon;
  final String title;
  final String date;
  final String amount;
  final SplitType type;
  const SplitContainer({
    super.key,
    required this.icon,
    required this.title,
    required this.date,
    required this.amount,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      quality: GlassQuality.premium,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: CupertinoListTile(
        leading: GlassContainer(
          alignment: Alignment.center,
          height: 48,
          width: 48,
          quality: GlassQuality.minimal,
          child: Icon(icon, size: 32),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          date,
          style: TextStyle(fontSize: 14, color: CupertinoColors.systemGrey),
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              amount,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            GlassContainer(
              quality: GlassQuality.minimal,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              settings: LiquidGlassSettings(
                glassColor: type == SplitType.done
                    ? CupertinoColors.systemGreen
                    : CupertinoColors.systemYellow,
              ),
              child: Text(
                type == SplitType.done ? 'Tugallangan' : 'Kutilmoqda',
                style: TextStyle(fontSize: 12, color: CupertinoColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
