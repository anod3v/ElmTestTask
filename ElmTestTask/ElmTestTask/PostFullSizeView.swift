//
//  PostFullSizeView.swift
//  ElmTestTask
//
//  Created by Andrey on 17/12/2020.
//  Copyright © 2020 Andrey Anoshkin. All rights reserved.
//

import UIKit

class PostFullSizeView: UIView {
    
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
    
    init() {
        super.init(frame: .zero)
        addViews()
        setNeedsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubview(userIdLabel)
        self.addSubview(idLabel)
        self.addSubview(titleLabel)
        self.addSubview(bodyLabel)
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            
            userIdLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            userIdLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            userIdLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            idLabel.topAnchor.constraint(equalTo: userIdLabel.bottomAnchor, constant: 20),
            idLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            idLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            bodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
        ])
        super.updateConstraints()
    }
    
}
