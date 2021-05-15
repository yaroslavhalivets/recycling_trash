import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:retrash_app/common_widget/main_app_bar.dart/main_app_bar.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/bloc/qr_bloc/qr_bloc.dart';
import 'package:retrash_app/presentation/resources/app_colors/app_colors.dart';
import 'package:retrash_app/presentation/resources/app_strings/app_strings.dart';

class QrScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _QrScreenState();
}

class _QrScreenState extends BaseState<QrScreen, QrBloc> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'Qr');
  Barcode? _barcodeData;
  QRViewController? _qrController;

  @override
  PreferredSizeWidget? appBar() => MainAppBar.fromMenu(context, AppStrings.qr);

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
    controller.scannedDataStream.listen((scanData) {
      _barcodeData = scanData;
    });
  }

  @override
  void dispose() {
    _qrController?.dispose();
    super.dispose();
  }
}
