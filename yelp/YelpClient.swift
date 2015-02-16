//
//  YelpClient.swift
//  yelp
//
//  Created by Josh Lubaway on 2/9/15.
//  Copyright (c) 2015 Frustrated Inc. All rights reserved.
//

import Foundation

class YelpClient: BDBOAuth1RequestOperationManager {

    let accessSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"
    let accessToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
    let consumerKey = "vxKwwcR_NMQ7WaEiQBK_CA"
    let consumerSecret = "33QCvh5bIF5jIHR5klQr7RtBDhQ"

    let baseUrl = NSURL(string: "http://api.yelp.com/v2/")!

    // The parent class is insisting that we re-define this initializer.
    // So we re-define it to do nothing... =/
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init() {
        super.init(baseURL: baseUrl, consumerKey: consumerKey, consumerSecret: consumerSecret)

        let credential = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(credential)
    }

    func search(query: String, options: NSDictionary, block: (AFHTTPRequestOperation!, NSDictionary, NSError?) -> Void) {
        var parameters = ["term": query, "location": "San Francisco"]
        
        if let categories = options["categories"] as? [String] {
            if categories.count > 0 {
                let str = ",".join(categories)
                println(str)
                parameters["category_filter"] = str
            }
        }

        println(parameters)

        func success(request: AFHTTPRequestOperation!, obj: AnyObject!) {
            block(request, obj as NSDictionary, nil)
        }
        func fail(request: AFHTTPRequestOperation!, error: NSError!) {
            block(request, [:], error)
        }

        self.GET("search", parameters: parameters, success: success, failure: fail)
    }
}
