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
    }
    
    private func setLayout() {
        view.addSubview(recommendImage)
        view.addSubview(recommendLabel)
        
        recommendImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(150)
        }
        
        recommendLabel.snp.makeConstraints { make in
            make.bottom.equalTo(recommendImage.snp.top).offset(-20)
            make.centerX.equalToSuperview()
        }
    }

}
