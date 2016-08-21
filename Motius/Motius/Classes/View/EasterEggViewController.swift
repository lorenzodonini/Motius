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
    }
    
    override func viewWillAppear(animated: Bool) {
        currentStatus = "Walking in tall grass..."
        catchButton.hidden = true
        //Choosing a random element out of the database
        let randomChoice = Int(arc4random_uniform(UInt32(db.count)))
        if let url = NSURL(string: "https://img.pokemondb.net/artwork/\(db[randomChoice]).jpg") {
            //Download image asynchronously for randomly chosen element
            apiManager.getImageFromUrl(url) { (data: NSData?, error: ErrorType?) in
                if let data = data {
                    self.downloadedImage = data
                    self.currentStatus = "A Wild Pokémon has just appeared!"
                } else if let error = error {
                    self.downloadedImage = nil
                    self.currentStatus = "\(error)"
                } else {
                    self.downloadedImage = nil
                    self.currentStatus = "Unknown error occurred!"
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.refreshEasterEgg()
                })
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        downloadedImage = nil
        currentStatus = nil
        apiManager.cancelLastImageTask()
    }
    
    //MARK: Domain logic
    private func refreshEasterEgg() {
        statusLabel.text = currentStatus ?? ""
        guard let downloadedImage = downloadedImage else {
            pkImageView.image = nil
            return
        }
        guard let image = UIImage(data: downloadedImage) else {
            currentStatus = "Invalid data was downloaded!"
            return
        }
        pkImageView.image = image
        //Showing pokemon via animation
        pkImageView.alpha = 0
        UIView.animateWithDuration(3.0, animations: {
            self.pkImageView.alpha = 1
            }) { _ in
                self.catchButton.hidden = false
        }
    }
    
    @IBAction func catchIt() {
        //Creating controller for the dialog window
        let alertController = UIAlertController(title: "Got it!", message: "", preferredStyle: .Alert)
        //Creation ok action for the dialog
        let okAction = UIAlertAction(title: "Cool", style: .Default, handler: { _ -> Void in
            //Resetting everything
            self.currentStatus = "Walking in tall grass..."
            self.pkImageView.image = nil
            self.downloadedImage = nil
            self.catchButton.hidden = true
        })
        alertController.addAction(okAction)
        //Showing the dialog
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}
