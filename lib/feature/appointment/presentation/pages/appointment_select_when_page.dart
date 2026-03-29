import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentWhenSelectionResult {
  final String dateLabel;
  final String timeLabel;

  const AppointmentWhenSelectionResult({
    required this.dateLabel,
    required this.timeLabel,
  });
}

class AppointmentSelectWhenPage extends StatefulWidget {
  final String initialDateLabel;
  final String initialTimeLabel;

  const AppointmentSelectWhenPage({
    super.key,
    required this.initialDateLabel,
    required this.initialTimeLabel,
  });

  @override
  State<AppointmentSelectWhenPage> createState() =>
      _AppointmentSelectWhenPageState();
}

class _AppointmentSelectWhenPageState extends State<AppointmentSelectWhenPage> {
  late DateTime _selectedDate;
  late DateTime _displayedMonth;
  int _selectedHour = 19;
  int _selectedMinute = 0;

  @override
  void initState() {
    super.initState();
    _selectedDate =
        _parseInitialDate(widget.initialDateLabel) ?? DateTime(2026, 3, 7);
    _displayedMonth = DateTime(_selectedDate.year, _selectedDate.month);
    _selectedHour = _parseSelectedHour(widget.initialTimeLabel) ?? _selectedHour;
    _selectedMinute =
        _parseSelectedMinute(widget.initialTimeLabel) ?? _selectedMinute;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: <Widget>[
                  _TopBackButton(onTap: () => Navigator.of(context).pop()),
                  Expanded(
                    child: Text(
                      'Select When',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2D2D2D),
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              _MonthArrowButton(
                                icon: Icons.chevron_left_rounded,
                                onTap: () => _changeMonth(-1),
                              ),
                              Expanded(
                                child: Text(
                                  _formatMonthYear(_displayedMonth),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF2D2D2D),
                                  ),
                                ),
                              ),
                              _MonthArrowButton(
                                icon: Icons.chevron_right_rounded,
                                onTap: () => _changeMonth(1),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:
                                const <String>['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']
                                    .map(
                                      (day) => SizedBox(
                                        width: 36,
                                        child: Text(
                                          day,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF9E8F8A),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(growable: false),
                          ),
                          const SizedBox(height: 12),
                          ..._buildCalendarRows(_displayedMonth).map(_buildCalendarRow),
                          const SizedBox(height: 22),
                          const Divider(color: Color(0xFFF2EAE6)),
                          const SizedBox(height: 28),
                          Text(
                            'Select Time',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF2D2D2D),
                            ),
                          ),
                          const SizedBox(height: 22),
                          _TimeSelector(
                            selectedHour: _selectedHour,
                            selectedMinute: _selectedMinute,
                            onHourChanged: (value) =>
                                setState(() => _selectedHour = value),
                            onMinuteChanged: (value) =>
                                setState(() => _selectedMinute = value),
                          ),
                          const SizedBox(height: 28),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: _SaveButton(
                label: 'Save Selection',
                onTap: () {
                  Navigator.of(context).pop(
                    AppointmentWhenSelectionResult(
                      dateLabel: _formatSelectedDate(_selectedDate),
                      timeLabel:
                          '${_selectedHour.toString().padLeft(2, '0')}:${_selectedMinute.toString().padLeft(2, '0')}',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarRow(List<DateTime> values) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: values.map((date) {
          final bool isCurrentMonth =
              date.month == _displayedMonth.month &&
              date.year == _displayedMonth.year;
          final bool isSelected = _isSameDate(date, _selectedDate);

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = date;
                _displayedMonth = DateTime(date.year, date.month);
              });
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFF6B5A) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '${date.day}',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? Colors.white
                      : (isCurrentMonth
                          ? const Color(0xFF2D2D2D)
                          : const Color(0xFFD4C9C3)),
                ),
              ),
            ),
          );
        }).toList(growable: false),
      ),
    );
  }

  List<List<DateTime>> _buildCalendarRows(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final startOffset = firstDayOfMonth.weekday % 7;
    final startDate = firstDayOfMonth.subtract(Duration(days: startOffset));

    final dates = List<DateTime>.generate(
      42,
      (index) => DateTime(
        startDate.year,
        startDate.month,
        startDate.day + index,
      ),
      growable: false,
    );

    return List<List<DateTime>>.generate(
      6,
      (weekIndex) => dates.sublist(weekIndex * 7, (weekIndex + 1) * 7),
      growable: false,
    );
  }

  void _changeMonth(int delta) {
    setState(() {
      _displayedMonth =
          DateTime(_displayedMonth.year, _displayedMonth.month + delta);
    });
  }

  DateTime? _parseInitialDate(String value) {
    final cleaned = value.trim();
    final match = RegExp(
      r'^(?:[A-Za-z]{3},\s*)?([A-Za-z]{3})\s+(\d{1,2})(?:,\s*(\d{4}))?$',
    ).firstMatch(cleaned);
    if (match == null) return null;

    final month = _monthIndex(match.group(1)!);
    final day = int.tryParse(match.group(2)!);
    final year = int.tryParse(match.group(3) ?? '') ?? 2026;
    if (month == null || day == null) return null;

    return DateTime(year, month, day);
  }

  int? _parseSelectedHour(String value) {
    final parts = value.split(':');
    if (parts.length != 2) return null;
    return int.tryParse(parts.first);
  }

  int? _parseSelectedMinute(String value) {
    final parts = value.split(':');
    if (parts.length != 2) return null;
    return int.tryParse(parts.last);
  }

  int? _monthIndex(String value) {
    const months = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final index = months.indexOf(value);
    return index == -1 ? null : index + 1;
  }

  String _formatMonthYear(DateTime value) {
    const months = <String>[
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${months[value.month - 1]} ${value.year}';
  }

  String _formatSelectedDate(DateTime value) {
    const weekdays = <String>[
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];
    const months = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${weekdays[value.weekday - 1]}, ${months[value.month - 1]} ${value.day}, ${value.year}';
  }

  bool _isSameDate(DateTime left, DateTime right) {
    return left.year == right.year &&
        left.month == right.month &&
        left.day == right.day;
  }
}

