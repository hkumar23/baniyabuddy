import 'dart:ffi';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

import '../../../constants/app_constants.dart';
import '../../../../data/models/user.model.dart';
import '../../../data/models/invoice.model.dart';

abstract class GeneratePdf {
  static Future<void> start(Invoice invoice) async {
    try {
      final doc = pw.Document();
      await _createPage(doc, invoice);
      bool isGranted = await _requestStoragePermission();
      if (!isGranted) {
        throw "Storage Permission not granted";
      }
      final dir = await getExternalStorageDirectory();
      final String path = "${dir!.parent.parent.parent.parent.path}/Download";

      // Create the Downloads directory if it doesn't exist
      final downloadDir = Directory(path);
      if (!await downloadDir.exists()) {
        await downloadDir.create(recursive: true);
      }
      bool isPrinted = await _previewPdf(doc);
      // print(isPrinted);
      if (!isPrinted) {
        await _savePdfToLocal(path, doc, invoice);
      }
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> _savePdfToLocal(path, doc, invoice) async {
    // Define the file name and save the PDF
    final file = File(
        '$path/${AppConstants.invoiceIdPrefix}${invoice.invoiceNumber}.pdf');
    await file.writeAsBytes(await doc.save());
    print('PDF saved to ${file.path}');
  }

  static Future<bool> _previewPdf(doc) async {
    return Printing.layoutPdf(
      onLayout: (format) async => doc.save(),
    );
  }

  static Future<pw.Font> _loadFont() async {
    final ByteData data =
        await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    return pw.Font.ttf(data);
  }

  static Future<void> _createPage(doc, Invoice invoice) async {
    final font = await _loadFont();
    final defaultTextStyle = pw.TextStyle(font: font);
    final List<List<dynamic>> tableData = [
      // Header Row
      [
        'S.No.',
        'Item Name',
        'Quantity',
        'Unit Price',
        'Tax (%)',
        'Discount (%)',
        'Total Price',
      ],
      // Item Rows
      ...invoice.billItems!.asMap().entries.map((item) {
        return [
          item.key + 1,
          item.value.itemName,
          item.value.quantity,
          '₹${item.value.unitPrice}',
          item.value.tax,
          item.value.discount,
          '₹${item.value.totalPrice}',
        ];
      }),
    ];
    doc.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(24),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Invoice Header
            pw.Text(
              'Invoice',
              style: defaultTextStyle.copyWith(
                fontSize: 36,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10),

            // Invoice Details
            pw.Text(
              'Invoice ID: ${AppConstants.invoiceIdPrefix}${invoice.invoiceNumber}',
              style: defaultTextStyle,
            ),
            pw.Text(
              'Invoice Date: ${DateFormat('dd-MM-yyyy').format(invoice.invoiceDate!)}',
              style: defaultTextStyle,
            ),
            pw.Text(
              'Payment Method: ${invoice.paymentMethod ?? AppConstants.notMentioned}',
              style: defaultTextStyle,
            ),
            pw.SizedBox(height: 10),

            // Client Details
            pw.Text(
              'Client Details',
              style: defaultTextStyle.copyWith(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              'Name: ${invoice.clientName}',
              style: defaultTextStyle,
            ),
            if (invoice.clientAddress != null)
              pw.Text(
                'Address: ${invoice.clientAddress}',
                style: defaultTextStyle,
              ),
            if (invoice.clientEmail != null)
              pw.Text(
                'Email: ${invoice.clientEmail}',
                style: defaultTextStyle,
              ),
            if (invoice.clientPhone != null)
              pw.Text(
                'Phone: ${invoice.clientPhone}',
                style: defaultTextStyle,
              ),
            pw.SizedBox(height: 10),

            // Billing Items
            // pw.Text('Items',
            //     style: defaultTextStyle.copyWith(
            //         fontSize: 20, fontWeight: pw.FontWeight.bold,)),
            pw.TableHelper.fromTextArray(
              context: context,
              data: tableData,
              cellAlignment: pw.Alignment.centerLeft,
              cellStyle: defaultTextStyle.copyWith(
                  // fontSize: 14,
                  ),
              headerAlignment: pw.Alignment.centerLeft,
              headerStyle: defaultTextStyle.copyWith(
                fontWeight: pw.FontWeight.bold,
                fontSize: 14,
                color: PdfColors.white,
              ),

              headerDecoration: const pw.BoxDecoration(
                color: PdfColors.teal, // Header background color
              ),
              border: pw.TableBorder.all(
                width: 1,
                color: PdfColors.grey,
              ), // Table border
              cellDecoration: (a, b, c) => const pw.BoxDecoration(
                color: PdfColors.grey100, // Row background color for all cells
              ),
            ),
            // pw.Table.fromTextArray(
            //   headers: ['Item', 'Quantity', 'Price'],
            //   data:
            // ),
            pw.SizedBox(height: 10),

            // Summary Details
            pw.Text('Summary',
                style: defaultTextStyle.copyWith(
                    fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.Text(
              'Subtotal: ₹${invoice.subtotal}',
              style: defaultTextStyle,
            ),
            if (invoice.extraDiscount != null)
              pw.Text(
                'Extra Discount: ₹${invoice.extraDiscount}',
                style: defaultTextStyle,
              ),
            pw.Text(
              'Total Discount: ₹${invoice.totalDiscount}',
              style: defaultTextStyle,
            ),
            pw.Text(
              'Total Tax: ₹${invoice.totalTaxAmount}',
              style: defaultTextStyle,
            ),
            if (invoice.shippingCharges != null)
              pw.Text(
                'Shipping Charges: ₹${invoice.shippingCharges}',
                style: defaultTextStyle,
              ),
            pw.Text(
              'Grand Total: ₹${invoice.grandTotal}',
              style: defaultTextStyle,
            ),
            pw.SizedBox(height: 10),

            // Notes
            if (invoice.notes != null)
              pw.Text(
                'Notes',
                style: defaultTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            if (invoice.notes != null)
              pw.Text(
                invoice.notes!,
                style: defaultTextStyle,
              ),
            if (invoice.notes != null) pw.SizedBox(height: 10),

            // Footer (Placeholder Information)
            pw.Text('Contact us',
                style: defaultTextStyle.copyWith(
                    fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.Text(
              User().name!,
              style: defaultTextStyle,
            ),
            pw.Text(
              'Address: ${User().address}',
              style: defaultTextStyle,
            ),
            pw.Text(
              'Email: ${User().email}',
              style: defaultTextStyle,
            ),
            pw.Text(
              'Phone: ${User().phone}',
              style: defaultTextStyle,
            ),
            pw.Text(
              'GSTIN: ${User().gstin}',
              style: defaultTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  static Future<bool> _requestStoragePermission() async {
    // int.parse(Platform.operatingSystemVersion.split(" ")[1].split(".")[0]);
    // print("Requesting storage permission");
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    int androidVersion = int.parse(androidInfo.version.release);
    if (await Permission.storage.isGranted) {
      return true;
    } else if (androidVersion >= 13) {
      final status = await Permission.manageExternalStorage.request();

      return status.isGranted;
    } else {
      final status = await Permission.storage.request();
      return status.isGranted;
    }
  }
}
