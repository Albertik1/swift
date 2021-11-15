//
//  DiffableDataSource.swift
//  FoodPin
//
//  Created by NDHU_CSIE on 2021/11/8.
//

import UIKit

enum Section {  //type of the table section
    case all  //one section only
}

class DiffableDataSource: UITableViewDiffableDataSource<Section, Restaurant> {
    //enable editable table cells
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
