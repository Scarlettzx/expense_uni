// import 'package:flutter/material.dart';
// // import 'package:gap/gap.dart';
// import 'package:searchfield/searchfield.dart';

// class SearchFieldWidget extends StatelessWidget {
//   final TextEditingController controller;
//   final Function(dynamic) onSuggestionTap;
//   final String? Function(String?)? validator;
//   // final List<Employee> suggestions;
//   // final List<SearchFieldListItem<dynamic>>? Function(String)? onSearch;
//   // final dynamic Function(SearchFieldListItem<dynamic>)? onItemSelected;
//   final List<SearchFieldListItem<dynamic>> suggestions;
//   const SearchFieldWidget({
//     Key? key,
//     required this.suggestions,
//     required this.controller,
//     required this.onSuggestionTap,
//     required this.validator,
//     // required this.onSearch,
//     // required this.onItemSelected,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 40,
//       width: double.infinity,
//       child: SearchField(
//         validator: (String? value) {
//           if (validator != null) {
//             String? validationError = validator!(value);
//             if (validationError != null) {
//               return validationError;
//             }
//           }
//           if (value == null || value.isEmpty) {
//             return 'Please enter a valid value';
//           }
//           return null;
//         },
//         suggestionState: Suggestion.expand,
//         scrollbarDecoration: ScrollbarDecoration(
//           shape: BeveledRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               top: Radius.circular(2),
//               bottom: Radius.circular(2),
//             ),
//             side: BorderSide(width: 1, color: Colors.red),
//           ),
//           thumbColor: Colors.grey,
//         ),
//         itemHeight: 50,
//         emptyWidget: Container(
//           alignment: Alignment.center,
//           height: 70,
//           decoration: BoxDecoration(
//             border: Border.all(width: 2, color: Colors.grey.shade300),
//             borderRadius: BorderRadius.circular(15),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.white,
//                 blurRadius: 8.0,
//                 spreadRadius: 20.0,
//                 offset: Offset(2.0, 5.0),
//               ),
//             ],
//           ),
//           padding: const EdgeInsets.all(8.0),
//           child: Text('ไม่พบข้อมูล'),
//         ),
//         suggestions: suggestions,
//         suggestionsDecoration: SuggestionDecoration(
//           border: Border.all(width: 2, color: Colors.grey.shade300),
//           padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.white,
//               blurRadius: 8.0,
//               spreadRadius: 20.0,
//               offset: Offset(2.0, 5.0),
//             ),
//           ],
//         ),
//         searchInputDecoration: InputDecoration(
//           contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//           focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               width: 2.0,
//               color: Color.fromARGB(255, 252, 119, 119),
//             ),
//             borderRadius: BorderRadius.circular(30),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: BorderSide(
//               width: 2.0,
//               color: Colors.grey.withOpacity(0.3),
//             ),
//           ),
//         ),
//         controller: controller,
//         onSuggestionTap: onSuggestionTap,
//         // onSearchTextChanged: onSearch,
//         // onSuggestionTap: onItemSelected,
//       ),
//     );
//   }
// }
