//
//  RestaurantTableViewCell.swift
//  yelp
//
//  Created by Josh Lubaway on 2/9/15.
//  Copyright (c) 2015 Frustrated Inc. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        photoView.layer.cornerRadius = 5
        photoView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func hydrate(restaurant: Restaurant) {
        titleLabel.text = restaurant.name
        photoView.setImageWithURL(restaurant.imageUrl)
        ratingLabel.text = "\(restaurant.rating)"
        ratingImageView.setImageWithURL(restaurant.ratingImgUrl)
        
        let neighborhoods = "/".join(restaurant.neighborhoods)
        addressLabel.text = "\(restaurant.address). (\(neighborhoods))"
        categoriesLabel.text = ", ".join(restaurant.categories)

        titleLabel.preferredMaxLayoutWidth = titleLabel.frame.size.width
        addressLabel.preferredMaxLayoutWidth = addressLabel.frame.size.width
    }
}
