part of flutter_widgetz;

/// {@template flutter_widgetz.DurationField}
/// Wraps a call to [showDialog]->[DurationPicker]
/// in an [InputDecorator] and [InkWell].
/// {@endtemplate}
class DurationField extends StatefulWidget {
  /// {@macro flutter_widgetz.DurationField}
  const DurationField({
    super.key,
    this.acceptText = 'Accept',
    this.cancelText = 'Cancel',
    this.displayStringForDuration = _defaultStringForDuration,
    this.labelText = 'Duration',
    this.onChanged,
    this.prefixIcon = Icons.timelapse,
    this.snapToMins,
    this.unit,
    this.value,
  });

  /// The text used in the accept button.
  final String acceptText;

  /// The text used in the cancel button.
  final String cancelText;

  /// The string that is displayed in the input.
  final String Function(Duration?) displayStringForDuration;

  /// Optional text that describes the input field.
  final String labelText;

  /// Called whenever the value changes.
  final ValueChanged<Duration>? onChanged;

  /// An icon that appears before the editable part of the text field.
  final IconData prefixIcon;

  /// The resolution of mins of the dial,
  /// i.e. if snapToMins = 5,
  /// only durations of 5min intervals will be selectable.
  final int? snapToMins;

  /// The unit for the picker.
  final DurationPickerUnit? unit;

  /// The value of this input.
  final Duration? value;

  static String _defaultStringForDuration(Duration? duration) {
    return duration?.toString() ?? '';
  }

  @override
  State<DurationField> createState() => _DurationFieldState();
}

class _DurationFieldState extends State<DurationField> {
  Duration? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showModal(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.labelText,
          prefixIcon: Icon(widget.prefixIcon),
        ),
        child: Text(
          widget.displayStringForDuration(_value),
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }

  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
              onPressed: _onCancel,
              child: Text(widget.cancelText),
            ),
            TextButton(
              onPressed: _onAccept,
              child: Text(widget.acceptText),
            ),
          ],
          content: DurationPicker(
            onChanged: _onChanged,
            unit: widget.unit,
            duration: _value,
            snapToMins: widget.snapToMins,
          ),
        );
      },
    );
  }

  // ignore: use_setters_to_change_properties
  void _onChanged(Duration duration) {
    _value = duration;
  }

  void _onAccept() {
    final Duration value = _value ?? Duration.zero;
    setState(() {
      _value = value;
    });
    widget.onChanged?.call(value);
    Navigator.of(context).pop();
  }

  void _onCancel() {
    setState(() {
      _value = widget.value;
    });
    Navigator.of(context).pop();
  }
}
