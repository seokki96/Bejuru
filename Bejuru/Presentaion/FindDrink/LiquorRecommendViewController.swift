//
//  LiquorRecommendViewController.swift
//  Bejuru
//
//  Created by a on 10/2/25.
//

import UIKit

class LiquorRecommendViewController: UIViewController {
    
    private let recommendLabel = UILabel()
    private let recommendImage = UIImageView()
    private let startScanButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        recommendLabel.do {
            $0.font = .boldSystemFont(ofSize: 20)
            $0.text = "오늘의 주류 추천"            
        }
        
        recommendImage.do {
            $0.image = UIImage(named: "testImage")
        }
        
        startScanButton.do {
            $0.setTitle("주류 스캔", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.addTarget(self, action: #selector(startScanButtonTapped), for: .touchUpInside)
        }
    }
    
    private func setLayout() {
        view.addSubview(recommendImage)
        view.addSubview(recommendLabel)
        view.addSubview(startScanButton)
        
        recommendImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(150)
        }
        
        recommendLabel.snp.makeConstraints { make in
            make.bottom.equalTo(recommendImage.snp.top).offset(-20)
            make.centerX.equalToSuperview()
        }
        
        startScanButton.snp.makeConstraints { make in
            make.top.equalTo(recommendImage.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func startScanButtonTapped() {
        let liquorScanVC = LiquorScanViewController()
        let navVC = UINavigationController(rootViewController: liquorScanVC)
        navVC.modalPresentationStyle = .fullScreen
        navigationController?.present(navVC, animated: true)
    }
    
}
