//
//  ApiManager.swift
//  Motius
//
//  Created by Lorenzo Donini on 20/08/16.
//  Copyright © 2016 Motius GmbH. All rights reserved.
//

import Foundation

class ApiManager {
    private let session = NSURLSession.sharedSession()
    private var lastImageTask: NSURLSessionDataTask?
    
    //MARK: REST APIs
    func getUsecases(completionHandler: ([Usecase]?, ErrorType?) -> ()) {
        if let url = NSURL(string: "https://www.motius.de/api/usecases/") {
            let urlRequest = NSMutableURLRequest(URL: url)
            //Creating an asynchronous URL task
            let task = session.dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
                if let response = response as? NSHTTPURLResponse,
                    let data = data {
                    if response.statusCode == 200 {
                        //Creating the Usecase objects
                        if let rawUsecases = fromJSONArray(data),
                            let usecases = Usecase.parseFromRawArray(rawUsecases) {
                            //Pass the usecases to the completion handler
                            completionHandler(usecases, nil)
                        }
                    } else {
                        completionHandler(nil, error)
                    }
                }
            }
            //Starting task
            task.resume()
        }
    }
    
    //MARK: Image downloading calls
    func getImageFromUrl(url: NSURL, completionHandler: (NSData?, ErrorType?) -> ()) {
        let task = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            //Passing result to completion handler right away
            completionHandler(data, error)
        }
        lastImageTask = task
        //Starting task
        task.resume()
    }
    
    func cancelLastImageTask() {
        if let task = lastImageTask
            where task.state == .Completed {
            task.cancel()
            lastImageTask = nil
        }
    }
}