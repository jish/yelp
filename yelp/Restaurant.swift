//
//  Restaurant.swift
//  yelp
//
//  Created by Josh Lubaway on 2/9/15.
//  Copyright (c) 2015 Frustrated Inc. All rights reserved.
//

import Foundation

struct Restaurant {
    let address: String
    let categories: [String]
    let name: String
    let neighborhoods: [String]
    let imageUrl: NSURL
    let rating: Int
    let ratingImgUrl: NSURL
    let snippet: String

    init(dictionary: NSDictionary) {
        let location = dictionary["location"] as NSDictionary

        if let categoriesList = dictionary["categories"] as? NSArray {
            categories = map(categoriesList) { (x: AnyObject) -> String in
                return x[0] as String
            }
        } else {
            categories = []
        }


        address = (location["address"] as Array)[0]
        neighborhoods = location["neighborhoods"] as Array

        name = dictionary["name"] as String
        imageUrl = NSURL(string: dictionary["image_url"] as String)!
        rating = dictionary["rating"] as Int
        ratingImgUrl = NSURL(string: dictionary["rating_img_url"] as String)!
        snippet = dictionary["snippet_text"] as String
    }
}
