//
//  FilterTableViewCell.swift
//  yelp
//
//  Created by Josh Lubaway on 2/12/15.
//  Copyright (c) 2015 Frustrated Inc. All rights reserved.
//

import UIKit

protocol FilterCellDelegate {
    func categoryChanged(index: Int, on: Bool)
}

class FilterTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var onOffSwitch: UISwitch!

    var delegate: FilterCellDelegate!
    var index: Int!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func hydrate(category: Category, delegate d: FilterCellDelegate, index i: Int) {
        titleLabel.text = category.title
        onOffSwitch.on = category.on
        delegate = d
        index = i
    }

    @IBAction func switchDidChange(sender: UISwitch) {
        println(sender.on)
        delegate.categoryChanged(index, on: sender.on)
    }
}
