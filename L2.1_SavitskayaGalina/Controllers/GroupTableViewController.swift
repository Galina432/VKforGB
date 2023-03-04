//
//  GroupTableViewController.swift
//  L2.1_SavitskayaGalina
//
//  Created by Galina on 22.04.2022.
//

import UIKit

class GroupTableViewController: UITableViewController {
    
    var filteredGroups = [GroupClass]()
    
    @IBOutlet var searchBarGroups: UISearchBar! {
        didSet {
            searchBarGroups.delegate = self
        }
    }
    
    let groupsAllOld = [
    
        GroupClass(image: UIImage(named: "flowers"), name: "Цветы"),
        GroupClass(image: UIImage(named: "nature"), name: "Природа"),
        GroupClass(image: UIImage(named: "remont"), name: "Школа ремонта")
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadGroupSearch(searchText: "Школа ремонта")
        
        filteredGroups = groupsAllOld
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell else {
            preconditionFailure("Error cell")
            
        }
        
        cell.groupNameLabel2.text = filteredGroups[indexPath.row].name
        cell.groupImageView2.image = filteredGroups[indexPath.row].image
        
        return cell
    }
}

extension GroupTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            filteredGroups = groupsAllOld
        } else {
            filteredGroups = groupsAllOld.filter {$0.name.contains(searchText)}
        }
        
        tableView.reloadData()
        
    }
}

