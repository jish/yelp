//
//  ViewController.swift
//  yelp
//
//  Created by Josh Lubaway on 2/9/15.
//  Copyright (c) 2015 Frustrated Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var restaurants: [Restaurant] = []

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        let yelp = YelpClient()
        yelp.search("chinese") { (request, responseDict, error) in
            let businesses = responseDict["businesses"] as NSArray

            println(businesses[0])

            let restaurants = map(businesses) { (business) -> Restaurant in
                return Restaurant(dictionary: business as NSDictionary)
            }

            self.restaurants = restaurants
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("restaurant-cell") as RestaurantTableViewCell
        let restaurant = restaurants[indexPath.row] as Restaurant
        
        cell.hydrate(restaurant)

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
    }
}

