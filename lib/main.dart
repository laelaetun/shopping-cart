// // import 'package:firebase_core/firebase_core.dart';

// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:shopping_cart/application/auth/auth_bloc.dart';
// // import 'package:shopping_cart/application/auth/auth_event.dart';

// // import 'package:shopping_cart/application/service/di/injection.dart';
// // import 'package:shopping_cart/product/presentation/bloc/product_bloc.dart';
// // import 'package:shopping_cart/product/presentation/bloc/product_event.dart';
// // import 'package:shopping_cart/product/presentation/view/all_product_page.dart';

// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   await Injection.init();

// //   runApp(ShoppingApp());
// // }

// // class ShoppingApp extends StatefulWidget {
// //   const ShoppingApp({super.key});

// //   @override
// //   State<ShoppingApp> createState() => _ShoppingAppState();
// // }

// // class _ShoppingAppState extends State<ShoppingApp> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MultiBlocProvider(
// //       providers: [
// //         BlocProvider<ProductBloc>(
// //           create: (context) => getIt<ProductBloc>()..add(ProductGetEvent()),
// //         ),
// //         BlocProvider<AuthBloc>(
// //           create: (context) => getIt<AuthBloc>()..add(AppStarted()),
// //         ),
// //       ],
// //       child: MaterialApp(home: AllProductPage()),
// //     );
// //   }
// // }

// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:shopping_cart/application/auth/auth_bloc.dart';
// // import 'package:shopping_cart/application/auth/auth_event.dart';
// // import 'package:shopping_cart/application/service/di/injection.dart';
// // import 'package:shopping_cart/splash_screen.dart';

// // void main() async {
// //   // Ensure Flutter bindings are initialized before async tasks
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   await Injection.init();

// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider(
// //       // We trigger AppStarted immediately to check for an existing session
// //       create: (context) => getIt<AuthBloc>()..add(AppStarted()),
// //       child: MaterialApp(
// //         title: 'Secure Auth Flow',
// //         theme: ThemeData(primarySwatch: Colors.blue),
// //         home: AnimatedSplashScreen(), // The decision maker
// //       ),
// //     );
// //   }
// // }
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';

// // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// //   await Firebase.initializeApp();
// //   debugPrint('Background message: ${message.messageId}');
// // }

// // Future<void> main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
// //   runApp(const MessagingApp());
// // }

// // class MessagingApp extends StatelessWidget {
// //   const MessagingApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Firebase Messaging',
// //       theme: ThemeData(
// //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
// //         useMaterial3: true,
// //       ),
// //       home: const MessagingHome(),
// //     );
// //   }
// // }

// // class MessagingHome extends StatefulWidget {
// //   const MessagingHome({super.key});

// //   @override
// //   State<MessagingHome> createState() => _MessagingHomeState();
// // }

// // class _MessagingHomeState extends State<MessagingHome> {
// //   final List<RemoteMessage> _messages = [];
// //   String? _token;
// //   String _permissionStatus = 'Unknown';
// //   RemoteMessage? _openedFromNotification;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initMessaging();
// //   }

// //   Future<void> _initMessaging() async {
// //     if (kIsWeb) {
// //       debugPrint(
// //         'Web requires FirebaseOptions. Run flutterfire configure to generate them.',
// //       );
// //     }

// //     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
// //       alert: true,
// //       badge: true,
// //       sound: true,
// //     );

// //     final settings = await FirebaseMessaging.instance.requestPermission(
// //       alert: true,
// //       badge: true,
// //       sound: true,
// //     );
// //     setState(() {
// //       _permissionStatus = settings.authorizationStatus.name;
// //     });

// //     final token = await FirebaseMessaging.instance.getToken();
// //     setState(() {
// //       _token = token;
// //     });

// //     FirebaseMessaging.instance.onTokenRefresh.listen((token) {
// //       setState(() {
// //         _token = token;
// //       });
// //     });

// //     final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
// //     if (initialMessage != null) {
// //       setState(() {
// //         _openedFromNotification = initialMessage;
// //         _messages.insert(0, initialMessage);
// //       });
// //     }

// //     FirebaseMessaging.onMessage.listen((message) {
// //       setState(() {
// //         _messages.insert(0, message);
// //       });

// //       final title = _messageTitle(message);
// //       final body = _messageBody(message);
// //       if (!mounted) return;
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Message: $title${body.isEmpty ? '' : ' — $body'}'),
// //           duration: const Duration(seconds: 3),
// //         ),
// //       );
// //     });