class _TopBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const _TopBackButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: const SizedBox(
        width: 40,
        height: 40,
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 22,
          color: Color(0xFF2D2D2D),
        ),
      ),
    );
  }
}

class _MonthArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _MonthArrowButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: SizedBox(
        width: 36,
        height: 36,
        child: Icon(icon, color: const Color(0xFF8A817C)),
      ),
    );
  }
}

class _TimeSelector extends StatefulWidget {
  final int selectedHour;
  final int selectedMinute;
  final ValueChanged<int> onHourChanged;
  final ValueChanged<int> onMinuteChanged;

  const _TimeSelector({
    required this.selectedHour,
    required this.selectedMinute,
    required this.onHourChanged,
    required this.onMinuteChanged,
  });

  @override
  State<_TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<_TimeSelector> {
  late final FixedExtentScrollController _hourController;
  late final FixedExtentScrollController _minuteController;

  @override
  void initState() {
    super.initState();
    _hourController = FixedExtentScrollController(
      initialItem: _normalizedHour(widget.selectedHour),
    );
    _minuteController = FixedExtentScrollController(
      initialItem: _normalizedMinute(widget.selectedMinute),
    );
  }

  @override
  void didUpdateWidget(covariant _TimeSelector oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedHour != widget.selectedHour &&
        _hourController.hasClients &&
        _hourController.selectedItem != widget.selectedHour) {
      _hourController.jumpToItem(_normalizedHour(widget.selectedHour));
    }

    if (oldWidget.selectedMinute != widget.selectedMinute &&
        _minuteController.hasClients &&
        _minuteController.selectedItem != widget.selectedMinute) {
      _minuteController.jumpToItem(_normalizedMinute(widget.selectedMinute));
    }
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  int _normalizedHour(int value) => value.clamp(0, 23).toInt();

  int _normalizedMinute(int value) => value.clamp(0, 59).toInt();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 248,
      height: 176,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: 204,
            height: 58,
            decoration: BoxDecoration(
              color: const Color(0x14FA8075),
              borderRadius: BorderRadius.circular(22),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 82,
                child: CupertinoPicker.builder(
                  scrollController: _hourController,
                  itemExtent: 48,
                  diameterRatio: 1.35,
                  squeeze: 1.12,
                  useMagnifier: false,
                  selectionOverlay: const SizedBox.shrink(),
                  onSelectedItemChanged: widget.onHourChanged,
                  childCount: 24,
                  itemBuilder: (context, index) {
                    final isSelected = index == widget.selectedHour;
                    return _TimeValue(
                      value: index.toString().padLeft(2, '0'),
                      isSelected: isSelected,
                    );
                  },
                ),
              ),
              const SizedBox(width: 26),
              SizedBox(
                width: 82,
                child: CupertinoPicker.builder(
                  scrollController: _minuteController,
                  itemExtent: 48,
                  diameterRatio: 1.35,
                  squeeze: 1.12,
                  useMagnifier: false,
                  selectionOverlay: const SizedBox.shrink(),
                  onSelectedItemChanged: widget.onMinuteChanged,
                  childCount: 60,
                  itemBuilder: (context, index) {
                    final isSelected = index == widget.selectedMinute;
                    return _TimeValue(
                      value: index.toString().padLeft(2, '0'),
                      isSelected: isSelected,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimeValue extends StatelessWidget {
  final String value;
  final bool isSelected;

  const _TimeValue({
    required this.value,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        value,
        style: GoogleFonts.plusJakartaSans(
          fontSize: isSelected ? 24 : 22,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          color: isSelected
              ? const Color(0xFFFF6B5A)
              : const Color(0xFFB9ADA7),
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SaveButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFFF6B5A),
      borderRadius: BorderRadius.circular(28),
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Container(
          height: 54,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x26FF6B5A),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
