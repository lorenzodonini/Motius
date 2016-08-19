//
//  LoginViewController.swift
//  Motius
//
//  Created by Lorenzo Donini on 18/08/16.
//  Copyright © 2016 Motius GmbH. All rights reserved.
//

import UIKit
import FontAwesome_swift

class LoginViewController: UIViewController {

    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setting custom icon for login tab bar item
        self.tabBarItem.image = UIImage.fontAwesomeIconWithName(FontAwesome.SignIn, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login() {
    }
}

