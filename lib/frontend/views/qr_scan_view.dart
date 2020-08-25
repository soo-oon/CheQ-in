import 'package:checkin/frontend/viewModels/qr_scan_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';

class QRScanView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<QRScanViewModel>.withConsumer(
        onModelReady: (model) => model.init(),
        viewModelBuilder: () => QRScanViewModel(),
        builder: (context, model, child) => Column(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: QRView(
                    key: model.qrKey,
                    onQRViewCreated: model.enterBuilding,
                    overlay: QrScannerOverlayShape(
                      borderColor: Colors.lightBlueAccent,
                      borderRadius: 10,
                      borderLength: 30,
                      borderWidth: 10,
                      cutOutSize: 200,
                    ),
                  ),
                ),
              ],
            ));
  }
}
