//
//  TableViewController.swift
//  FoodPin
//
//  Created by NDHU_CSIE on 2021/11/1.
//

import UIKit

class TableViewController: UITableViewController {
    
    var restaurants:[Restaurant] = []
    
    @IBOutlet weak var footer: UILabel!
    lazy var dataSource = configureDataSource()

    // MARK: - UITableView Life's Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialized the data source array
        Restaurant.generateData(sourceArray: &restaurants) //pass-by-reference

        tableView.dataSource = dataSource
                
        //Create the snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurants, toSection: .all)

        dataSource.apply(snapshot, animatingDifferences: false)
        
        //configure the navigation title
        navigationController?.navigationBar.prefersLargeTitles = true
    }

  
    // MARK: - UITableView Diffable Data Source

    func configureDataSource() -> DiffableDataSource {
        let cellIdentifier = "datacell"
        
        let dataSource = DiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, restaurant in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
                
                //configure the cell's data
                cell.textLabel?.text = restaurant.name
                cell.imageView?.image = UIImage(named: restaurant.image)
               cell.accessoryType = restaurant.isFavorite ? .checkmark : .none
                if (restaurant.isFavorite){
                    cell.accessoryType = .checkmark
                }
                else {
                    cell.accessoryType = .none
                }
                return cell
            }
        )
        
        return dataSource
    }
    
// handle the table cell selection
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) //return the currently slected cell
//        cell?.accessoryType = .checkmark
//        restaurants[indexPath.row].isFavorite = true
//        
//        tableView.deselectRow(at: indexPath, animated: false)  //de-selection
//    }
    
    
    // MARK: - UITableView Swipe Actions
    
    //swipe-to-right
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        
        let dislikeAction = UIContextualAction(style: .normal, title: "Dislike") { (action, sourceView, completionHandler) in
           //get the selected cell
            self.restaurants[indexPath.row].isFavorite = false
            let cell = tableView.cellForRow(at: indexPath)
           //set the accessoryType of the selected cell to be checked
            cell?.accessoryType = .none
           //set the cell to be selected in the array
           //call the function: self. checkSelection()
            self.checkSelection()
            completionHandler(true)
        }
            
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [dislikeAction])
        
        return swipeConfiguration
    }

    
    //swipe-to-left
     override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
            let likeAction = UIContextualAction(style: .normal, title: "Like") { (action, sourceView, completionHandler) in
               //get the selected cell
                self.restaurants[indexPath.row].isFavorite = true
                let cell = tableView.cellForRow(at: indexPath)
               //set the accessoryType of the selected cell to be checked
                cell?.accessoryType = .checkmark
               //set the cell to be selected in the array
               //call the function: self. checkSelection()
                self.checkSelection()
                completionHandler(true)
            }
                
            let swipeConfiguration = UISwipeActionsConfiguration(actions: [likeAction])
            
            return swipeConfiguration
        }
    func checkSelection() {

          //Check the selection state of each cell
                 //If the cell is selected, append the ball’s name to a result string
         
         //display the result string value on the footer of the table view
        var favorites = ""
        for restaurant in restaurants{
            if restaurant.isFavorite{
                favorites.append(restaurant.name + " ")
            }
            footer.text = "I like: " + favorites
           
        }

        }
     

    
    // MARK: - For Segue's function
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                //get the destination's view controller
                let destinationController = segue.destination as! DetailViewController
                //pass the data from the source side to the destination side
                destinationController.restaurantImageName = restaurants[indexPath.row].poster
            }
        }
    }
    
}
