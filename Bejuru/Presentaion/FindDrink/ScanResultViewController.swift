//
//  ScanResultViewController.swift
//  Bejuru
//
//  Created by 권석기 on 9/28/25.
//

import UIKit

class ScanResultViewController: UIViewController {
    
    let barcodeNumber: String

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(barcodeNumber: String) {
        self.barcodeNumber = barcodeNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
