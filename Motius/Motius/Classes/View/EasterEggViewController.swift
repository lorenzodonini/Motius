//
//  EasterEggViewController.swift
//  Motius
//
//  Created by Lorenzo Donini on 18/08/16.
//  Copyright © 2016 Motius GmbH. All rights reserved.
//

import UIKit

class EasterEggViewController: UIViewController {
    private let db = ["bulbasaur","charmander","squirtle","pikachu","magikarp","slowpoke"]
    private let apiManager = ApiManager()
    private var downloadedImage: NSData?
    private var currentStatus: String? {
        didSet {
            statusLabel.text = currentStatus ?? ""
        }
    }
    
    @IBOutlet var pkImageView: UIImageView!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var catchButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
