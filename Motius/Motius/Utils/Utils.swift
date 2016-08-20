//
//  Utils.swift
//  Motius
//
//  Created by Lorenzo Donini on 20/08/16.
//  Copyright © 2016 Motius GmbH. All rights reserved.
//

import Foundation

func fromJSONArray(data: NSData) -> [AnyObject]? {
    do {
        let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [AnyObject]
        return json
    } catch {
        print("Couldn't parse JSON Object: \(error)")
        return nil
    }
}