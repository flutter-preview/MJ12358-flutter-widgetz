part of flutter_widgetz;

/// {@template flutter_widgetz.CustomBottomNavigationBar}
/// A wrapper for [BottomNavigationBar] that
/// handles the `currentIndex` for you.
/// {@endtemplate}
class CustomBottomNavigationBar extends StatefulWidget {
  /// {@macro flutter_widgetz.CustomBottomNavigationBar}
  const CustomBottomNavigationBar({
    super.key,
    required this.items,
    required this.onTap,
    this.backgroundColor,
    this.elevation,
    this.type = BottomNavigationBarType.fixed,
  });

  /// Defines the appearance of the button items
  /// that are arrayed within the bottom navigation bar.
  final List<BottomNavigationBarItem> items;

  /// Called when one of the [items] is tapped.
  final ValueChanged<int> onTap;

  /// The color of the [BottomNavigationBar] itself.
  final Color? backgroundColor;

  /// The z-coordinate of this [BottomNavigationBar].
  final double? elevation;

  /// Defines the layout and behavior of a [BottomNavigationBar].
  final BottomNavigationBarType type;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: widget.backgroundColor,
      currentIndex: _currentIndex,
      elevation: widget.elevation,
      items: widget.items,
      onTap: _onTap,
      type: widget.type,
    );
  }

  void _onTap(int value) {
    setState(() {
      _currentIndex = value;
    });
    widget.onTap(value);
  }
}
