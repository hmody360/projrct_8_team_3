import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:project_8_team3/helper/colors.dart';
import 'package:project_8_team3/helper/extintion.dart';
import 'package:project_8_team3/helper/sized.dart';
import 'package:project_8_team3/widgets/custom_widget.dart';

//convert frome StatefulWidget to StatelessWidget
class ScanPage extends StatelessWidget {
  const ScanPage({Key? key});

  Future<void> startBarcodeScanStream(BuildContext context) async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
      '#ff6666',
      'إلغاء',
      true,
      ScanMode.BARCODE,
    )!
        .listen((barcode) => debugPrint(barcode));
  }

  Future<void> scanBarcodeNormal(BuildContext context) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'إلغاء المسح',
        true,
        ScanMode.BARCODE,
      );
      debugPrint(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/scaning.png',
              width: context.getWidth() + 100,
              height: 300,
            ),
            const Center(
                child: Row(children: [
              gapWe40,
              gapWe40,
              gapWe10,
              gapWe10,
              Text(
                "    استخدم هاتفك الذكي      ",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              )
            ])),
            const Center(
                child: Row(children: [
              gapWe40,
              gapWe20,
              gapWe5,
              gapWe10,
              Text(
                "    لفحص الباركود بسهولة وسرعة      ",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              )
            ])),
            const SizedBox(height: 10),
            SizedBox(
              width: context.getWidth() - 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shadowColor: greenText,
                    elevation: 2,
                    minimumSize: const Size(double.infinity, 60),
                    backgroundColor: whiteColor,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: textfieldGreenColor ?? transparent),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)))),
                onPressed: () => startBarcodeScanStream(context),
                child: Text(
                  " اضغط هنا ",
                  style: TextStyle(
                      color: textgreyColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
