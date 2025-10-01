//
//  TabbarViewController.swift
//  Bejuru
//
//  Created by 권석기 on 9/25/25.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addTabItems()
    }
    
    func addTabItems() {
        let recommendVC = UINavigationController(rootViewController: LiquorRecommendViewController())
        let myDrinkVC = UINavigationController(rootViewController: MyDrinkViewController())
        self.setViewControllers([recommendVC, myDrinkVC], animated: false)
        
        guard let items = tabBar.items else { return }
        
        items[0].title = "주류찾기"
        items[1].title = "내주류"
        items[0].image = UIImage(systemName: "wineglass")
        items[1].image = UIImage(systemName: "person.crop.circle")
    }

}
