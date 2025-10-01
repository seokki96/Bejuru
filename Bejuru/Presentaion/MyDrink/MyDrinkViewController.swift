//
//  MyDrinkViewController.swift
//  Bejuru
//
//  Created by 권석기 on 9/25/25.
//

import UIKit
import SnapKit
import Then

class MyDrinkViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setLayout()
    }
    
    func setStyle() {
        tableView.do {
            $0.rowHeight = 120
            $0.delegate = self
            $0.dataSource = self
            $0.register(LiquorTableViewCell.self, forCellReuseIdentifier: LiquorTableViewCell.identifier)
        }
    }
    
    func setLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LiquorTableViewCell(style: .default, reuseIdentifier: LiquorTableViewCell.identifier)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let liquorDetailVC = LiquorDetailViewController()
        navigationController?.pushViewController(liquorDetailVC, animated: true)
    }
}