// //     FirebaseMessaging.onMessageOpenedApp.listen((message) {
// //       setState(() {
// //         _openedFromNotification = message;
// //         _messages.insert(0, message);
// //       });
// //     });
// //   }

// //   String _messageTitle(RemoteMessage message) {
// //     return message.notification?.title ??
// //         message.data['title']?.toString() ??
// //         'No title';
// //   }

// //   String _messageBody(RemoteMessage message) {
// //     return message.notification?.body ??
// //         message.data['body']?.toString() ??
// //         '';
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Firebase Messaging Demo'),
// //       ),
// //       body: ListView(
// //         padding: const EdgeInsets.all(16),
// //         children: [
// //           Text(
// //             'Permission: $_permissionStatus',
// //             style: Theme.of(context).textTheme.titleMedium,
// //           ),
// //           const SizedBox(height: 8),
// //           const Text('Device token'),
// //           const SizedBox(height: 6),
// //           SelectableText(_token ?? 'Fetching token...'),
// //           const SizedBox(height: 16),
// //           if (_openedFromNotification != null) ...[
// //             Text(
// //               'Opened from notification:',
// //               style: Theme.of(context).textTheme.titleMedium,
// //             ),
// //             const SizedBox(height: 6),
// //             _MessageCard(message: _openedFromNotification!),
// //             const SizedBox(height: 16),
// //           ],
// //           Text(
// //             'Messages (${_messages.length})',
// //             style: Theme.of(context).textTheme.titleMedium,
// //           ),
// //           const SizedBox(height: 8),
// //           if (_messages.isEmpty)
// //             const Text('No messages yet. Send one from the Firebase console.'),
// //           for (final message in _messages) _MessageCard(message: message),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class _MessageCard extends StatelessWidget {
// //   const _MessageCard({required this.message});

// //   final RemoteMessage message;

// //   @override
// //   Widget build(BuildContext context) {
// //     final title = message.notification?.title ??
// //         message.data['title']?.toString() ??
// //         'No title';
// //     final body = message.notification?.body ??
// //         message.data['body']?.toString() ??
// //         '';
// //     final dataLines = message.data.entries
// //         .map((entry) => '${entry.key}: ${entry.value}')
// //         .toList();

// //     return Card(
// //       margin: const EdgeInsets.only(bottom: 12),
// //       child: Padding(
// //         padding: const EdgeInsets.all(12),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(title, style: Theme.of(context).textTheme.titleMedium),
// //             if (body.isNotEmpty) ...[
// //               const SizedBox(height: 4),
// //               Text(body),
// //             ],
// //             if (dataLines.isNotEmpty) ...[
// //               const SizedBox(height: 8),
// //               Text(
// //                 'Data:',
// //                 style: Theme.of(context).textTheme.labelMedium,
// //               ),
// //               const SizedBox(height: 4),
// //               Text(dataLines.join('\n')),
// //             ],
// //             const SizedBox(height: 6),
// //             Text(
// //               'Message ID: ${message.messageId ?? 'N/A'}',
// //               style: Theme.of(context).textTheme.labelSmall,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// //firebase app
// // import 'package:flutter/material.dart';

// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:shopping_cart/firebase/chat_screen_ui.dart';

// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp(

// //   );
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(title: 'Simple Messenger', home: ChatScreen());
// //   }
// // }
// // import 'package:flutter/material.dart';
// // import 'package:url_launcher/url_launcher.dart';

// // // app build process is triggered here
// // void main() {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   runApp(const MyApp());
// // }

// // Future<void> _sendingMails() async {
// //   var _url = Uri.parse("mailto:feedback@geeksforgeeks.org");

// //   if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
// //     throw Exception('Could not launch $_url');
// //   }
// // }

// // Future<void> _sendingSMS() async {
// //   var _url = Uri.parse("sms:09444788467");

// //   if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
// //     throw Exception('Could not launch $_url');
// //   }
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: const Text('Geeks for Geeks'),
// //           backgroundColor: Colors.green,
// //           foregroundColor: Colors.white,
// //         ),
// //         body: SafeArea(
// //           child: Center(
// //             child: Column(
// //               children: [
// //                 Container(height: 200.0),
// //                 const Text(
// //                   'Welcome to GFG!',
// //                   style: TextStyle(
// //                     fontSize: 35.0,
// //                     color: Colors.green,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //                 Container(height: 20.0),
// //                 const Text(
// //                   'For any Queries, Mail us',
// //                   style: TextStyle(fontSize: 18.0, color: Colors.green),
// //                 ),
// //                 Container(height: 10.0),
// //                 ElevatedButton(
// //                   onPressed: _sendingMails,
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.green,
// //                     foregroundColor: Colors.white,
// //                   ),
// //                   child: const Text('Here'),
// //                 ), // ElevatedButton

