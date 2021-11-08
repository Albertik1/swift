//
//  RestaurantDetailHeaderView.swift
//  FoodPin
//
//  Created by NDHU_CSIE on 2020/11/26.
//  Copyright © 2020 NDHU_CSIE. All rights reserved.
//

import UIKit

class RestaurantDetailHeaderView: UIView {

    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var heartImageView: UIImageView! {
        didSet {
            heartImageView.image = UIImage(named: "heart-tick")?.withRenderingMode(.alwaysTemplate)
            heartImageView.tintColor = .white
        }
    }
    
    @IBOutlet var ratingImageView: UIImageView!

}
