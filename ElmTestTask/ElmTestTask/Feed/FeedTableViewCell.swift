//
//  FeedTableViewCell.swift
//  ElmTestTask
//
//  Created by Andrey on 17/12/2020.
//  Copyright © 2020 Andrey Anoshkin. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    weak var delegate: FeedTableViewCellDelegate?
    
    private(set) var isExpanded: Bool = false
    
    private(set) var idLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var bodyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var showMoreButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.titleLabel?.alpha = 0.5
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("more...", for: .normal)
        button.isHidden = false
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        showMoreButton.addTarget(self, action: #selector(showMoreText), for: .touchUpInside)
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        contentView.addSubview(idLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
        contentView.addSubview(showMoreButton)
    }
    
    @objc func showMoreText() {
        isExpanded = !isExpanded
        
        bodyLabel.numberOfLines = isExpanded ? 0 : 2
        showMoreButton.setTitle(isExpanded ? "less..." : "more...", for: .normal)
        delegate?.revealPost(for: self)
    }
    
    func configure(item: FeedItem) {
        isExpanded = false
        idLabel.text = "Id: " + String(item.id)
        titleLabel.text = "Title: " + item.title
        bodyLabel.text = "Body: " + item.body
        
        if bodyLabel.calculateMaxLines() <= 2 {
            showMoreButton.isHidden = true
        } else {
            showMoreButton.isHidden = false
        }
        bodyLabel.numberOfLines = 2
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            idLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            idLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            showMoreButton.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor),
            showMoreButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            showMoreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            showMoreButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
        ])
    }
}

protocol FeedTableViewCellDelegate: class {
    func revealPost(for cell: FeedTableViewCell)
}


