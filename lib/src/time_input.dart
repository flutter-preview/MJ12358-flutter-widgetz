part of flutter_widgetz;

/// {@template flutter_widgetz.TimeInput}
/// Wraps a call to [showTimePicker] in
/// an [InputDecorator] and [InkWell].
/// {@endtemplate}
class TimeInput extends StatefulWidget {
  /// {@macro flutter_widgetz.TimeInput}
  const TimeInput({
    super.key,
    required this.onChanged,
    this.displayStringForTime = _defaultStringForTime,
    this.errorText,
    this.labelText,
    this.prefixIcon = Icons.timelapse,
    this.showError = false,
    this.value,
  });

  /// Called whenever the value changes.
  final ValueChanged<TimeOfDay> onChanged;

  /// The string that is displayed in the input.
  final String Function(TimeOfDay?) displayStringForTime;

  /// The text shown when there is an error.
  final String? errorText;

  /// Optional text that describes the input field.
  final String? labelText;

  /// An icon that appears before the editable part of the text field.
  final IconData prefixIcon;

  /// Determines if a error should be shown.
  final bool showError;

  /// The value of this input.
  final TimeOfDay? value;

  static String _defaultStringForTime(TimeOfDay? time) {
    return time?.toString() ?? '';
  }

  @override
  State<TimeInput> createState() => _TimeInputState();
}

class _TimeInputState extends State<TimeInput> {
  TimeOfDay? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showTimePicker(context),
      child: InputDecorator(
        decoration: InputDecoration(
          errorText: widget.showError ? widget.errorText : null,
          labelText: widget.labelText,
          prefixIcon: Icon(widget.prefixIcon),
        ),
        child: Text(
          widget.displayStringForTime(_value),
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }

  void _showTimePicker(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: _value ?? TimeOfDay.now(),
    ).then(_onChange);
  }

  void _onChange(TimeOfDay? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _value = value;
    });
    widget.onChanged(value);
  }
}
