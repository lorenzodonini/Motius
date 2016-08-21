//
//  MainViewController.swift
//  Motius
//
//  Created by Lorenzo Donini on 19/08/16.
//  Copyright © 2016 Motius GmbH. All rights reserved.
//

import UIKit
import FontAwesome_swift

class MainViewController: UITabBarController {
    private let motiusApiManager = ApiManager()

    override func viewDidLoad() {
        super.viewDidLoad()        
        
        //Instead of setting images through storyboard, I'm presetting the TabBar icons programmatically, exploiting the FontAwesome pod
        self.tabBar.items?[0].image = UIImage.fontAwesomeIconWithName(.User, textColor: UIColor.whiteColor(), size: CGSizeMake(30, 30))
        self.tabBar.items?[1].image = UIImage.fontAwesomeIconWithName(.Star, textColor: UIColor.whiteColor(), size: CGSizeMake(30, 30))
        self.tabBar.items?[2].image = UIImage.fontAwesomeIconWithName(.Beer, textColor: UIColor.whiteColor(), size: CGSizeMake(30, 30))
        self.tabBar.tintColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
