//
//  PostFullSizeViewController.swift
//  ElmTestTask
//
//  Created by Andrey on 17/12/2020.
//  Copyright © 2020 Andrey Anoshkin. All rights reserved.
//

import UIKit

class PostFullSizeViewController: UIViewController {
    
    let rootView = PostFullSizeView()
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func configure(item: FeedItem) {
        rootView.userIdLabel.text = "User ID: " + String(item.userID)
        rootView.idLabel.text = "Id: " + String(item.id)
        rootView.titleLabel.text = "Title: " + item.title
        rootView.bodyLabel.text = "Body: " + item.body
    }

}

