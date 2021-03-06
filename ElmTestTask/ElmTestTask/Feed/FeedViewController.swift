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
    
    private let rootView = FeedView()
    
    private(set) var networkService = NetworkService()
    
    private(set) var items = [FeedItem]()
    
    private(set) var cellHeight: CGFloat = 0
    
    private(set) var cell = UITableViewCell()
    
    private(set) var userDictionary = [String: [FeedItem]]()
    
    private(set) var userSectionTitles = [String]()
    
    private let cellID = "FeedTableViewCell"
    
    init() {
        super.init(nibName: .none, bundle: .none)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.getData(method: "posts").done { result in
            self.handleGetFeedResponse(items: result)
        }
        
        getUsersDictionary()
        
    }
    
    func setup() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        rootView.tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    func handleGetFeedResponse(items: [FeedItem]) {
        self.items = items
        
        DispatchQueue.main.async { self.rootView.tableView.reloadData() }
    }
    
    
    func revealPost(for cell: FeedTableViewCell) {
        rootView.tableView.beginUpdates()
        rootView.tableView.endUpdates()
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
            
            userSectionTitles = userSectionTitles.sorted {
                (s1, s2) -> Bool in return s1.localizedStandardCompare(s2) == .orderedAscending
            }
        }
        
    }
    
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        getUsersDictionary()
        return userSectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "USER ID:" + userSectionTitles[section]
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postFullSizeViewController = PostFullSizeViewController()
        guard items.count >= 1 else { return }
        
        let itemKey = userSectionTitles[indexPath.section]
        if let itemValues = userDictionary[itemKey] {
            postFullSizeViewController.configure(item: itemValues[indexPath.row])
        }
        self.show(postFullSizeViewController, sender: nil)
    }
    
}