// //                 Container(height: 20.0),
// //                 const Text(
// //                   'Or Send SMS',
// //                   style: TextStyle(fontSize: 18.0, color: Colors.green),
// //                 ),
// //                 Container(height: 10.0),
// //                 ElevatedButton(
// //                   onPressed: _sendingSMS,
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.green,
// //                     foregroundColor: Colors.white,
// //                   ),
// //                   child: const Text('Here'),
// //                 ), // ElevatedButton
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_core/firebase_core.dart';

// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Firebase',
// //       debugShowCheckedModeBanner: false,
// //       home: AddData(),
// //     );
// //   }
// // }

// // class AddData extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.green,
// //         foregroundColor: Colors.white,
// //         title: Text("geeksforgeeks"),
// //       ),
// //       body: StreamBuilder(
// //         stream: FirebaseFirestore.instance.collection('data').snapshots(),
// //         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //           if (!snapshot.hasData) {
// //             return Center(child: CircularProgressIndicator());
// //           }

// //           return ListView(
// //             children: snapshot.data!.docs.map((document) {
// //               return Container(child: Center(child: Text(document['text'])));
// //             }).toList(),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import 'package:shopping_cart/myquiz/anima.dart';

// // void main() {
// //   runApp(mainApp());
// // }

// // class mainApp extends StatefulWidget {
// //   const mainApp({super.key});

// //   @override
// //   State<mainApp> createState() => _mainAppState();
// // }

// // class _mainAppState extends State<mainApp> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(home: LottiePage());
// //   }
// // }

// //pdf
// // import 'dart:io';
// // import 'dart:typed_data';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_pdfview/flutter_pdfview.dart';

// // import 'package:path_provider/path_provider.dart';
// // import 'package:pdf/pdf.dart';
// // import 'package:pdf/widgets.dart' as pw;

// // void main() {
// //   runApp(MyApp());
// // }

// // class PdfPreviewScreen extends StatelessWidget {
// //   final String? path;

// //   const PdfPreviewScreen({super.key, this.path});

// //   @override
// //   Widget build(BuildContext context) {
// //     return PDFView(filePath: path);
// //   }
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'PDF Demo',
// //       theme: ThemeData(
// //         primarySwatch: Colors.grey,
// //         visualDensity: VisualDensity.adaptivePlatformDensity,
// //       ),
// //       home: MyHomePage(),
// //       debugShowCheckedModeBanner: false,
// //     );
// //   }
// // }

// // class MyHomePage extends StatelessWidget {
// //   final pdf = pw.Document();

// //   MyHomePage();

// //   Future<void> savePdf() async {
// //     try {
// //       Directory documentDirectory = await getApplicationDocumentsDirectory();
// //       String documentPath = documentDirectory.path;
// //       File file = File("$documentPath/example.pdf");

// //       Uint8List pdfData = await pdf.save();

// //       await file.writeAsBytes(pdfData);
// //     } catch (e) {
// //       debugPrint("E:$e");
// //     }
// //   }

