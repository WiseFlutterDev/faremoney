import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';




class QRCodePage extends StatelessWidget {
  final String data;

  const QRCodePage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code'),
      ),
      body: Center(
        child: Container(
          color: Colors.white, // Set background color
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                QrImageView(
                  data: data,
                  version: QrVersions.auto,
                  size: 200.0,
                  foregroundColor: Colors.black, // Set QR code color
                  // You can set other properties like errorCorrectionLevel, etc. as needed
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _printQRCode(context),
                  child: const Text('Print QR Code'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _printQRCode(BuildContext context) async {
    final pdf = pw.Document();
    final image = await _captureQRCode();
    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Image(pw.MemoryImage(Uint8List.fromList(image!.buffer.asUint8List()))),
        );
      },
    ));
    await Printing.sharePdf(bytes: await pdf.save(), filename: 'qr_code.pdf');
  }

  Future<ByteData?> _captureQRCode() async {
    final image = await QrPainter(
      data: data,
      version: QrVersions.auto,
      color: Colors.black,
      emptyColor: Colors.white,
    ).toImageData(2048);
    return image!;
  }
}