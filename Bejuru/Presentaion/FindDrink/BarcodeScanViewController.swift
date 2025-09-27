//
//  BarcodeScanViewController.swift
//  Bejuru
//
//  Created by 권석기 on 9/28/25.
//

import UIKit
import VisionKit
import SnapKit
import Then

class BarcodeScanViewController: UIViewController, DataScannerViewControllerDelegate {
    
    let viewController = DataScannerViewController(
        recognizedDataTypes: [.barcode()],
        qualityLevel: .fast,
        recognizesMultipleItems: false,
        isHighFrameRateTrackingEnabled: false,
        isHighlightingEnabled: true)
    
    var scannerAvailable: Bool {
        DataScannerViewController.isSupported &&
        DataScannerViewController.isAvailable
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setUI()
        startScan()
    }
        
    private func setUI() {
        view.addSubview(viewController.view)
        
        viewController.view.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        viewController.delegate = self
    }
    
    private func startScan() {
        try? viewController.startScanning()
    }
    
    func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
        print("item추가 \(addedItems[0])")
    }
    
    func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
        switch item {
        case .barcode(let barcode):
            print("바코드인식: \(barcode.payloadStringValue)")
            dataScanner.stopScanning()
            dataScanner.dismiss(animated: true)
            dismiss(animated: true)
        default:
            break
        }
    }
    
}
