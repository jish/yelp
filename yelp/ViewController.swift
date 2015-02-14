//
//  ViewController.swift
//  yelp
//
//  Created by Josh Lubaway on 2/9/15.
//  Copyright (c) 2015 Frustrated Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FilterViewDelegate {

    var restaurants: [Restaurant] = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterBarButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0

        var searchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 260, height: 20))
        searchBar.placeholder = "Search"

        navigationItem.titleView = searchBar
        
        search()
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

    func filtersChanged(dict: NSDictionary) {
        println("RootViewController#filtersChanged")
        search()
    }

    func search() {
        let query = "restaurants"
        let yelp = YelpClient()

        MBProgressHUD.showHUDAddedTo(self.view, animated: true)

        yelp.search("restaurants") { (request, responseDict, error) in
            let businesses = responseDict["businesses"] as NSArray

            println(businesses[0])
            MBProgressHUD.hideHUDForView(self.view, animated: true)

            let restaurants = map(businesses) { (business) -> Restaurant in
                return Restaurant(dictionary: business as NSDictionary)
            }

            self.restaurants = restaurants
            self.tableView.reloadData()
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as FilterViewController
        controller.delegate = self
    }

}

