import 'package:rrms/_all.dart';

class Dot extends StatelessWidget {
  final bool isActive;
  final bool isEmpty;
  final Color? activeColor;
  final Color? inactiveColor;
  final double size;

  const Dot({
    super.key,
    this.isActive = true,
    this.isEmpty = false,
    this.activeColor,
    this.inactiveColor,
    this.size = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size),
        color: isActive && !isEmpty ? activeColor : inactiveColor,
        border: Border.all(color: (isActive ? activeColor : inactiveColor) ?? Colors.transparent, width: 2),
      ),
    );
  }
}
