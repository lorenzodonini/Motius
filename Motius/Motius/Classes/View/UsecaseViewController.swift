//
//  UsecaseViewController.swift
//  Motius
//
//  Created by Lorenzo Donini on 18/08/16.
//  Copyright © 2016 Motius GmbH. All rights reserved.
//

import UIKit
import FontAwesome_swift

class UsecaseViewController: UIViewController {
    private let apiManager = ApiManager()
    private var usecases: [Usecase]?
    private let defaultUsecaseIcons = [
        UIImage.fontAwesomeIconWithName(.FileText, textColor: UIColor.blackColor(), size: CGSizeMake(55, 55)),
        UIImage.fontAwesomeIconWithName(.Cloud, textColor: UIColor.blackColor(), size: CGSizeMake(55, 55)),
        UIImage.fontAwesomeIconWithName(.Mobile, textColor: UIColor.blackColor(), size: CGSizeMake(55, 55)),
        UIImage.fontAwesomeIconWithName(.PieChart, textColor: UIColor.blackColor(), size: CGSizeMake(55, 55))
    ]
    private static let cellIdentifier = "usecaseCell"
    
    @IBOutlet var tableView: UITableView!
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(UsecaseViewController.loadUsecases), forControlEvents: UIControlEvents.ValueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refreshControl)
        
        //Load use cases through the network
        loadUsecases()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc internal func loadUsecases() {
        refreshControl.beginRefreshing()
        apiManager.getUsecases { (usecases: [Usecase]?, error: ErrorType?) in
            if let usecases = usecases {
                self.usecases = usecases
            } else if let error = error {
                self.usecases = nil
                print("Error occurred while receiving usecases: \(error)")
            } else {
                self.usecases = nil
                print("Unknown error occurred!")
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            })
        }
    }
}

extension UsecaseViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //TODO: implement
    }
}

extension UsecaseViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usecases?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(UsecaseViewController.cellIdentifier, forIndexPath: indexPath)
        
        if let usecase = usecases?[indexPath.row],
            let usecaseCell = cell as? UsecaseViewCell {
            usecaseCell.titleLabel.text = usecase.title
            usecaseCell.bodyLabel.text = usecase.body
            usecaseCell.usecaseImageView.image = defaultUsecaseIcons[indexPath.row % defaultUsecaseIcons.count]
            return usecaseCell
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 64.0
    }
}
