import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/common_widget/main_app_bar.dart/main_app_bar.dart';
import 'package:retrash_app/presentation/screens/qr_screen/qr_bloc.dart';
import 'package:retrash_app/presentation/resources/app_colors.dart';
import 'package:retrash_app/presentation/resources/app_strings.dart';
import 'dart:io' show Platform;
import '../../../main.dart';

class QrScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _QrScreenState();
}

class _QrScreenState extends BaseState<QrScreen, QrBloc> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'Qr');
  bool already_read = false;
  Barcode? _barcodeData;
  QRViewController? _qrController;

  @override
  PreferredSizeWidget? appBar() =>
      MainAppBar.fromMenu(AppStrings.qr, onLeadingTap: () {
        Scaffold.of(context).openDrawer();
      });

  @override
  Widget body() => _buildQrView(context);

  @override
  QrBloc provideBloc() => QrBloc();

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: AppColors.coral,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    _qrController = controller;
    if (!already_read) {
      controller.scannedDataStream.listen((scanData) {
        _barcodeData = scanData;
        already_read = true;
        logger.log(Level.info, _barcodeData);
      });
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _qrController!.pauseCamera();
    } else if (Platform.isIOS) {
      _qrController!.resumeCamera();
    }
  }

  @override
  void dispose() {
    _qrController?.dispose();
    super.dispose();
  }
}
