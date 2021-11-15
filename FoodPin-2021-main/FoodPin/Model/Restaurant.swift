//
//  Restaurant.swift
//  FoodPin
//
//  Created by NDHU_CSIE on 2021/11/8.
//

import Foundation

//the Hashable protocol is needed for Diffable Data Source
struct Restaurant: Hashable {
    var name: String = ""
    var image: String = ""
    var poster: String = ""
    var isFavorite: Bool = false
    var isNotFavorite: Bool = false
}

//extend the defintion of an existing structure or class
extension Restaurant {
    //class-level method function
    static func generateData( sourceArray: inout [Restaurant]) {
        sourceArray = [
            Restaurant(name: "Baseball",  image: "baseball.png", poster: "baseball_photo.jpg"),
            Restaurant(name: "Basketball", image: "basketball.png", poster: "basketball_photo.jpg"),
            Restaurant(name: "Football", image: "football.png", poster: "football_photo.jpg"),
            Restaurant(name: "Other", image: "other.png", poster: "other_photo.jpg"),
            
        ]
    }
    
}
