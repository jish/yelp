//
//  Restaurant.swift
//  yelp
//
//  Created by Josh Lubaway on 2/9/15.
//  Copyright (c) 2015 Frustrated Inc. All rights reserved.
//

import Foundation

struct Restaurant {
    let name: String
    let imageUrl: NSURL

    init(dictionary: NSDictionary) {
        name = dictionary["name"] as String
        imageUrl = NSURL(string: dictionary["image_url"] as String)!
    }
}