// //   void writeOnPdf() {
// //     pdf.addPage(
// //       pw.MultiPage(
// //         pageFormat: PdfPageFormat.a4,
// //         margin: const pw.EdgeInsets.all(32),
// //         build: (pw.Context context) {
// //           return <pw.Widget>[
// //             pw.Header(
// //               level: 0,
// //               child: pw.Row(
// //                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
// //                 children: <pw.Widget>[
// //                   pw.Text('GeeksforGeeks', textScaleFactor: 2),
// //                 ],
// //               ),
// //             ),
// //             pw.Header(level: 1, text: 'What is Lorem Ipsum?'),
// //             pw.Paragraph(
// //               text: '''
// // Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
// // tempor incididunt ut labore et dolore magna aliqua. Nunc mi ipsum faucibus
// // vitae aliquet nec. Nibh cras pulvinar mattis nunc sed blandit libero
// // volutpat. Vitae elementum curabitur vitae nunc sed velit. Nibh tellus
// // molestie nunc non blandit massa. Bibendum enim facilisis gravida neque.
// // Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Enim diam
// // vulputate ut pharetra sit. Tellus pellentesque eu tincidunt tortor
// // aliquam nulla facilisi cras fermentum.
// // ''',
// //             ),
// //             pw.Paragraph(
// //               text: '''
// // Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
// // tempor incididunt ut labore et dolore magna aliqua. Nunc mi ipsum faucibus
// // vitae aliquet nec. Nibh cras pulvinar mattis nunc sed blandit libero
// // volutpat. Vitae elementum curabitur vitae nunc sed velit. Nibh tellus
// // molestie nunc non blandit massa. Bibendum enim facilisis gravida neque.
// // Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Enim diam
// // vulputate ut pharetra sit. Tellus pellentesque eu tincidunt tortor
// // aliquam nulla facilisi cras fermentum.
// // ''',
// //             ),
// //             pw.Header(level: 1, text: 'This is Header'),
// //             pw.Paragraph(
// //               text: '''
// // Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
// // tempor incididunt ut labore et dolore magna aliqua. Nunc mi ipsum faucibus
// // vitae aliquet nec. Nibh cras pulvinar mattis nunc sed blandit libero
// // volutpat. Vitae elementum curabitur vitae nunc sed velit. Nibh tellus
// // molestie nunc non blandit massa. Bibendum enim facilisis gravida neque.
// // Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Enim diam
// // vulputate ut pharetra sit. Tellus pellentesque eu tincidunt tortor
// // aliquam nulla facilisi cras fermentum.
// // ''',
// //             ),
// //             pw.Paragraph(
// //               text: '''
// // Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
// // tempor incididunt ut labore et dolore magna aliqua. Nunc mi ipsum faucibus
// // vitae aliquet nec. Nibh cras pulvinar mattis nunc sed blandit libero
// // volutpat. Vitae elementum curabitur vitae nunc sed velit. Nibh tellus
// // molestie nunc non blandit massa. Bibendum enim facilisis gravida neque.
// // Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Enim diam
// // vulputate ut pharetra sit. Tellus pellentesque eu tincidunt tortor
// // aliquam nulla facilisi cras fermentum.
// // ''',
// //             ),
// //             pw.Padding(padding: const pw.EdgeInsets.all(10)),
// //             pw.TableHelper.fromTextArray(
// //               context: context,
// //               data: const <List<String>>[
// //                 <String>['Year', 'Sample'],
// //                 <String>['SN0', 'GFG1'],
// //                 <String>['SN1', 'GFG2'],
// //                 <String>['SN2', 'GFG3'],
// //                 <String>['SN3', 'GFG4'],
// //               ],
// //             ),
// //           ];
// //         },
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("GeeksforGeeks"),
// //         backgroundColor: Colors.green,
// //         foregroundColor: Colors.white,
// //       ),
// //       body: Container(
// //         padding: const EdgeInsets.all(10),
// //         child: Column(
// //           children: <Widget>[
// //             SizedBox(
// //               width: double.infinity,
// //               child: ElevatedButton(
// //                 style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
// //                 child: const Text(
// //                   'Preview PDF',
// //                   style: TextStyle(
// //                     fontWeight: FontWeight.bold,
// //                     fontSize: 18,
// //                     color: Colors.white,
// //                   ),
// //                 ),
// //                 onPressed: () async {
// //                   writeOnPdf();
// //                   await savePdf();

// //                   Directory documentDirectory =
// //                       await getApplicationDocumentsDirectory();

// //                   String documentPath = documentDirectory.path;

// //                   String fullPath = "$documentPath/example.pdf";
// //                   print(fullPath);

// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                       builder: (context) => PdfPreviewScreen(path: fullPath),
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// //table
// // import 'package:flutter/material.dart';

// // // Step 1: Define a data model
// // class User {
// //   final int id;
// //   final String name;
// //   final int age;

// //   User({required this.id, required this.name, required this.age});
// // }

