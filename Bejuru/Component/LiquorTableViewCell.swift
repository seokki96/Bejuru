//
//  LiquorTableViewCell.swift
//  Bejuru
//
//  Created by a on 10/2/25.
//

import UIKit

final class LiquorTableViewCell: UITableViewCell {
    
    static let identifier = "LiquorTableViewCell"

    private let liquorImage = UIImageView()
    private let liquorNameLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        liquorNameLabel.do {
            $0.font = .boldSystemFont(ofSize: 20)
            $0.text = "제목"
        }
        
        liquorImage.do {
            $0.backgroundColor = .gray
        }
    }
    
    private func setLayout() {
        addSubview(liquorImage)
        addSubview(liquorNameLabel)
        
        liquorImage.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.verticalEdges.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(10)
        }
        
        liquorNameLabel.snp.makeConstraints { make in
            make.top.equalTo(liquorImage.snp.top)
            make.leading.equalTo(liquorImage.snp.trailing).offset(10)
        }
    }
    
}
