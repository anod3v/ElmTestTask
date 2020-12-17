//
//  ViewController.swift
//  ElmTestTask
//
//  Created by Andrey on 17/12/2020.
//  Copyright © 2020 Andrey Anoshkin. All rights reserved.
//

import UIKit
import PromiseKit

class FeedViewController: UIViewController, FeedTableViewCellDelegate {
    
    var networkService = NetworkService()
    
    var items = [FeedItem]()
    
    var cellHeight: CGFloat = 0
    
    var cell = UITableViewCell()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var userDictionary = [String: [FeedItem]]()
    
    var userSectionTitles = [String]()
    
    let cellID = "FeedTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.getData(method: "posts").done { result in
            self.handleGetFeedResponse(items: result)
        }
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.pin(to: view)
        
        getUsersDictionary()

    }

    func handleGetFeedResponse(items: [FeedItem]) {
        self.items = items
        
        DispatchQueue.main.async { self.tableView.reloadData() }
    }

    
    func revealPost(for cell: FeedTableViewCell) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func getUsersDictionary() {
        
        var itemsToDisplay = [FeedItem]()
        
        userDictionary = [String: [FeedItem]]()
        
        userSectionTitles = [String]()
        
        itemsToDisplay = items

        
        for item in itemsToDisplay {
            let itemKey = String(item.userID)
            if var itemValues = userDictionary[itemKey] {
                itemValues.append(item)
                userDictionary[itemKey] = itemValues
            } else {
                userDictionary[itemKey] = [item]
            }
            userSectionTitles = [String](userDictionary.keys)
//            userSectionTitles = userSectionTitles.sorted(by: { $0 < $1 })
            
            userSectionTitles = userSectionTitles.sorted {
                (s1, s2) -> Bool in return s1.localizedStandardCompare(s2) == .orderedAscending
            }
        }
        
    }
    
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        getUsersDictionary()
        return userSectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return userSectionTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return userSectionTitles
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let itemKey = userSectionTitles[section]
        if let itemValues = userDictionary[itemKey] {
            return itemValues.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! FeedTableViewCell
        
        cell.delegate = self
//
//        let item = items[indexPath.row]
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let itemKey = userSectionTitles[indexPath.section]
        if let itemValues = userDictionary[itemKey] {
            cell.configure(item: itemValues[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return cell.bounds.size.height
    }
    
    private func makeIndexSet(lastIndex: Int, _ newsCount: Int) -> [IndexPath] {
        let last = lastIndex + newsCount
        let indexPaths = Array(lastIndex + 1...last).map { IndexPath(row: $0, section: 0) }
        
        return indexPaths
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postFullSizeViewController = PostFullSizeViewController()
        guard items.count >= 1 else { return }
        let item = items[indexPath.row]
        postFullSizeViewController.configure(item: item)

        self.show(postFullSizeViewController, sender: nil)
    }
    
}


