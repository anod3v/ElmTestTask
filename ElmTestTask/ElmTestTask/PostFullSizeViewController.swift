//
//  PostFullSizeViewController.swift
//  ElmTestTask
//
//  Created by Andrey on 17/12/2020.
//  Copyright © 2020 Andrey Anoshkin. All rights reserved.
//

import UIKit

class PostFullSizeViewController: UIViewController {
    
    var selectedFeedItem: FeedItem?
    
    var userIdLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var idLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var bodyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        setupConstraints()
    }
    
    func addViews() {
        self.view.addSubview(userIdLabel)
        self.view.addSubview(idLabel)
        self.view.addSubview(titleLabel)
        self.view.addSubview(bodyLabel)
    }
    
    func configure(item: FeedItem) {
        userIdLabel.text = "User ID: " + String(item.userID)
        idLabel.text = "Id: " + String(item.id)
        titleLabel.text = "Title: " + item.title
        bodyLabel.text = "Body: " + item.body
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            userIdLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            userIdLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userIdLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            idLabel.topAnchor.constraint(equalTo: userIdLabel.bottomAnchor, constant: 20),
            idLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            idLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            bodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
        ])
    }
}

