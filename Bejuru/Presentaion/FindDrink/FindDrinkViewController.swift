//
//  FindDrinkViewController.swift
//  Bejuru
//
//  Created by 권석기 on 9/25/25.
//

import UIKit
import SnapKit
import Then

class FindDrinkViewController: UIViewController {
    
    private lazy var scanStartButton = UIButton().then {
        $0.setTitle("바코드 스캔", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(scanStartButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scanStartButton)
        
        scanStartButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(50)
            make.center.equalToSuperview()
        }
    }

    @objc func scanStartButtonTapped() {
        let barcodeScanVC = BarcodeScanViewController()
        let navVC = UINavigationController(rootViewController: barcodeScanVC)
        navVC.modalPresentationStyle = .fullScreen
        
        navigationController?.present(navVC, animated: true)
    }
}
