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
        let findDrinkVC = FindDrinkViewController()
        let myDrinkVC = MyDrinkViewController()
        self.setViewControllers([findDrinkVC, myDrinkVC], animated: false)
        
        guard let items = tabBar.items else { return }
        items[0].title = "Find Drink"
        items[1].title = "My Drink"        
    }

}
