//
//  LoginViewController.swift
//  Motius
//
//  Created by Lorenzo Donini on 18/08/16.
//  Copyright © 2016 Motius GmbH. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login() {
        //Creating controller for the dialog window
        let alertController = UIAlertController(title: "Hello Motius", message: "", preferredStyle: .Alert)
        //Creation ok action for the dialog
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)
        //Showing the dialog
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

