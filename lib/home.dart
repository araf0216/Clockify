import 'package:clockify/time.dart';
import 'package:flutter/material.dart' as mat;
import 'package:shadcn_flutter/shadcn_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime start = DateTime.utc(2025, 1, 1), today = DateTime.now();
  DateTime? selectDate;
  bool selected = false;

  bool updateTriggered = false;

  void unselectDate() {
    setState(() {
      selectDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return selectDate != null
        ? TimeSelect(now: selectDate!, start: start, end: today, unselect: unselectDate)
        : mat.Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Scaffold(
                headers: [
                  AppBar(
                    title: Text(
                      "Select New Clock-In Date",
                      style: TextStyle(fontSize: 24),
                    ).h2().sans().center(),
                    alignment: Alignment.center,
                  ),
                ],
                child: Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: 32),
                  child: defCalendar(),
                ),
              ),
            ),
            floatingActionButton: selected
                ? mat.FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        selectDate = value!.toSingle().date;
                      });
                    },
                    backgroundColor: Color(0xFF3C83F6),
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 40,
                    ),
                  )
                : null,
          );
  }

  CalendarValue? value;
  CalendarView view = CalendarView.now();
  Widget defCalendar() {
    ShadcnLocalizations localizations = ShadcnLocalizations.of(context);
    return Card(
      borderColor: Colors.blue,
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                OutlineButton(
                  density: ButtonDensity.icon,
                  onPressed: () {
                    setState(() {
                      view = view.previous;
                    });
                  },
                  child: const Icon(Icons.arrow_back).iconXSmall(),
                ),
                Text('${localizations.getMonth(view.month)} ${view.year}')
                    .sans()
                    .small()
                    .medium()
                    .center()
                    .expanded(),
                OutlineButton(
                  density: ButtonDensity.icon,
                  onPressed: () {
                    setState(() {
                      view = view.next;
                    });
                  },
                  child: const Icon(Icons.arrow_forward).iconXSmall(),
                ),
              ],
            ),
            const Gap(16),
            Calendar(
              value: value,
              view: view,
              onChanged: (v) {
                setState(() {
                  value = v;
                  selected = v != null;
                });
              },
              selectionMode: CalendarSelectionMode.single,
              now: DateTime.now(),
              stateBuilder: (date) {
                if (date.isAfter(DateTime.now()) || date.isBefore(start)) {
                  return DateState.disabled;
                }
                return DateState.enabled;
              },
            ),
          ],
        ),
      ),
    );
  }
}
