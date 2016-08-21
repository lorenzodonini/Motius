//
//  Usecase.swift
//  Motius
//
//  Created by Lorenzo Donini on 20/08/16.
//  Copyright © 2016 Motius GmbH. All rights reserved.
//

import Foundation

struct Usecase {
    let title: String
    let body: String
    
    init?(json: [String: AnyObject]) {
        guard let title = json["title"] as? String,
            let body = json["body"] as? String else {
            return nil
        }
        self.title = title
        self.body = body
    }
    
    static func parseFromRawArray(rawUsecases: [AnyObject]) -> [Usecase]? {
        var usecases = [Usecase]()
        for rawUsecase in rawUsecases {
            guard let jsonContent = rawUsecase as? [String: AnyObject],
                let usecase = Usecase(json: jsonContent) else {
                    //Some error occurred, cannot parse the content of the object
                    return nil
            }
            usecases.append(usecase)
        }
        return usecases
    }
}