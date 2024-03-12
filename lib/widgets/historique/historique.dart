import 'package:flutter/material.dart';
import 'package:gestiondossier/models/historique.dart';

const snackBar = SnackBar(
  content: Text('Yay! A SnackBar!'),
);

// class HistoriqueCard extends StatelessWidget {
//   Historique historique;

//   HistoriqueCard({required this.historique});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             RichText(
//               text: TextSpan(
//                 text: "Date : ",
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 children: [
//                   TextSpan(
//                     text:
//                         "${historique.date?.toLocal().toString().split(' ')[0]}",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 8),
//             RichText(
//               text: TextSpan(
//                 text: "Utilisateur : ",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "${historique.utilisateur}",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 8),
//             RichText(
//               text: TextSpan(
//                 text: "Description : ",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "${historique.getDescription()}",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 8),
//             RichText(
//               text: TextSpan(
//                 text: "Sigle : ",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "${historique.sigle}",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 8),
//             RichText(
//               text: TextSpan(
//                 text: "Observation : ",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: "${historique.observation}",
//                     style: TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
class HistoriqueCard extends StatelessWidget {
  final Historique historique;

  HistoriqueCard({required this.historique});

  TextStyle labelStyle() {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle contentStyle() {
    return TextStyle(
      fontSize: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Date :",
                  style: labelStyle(),
                ),
                SizedBox(width: 8),
                Text(
                  "${historique.date?.toLocal().toString().split(' ')[0]}",
                  style: contentStyle(),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "Utilisateur :",
                  style: labelStyle(),
                ),
                SizedBox(width: 8),
                Text(
                  "${historique.utilisateur}",
                  style: contentStyle(),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "Description :",
                  style: labelStyle(),
                ),
                SizedBox(width: 8),
                Text(
                  "${historique.getDescription()}",
                  style: contentStyle(),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "Sigle :",
                  style: labelStyle(),
                ),
                SizedBox(width: 8),
                Text(
                  "${historique.sigle}",
                  style: contentStyle(),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "Observation :",
                  style: labelStyle(),
                ),
                SizedBox(width: 8),
                Text(
                  "${historique.observation}",
                  style: contentStyle(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
