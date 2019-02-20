//
//  TableViewController.swift
//  SearchScope
//
//  Created by Vũ on 2/20/19.
//  Copyright © 2019 Vũ. All rights reserved.
//

import UIKit
extension TableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterForSeachText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension TableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterForSeachText(searchController.searchBar.text!, scope: scope)
    }
    
    
}

class TableViewController: UITableViewController {
    
    //TableView Code
   
    
    
    var candies = [
        Candy(catogery:"Chocolate", name:"Love Sweet"),
        Candy(catogery: "Chocolate", name: "Black Handmade"),
        Candy(catogery: "Chocolate", name: "White Love"),
        Candy(catogery: "Cake", name: "Big Cake"),
        Candy(catogery: "Cake", name: "Weeding Cake"),
        Candy(catogery: "Cake", name: "Pie Cake"),
        Candy(catogery: "Cookies", name: "Chese Cookies"),
        Candy(catogery: "Cookies", name: "Dry Cookies"),
        Candy(catogery: "Cookies", name: "Egg Cookies"),
        Candy(catogery: "Candy", name: "Mashmallow"),
        Candy(catogery: "Candy", name: "Hard Candy"),
        Candy(catogery: "Candy", name: "Lollipop")
    ]
    
    var filterCandies = [Candy]()
    var searchController = UISearchController(searchResultsController: ViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Here!!!"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        searchController.searchBar.delegate = self
        searchController.searchBar.scopeButtonTitles = ["All", "Chocolate", "Cake", "Cookies", "Candy"]
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    func isFiltering() -> Bool {
        let filteringScope = searchController.searchBar.selectedScopeButtonIndex != 0
        return (!searchBarIsEmpty() && searchController.isActive) || filteringScope
    }
    
    func filterForSeachText(_ searchText: String, scope: String = "All") {
        filterCandies = candies.filter({(candy : Candy) -> Bool in
            let doeseCatogeryMatch = (scope == "All") || (candy.catogery == scope)
            if searchBarIsEmpty() {
                return doeseCatogeryMatch
            } else {
                
                return doeseCatogeryMatch && candy.name.lowercased().contains(searchText.lowercased())
            }
        })
        tableView.reloadData()
    }
   


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
          return  filterCandies.count
        } else {
        return candies.count
    }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let candy : Candy
        if isFiltering(){
           candy = filterCandies[indexPath.row]
        } else {
            candy = candies[indexPath.row]
        }
        cell.textLabel?.textColor = UIColor.green
        cell.detailTextLabel?.textColor = UIColor.purple
        cell.textLabel?.text = candy.name
        cell.detailTextLabel?.text = candy.catogery
        
        return cell
    }
    
    
    static func makeInstance() -> ViewController {
        return UIStoryboard(name: "MyStoryboardName", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
    
    // Setup for MainTableView
    
  
    

}
