//
//  ViewController.swift
//  yelp
//
//  Created by Josh Lubaway on 2/9/15.
//  Copyright (c) 2015 Frustrated Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FilterViewDelegate, UISearchBarDelegate {

    var restaurants: [Restaurant] = []
    var searchBar: UISearchBar!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterBarButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0

        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 260, height: 20))
        searchBar.placeholder = "Search"
        searchBar.delegate = self
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

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.endEditing(true)
        search()
    }

    @IBAction func onTap(sender: AnyObject) {
        println("tap")
        searchBar.endEditing(true)
    }

    func search() {
        var query = searchBar.text
        let yelp = YelpClient()

        if query == "" {
            println("You didn't type anything")
            query = "restaurants"
        } else {
            println("Searching for \(query)")
        }

        MBProgressHUD.showHUDAddedTo(self.view, animated: true)

        yelp.search(query) { (request, responseDict, error) in
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
        searchBar.endEditing(true)
    }

}

