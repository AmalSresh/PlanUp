// import 'package:flutter/material.dart';
// import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
// import 'package:multi_select_flutter/util/multi_select_item.dart';
//
// class MultiSelectQuestion extends StatefulWidget {
//   final String question;
//   final List<String> answerChoices;
//   final List<dynamic> selectedVals;
//   final Function(bool isAnswered, String question, List<dynamic> selectedValues)
//       onSelected;
//   Future<List<String>> newOptions()  {
//     throw UnimplementedError();
//   } createOptions;
//   const MultiSelectQuestion({
//     Key? key,
//     required this.question,
//     required this.answerChoices,
//     required this.selectedVals,
//     required this.onSelected,
//     required this.createOptions,
//   }) : super(key: key);
//
//   @override
//   _MultiSelectQuestionState createState() => _MultiSelectQuestionState();
// }
//
// class _MultiSelectQuestionState extends State<MultiSelectQuestion> {
//   late List<String> answers;
//   late List<MultiSelectItem<String>> multiSelectItems;
//   @override
//   void initState() {
//     super.initState();
//     answers = List.from(widget.answerChoices);
//     multiSelectItems = answers
//         .map((answer) => MultiSelectItem<String>(answer, answer))
//         .toList();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ListTile(
//           title: Text(
//             widget.question,
//             textAlign: TextAlign.left,
//             style: const TextStyle(
//               fontSize: 30,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         const SizedBox(height: 20),
//         SizedBox(
//           height: 1000,
//           width: 400,
//           child: MultiSelectChipField(
//             items: multiSelectItems,
//             initialValue: const [],
//             title: const Text("OPTIONS"),
//             headerColor: Colors.blue.withOpacity(0.5),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.blue, width: 1.8),
//             ),
//             selectedChipColor: Colors.blue.withOpacity(0.5),
//             selectedTextStyle: TextStyle(color: Colors.blue[800]),
//             onTap: (values) {
//               setState(() {
//                 widget.selectedVals = values;
//                 print(widget.selectedVals);
//                 if (widget.selectedVals.isNotEmpty) {
//                   widget.onSelected(true, widget.question, widget.selectedVals)
//                 }
//                 makeOptions();
//                 // rec(question['bar'], 'bar');
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