// // class BeautifulTableExample extends StatelessWidget {
// //   // Step 2: Sample dynamic data
// //   final List<User> users = [
// //     User(id: 1, name: 'Alice', age: 25),
// //     User(id: 2, name: 'Bob', age: 30),
// //     User(id: 3, name: 'Charlie', age: 28),
// //     User(id: 4, name: 'David', age: 35),
// //     User(id: 5, name: 'Eva', age: 22),
// //     User(id: 6, name: 'Frank', age: 40),
// //   ];

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Beautiful Dynamic Table'),
// //         backgroundColor: Colors.teal,
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Card(
// //           elevation: 5,
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(12),
// //           ),
// //           child: SingleChildScrollView(
// //             scrollDirection: Axis.horizontal,
// //             child: DataTable(
// //               headingRowColor: MaterialStateProperty.all(Colors.teal.shade100),
// //               headingTextStyle: TextStyle(
// //                 fontWeight: FontWeight.bold,
// //                 fontSize: 16,
// //                 color: Colors.teal.shade900,
// //               ),
// //               dataRowHeight: 60,
// //               columnSpacing: 40,
// //               dividerThickness: 2,
// //               columns: const [
// //                 DataColumn(label: Text('ID')),
// //                 DataColumn(label: Text('Name')),
// //                 DataColumn(label: Text('Age')),
// //               ],
// //               rows: List.generate(users.length, (index) {
// //                 final user = users[index];
// //                 return DataRow(
// //                   color: MaterialStateProperty.resolveWith<Color?>((
// //                     Set<MaterialState> states,
// //                   ) {
// //                     // Alternate row colors
// //                     if (index % 2 == 0) return Colors.teal.shade50;
// //                     return null; // default
// //                   }),
// //                   cells: [
// //                     DataCell(Text(user.id.toString())),
// //                     DataCell(Text(user.name)),
// //                     DataCell(Text(user.age.toString())),
// //                   ],
// //                 );
// //               }),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // void main() {
// //   runApp(
// //     MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: BeautifulTableExample(),
// //       theme: ThemeData(primarySwatch: Colors.teal),
// //     ),
// //   );
// // }

// // import 'package:flutter/material.dart';
// // import 'package:dio/dio.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'dart:io';
// // import 'package:permission_handler/permission_handler.dart';

// // Future<void> downloadPdf(String url, String fileName) async {
// //   try {
// //     // Request storage permission (Android)
// //     if (Platform.isAndroid) {
// //       var status = await Permission.storage.request();
// //       if (!status.isGranted) {
// //         print("Permission denied!");
// //         return;
// //       }
// //     }

// //     // Get device directory
// //     Directory directory;
// //     if (Platform.isAndroid) {
// //       directory = (await getExternalStorageDirectory())!;
// //     } else {
// //       directory = await getApplicationDocumentsDirectory();
// //     }

// //     String filePath = "${directory.path}/$fileName.pdf";

// //     // Download PDF
// //     Dio dio = Dio();
// //     await dio.download(url, filePath);

// //     print("PDF saved to $filePath");
// //   } catch (e) {
// //     print("Error downloading PDF: $e");
// //   }
// // }

// // class PdfDownloadPage extends StatelessWidget {
// //   final String pdfUrl =
// //       "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Download PDF Example')),
// //       body: Center(
// //         child: ElevatedButton(
// //           onPressed: () async {
// //             await downloadPdf(pdfUrl, "sample_file");
// //             ScaffoldMessenger.of(context).showSnackBar(
// //               SnackBar(content: Text('PDF Downloaded Successfully!')),
// //             );
// //           },
// //           child: Text('Download PDF'),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // void main() => runApp(MaterialApp(home: PdfDownloadPage()));
// // import 'dart:io';
// // import 'dart:typed_data';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_pdfview/flutter_pdfview.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:pdf/pdf.dart';
// // import 'package:pdf/widgets.dart' as pw;
// // import 'package:permission_handler/permission_handler.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class PdfPreviewScreen extends StatelessWidget {
// //   final String? path;

// //   const PdfPreviewScreen({super.key, this.path});

// //   @override
// //   Widget build(BuildContext context) {
// //     return PDFView(filePath: path);
// //   }
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'PDF Demo',
// //       theme: ThemeData(primarySwatch: Colors.green),
// //       home: MyHomePage(),
// //       debugShowCheckedModeBanner: false,
// //     );
// //   }
// // }

// // class MyHomePage extends StatelessWidget {
// //   final pdf = pw.Document();

// //   MyHomePage();

// //   void writeOnPdf() {
// //     pdf.addPage(
// //       pw.MultiPage(
// //         pageFormat: PdfPageFormat.a4,
// //         build: (pw.Context context) {
// //           return [
// //             pw.Header(level: 0, text: "GeeksforGeeks"),
// //             pw.Paragraph(text: "This is a sample PDF created in Flutter."),
// //             pw.Table.fromTextArray(
// //               data: const [
// //                 ['Year', 'Sample'],
// //                 ['2023', 'Flutter'],
// //                 ['2024', 'Dart'],
// //                 ['2025', 'PDF'],
// //               ],
// //             ),
// //           ];
// //         },
// //       ),
// //     );
// //   }

// //   /// Save PDF in app directory (preview)
// //   Future<String> savePdf() async {
// //     Directory documentDirectory = await getApplicationDocumentsDirectory();
// //     String documentPath = documentDirectory.path;
// //     File file = File("$documentPath/example.pdf");
// //     Uint8List pdfData = await pdf.save();
// //     await file.writeAsBytes(pdfData);
// //     return file.path;
// //   }

// //   /// Download PDF to Downloads folder (Android) or Documents (iOS)
// //   Future<void> downloadPdf(String fileName) async {
// //     try {
// //       // Request storage permission (Android)
// //       if (Platform.isAndroid) {
// //         var status = await Permission.storage.request();
// //         if (!status.isGranted) {
// //           print("Permission denied!");
// //           return;
// //         }
// //       }

// //       // Save file
// //       Directory? directory;
// //       if (Platform.isAndroid) {
// //         directory = Directory(
// //           "/storage/emulated/0/Download",
// //         ); // Downloads folder
// //       } else {
// //         directory = await getApplicationDocumentsDirectory();
// //       }

// //       String filePath = "${directory.path}/$fileName.pdf";
// //       Uint8List pdfData = await pdf.save();
// //       File file = File(filePath);
// //       await file.writeAsBytes(pdfData);

// //       print("PDF downloaded to $filePath");
// //     } catch (e) {
// //       print("Error downloading PDF: $e");
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("GeeksforGeeks")),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             ElevatedButton(
// //               onPressed: () async {
// //                 writeOnPdf();
// //                 String path = await savePdf(); // save for preview
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                     builder: (context) => PdfPreviewScreen(path: path),
// //                   ),
// //                 );
// //               },
// //               child: const Text("Preview PDF"),
// //             ),
// //             const SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: () async {
// //                 writeOnPdf();
// //                 await downloadPdf("example_downloaded");
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   SnackBar(content: Text("PDF downloaded successfully!")),
// //                 );
// //               },
// //               child: const Text("Download PDF"),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// Future<Album> fetchAlbum() async {
//   final response = await http.get(
//     Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
//   );

//   // Dispatch action depending upon
//   //the server response
//   if (response.statusCode == 200) {
//     return Album.fromJson(json.decode(response.body));
//   } else {
//     throw Exception('Failed to load album');
//   }
// }

// Future<Album> updateAlbum(String title) async {
//   final http.Response response = await http.put(
//     Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{'title': title}),
//   );
//   // parsing JSOn or throwing an exception
//   if (response.statusCode == 200) {
//     return Album.fromJson(json.decode(response.body));
//   } else {
//     throw Exception('Failed to update album.');
//   }
// }

// class Album {
//   final int id;
//   final String title;

//   Album({required this.id, required this.title});

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(id: json['id'], title: json['title']);
//   }
// }

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _MyAppState createState() {
//     return _MyAppState();
//   }
// }

// class _MyAppState extends State<MyApp> {
//   final TextEditingController _controller = TextEditingController();
//   late Future<Album> _futureAlbum;

//   @override
//   void initState() {
//     super.initState();
//     _futureAlbum = fetchAlbum();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Update Data Example',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('GeeksForGeeks'),
//           backgroundColor: Colors.green,
//         ),
//         body: Container(
//           alignment: Alignment.center,
//           padding: const EdgeInsets.all(8.0),
//           child: FutureBuilder<Album>(
//             future: _futureAlbum,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 if (snapshot.hasData) {
//                   return Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(snapshot.data!.title),
//                       TextField(
//                         controller: _controller,
//                         decoration: const InputDecoration(
//                           hintText: 'Enter Title',
//                         ),
//                       ),
//                       ElevatedButton(
//                         child: const Text('Update Data'),
//                         onPressed: () {
//                           setState(() {
//                             _futureAlbum = updateAlbum(_controller.text);
//                           });
//                         },
//                       ),

//                       // RaisedButton is deprecated and should not be used.
//                       // Use ElevatedButton instead.

//                       // RaisedButton(
//                       //     child: const Text('Update Data'),
//                       //     onPressed: () {
//                       //     setState(() {
//                       //         _futureAlbum = updateAlbum(_controller.text);
//                       //     });
//                       //     },
//                       // ),
//                     ],
//                   );
//                 } else if (snapshot.hasError) {
//                   return Text("${snapshot.error}");
//                 }
//               }
//               return const CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'package:shopping_cart/drift/pages/drift_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: StudentsPage());
  }
}
