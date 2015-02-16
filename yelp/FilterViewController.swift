//
//  FilterViewController.swift
//  yelp
//
//  Created by Josh Lubaway on 2/12/15.
//  Copyright (c) 2015 Frustrated Inc. All rights reserved.
//

import UIKit

protocol FilterViewDelegate {
    func filtersChanged(dict: NSDictionary)
}

struct Category {
    let title: String
    let key: String
    var on: Bool
}

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FilterCellDelegate {

    var delegate: FilterViewDelegate!
    var categories: [Category] = [
        Category(title: "Chinese", key: "chinese", on: false),
        Category(title: "Italian", key: "italian", on: false),
        Category(title: "Japanese", key: "japanese", on: false),
        Category(title: "Mexican", key: "mexican", on: false),
        Category(title: "Thai", key: "thai", on: false)
    ]
    var settings: [String: [String]] = [:]

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50

        settings["categories"] = []

        println("View did load")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        for category in categories {
            println("\(category.title) is \(category.on)")
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("filter-cell") as FilterTableViewCell
        let category = categories[indexPath.row]

        println("Hydrating cell \(indexPath.row) with \(category.on)")
        cell.hydrate(category, delegate: self, index: indexPath.row)

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
    }

    @IBAction func onApplyButtonPressed(sender: AnyObject) {
        println("Apply button pressed")
        println(delegate)
        navigationController?.popViewControllerAnimated(true)

        var array: [String] = []
        settings["categories"] = []
        for category in categories {
            if category.on {
                array.insert(category.key, atIndex: array.count)
            }
        }

        settings["categories"] = array

        delegate.filtersChanged(settings)
    }

    func categoryChanged(index: Int, on: Bool) {
        println("Controller category \(index) changed to: \(on)")
        categories[index].on = on

        for category in categories {
            println("\(category.title) is \(category.on)")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
