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
}