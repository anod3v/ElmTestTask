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
    
    var isExpanded: Bool = false
    
    //    var profileView: ProfileView = {
    //        let view = ProfileView()
    ////        view.backgroundColor = .brown
    //
    //        view.translatesAutoresizingMaskIntoConstraints = false
    //        return view
    //    }()
    //
    //    var photoCollageView: PhotoCollageView = {
    //        let view = PhotoCollageView()
    ////        view.backgroundColor = .green
    //
    //        view.translatesAutoresizingMaskIntoConstraints = false
    //        return view
    //    }()
    //
    //    var likeBarView: LikeBarView = {
    //        let view = LikeBarView()
    ////        view.backgroundColor = .orange
    //
    //        view.translatesAutoresizingMaskIntoConstraints = false
    //        return view
    //    }()
    
    var userIdLabel: UILabel = {
        let label = UILabel()
        //        label.font = Constants.Fonts.regularOfSize16
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        //        label.backgroundColor = .systemYellow
        label.sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var idLabel: UILabel = {
        let label = UILabel()
        //            label.font = Constants.Fonts.regularOfSize16
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        //        label.backgroundColor = .systemYellow
        label.sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        //            label.font = Constants.Fonts.regularOfSize16
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        //        label.backgroundColor = .systemYellow
        label.sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var bodyLabel: UILabel = {
        let label = UILabel()
        //            label.font = Constants.Fonts.regularOfSize16
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        //        label.backgroundColor = .systemYellow
        label.sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var showMoreButton: UIButton = {
        let button = UIButton()
        //        button.titleLabel?.font = Constants.Fonts.regularOfSize16
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal) // TODO to put colors in constants
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
        contentView.addSubview(userIdLabel)
        contentView.addSubview(idLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
        contentView.addSubview(showMoreButton)
    }
    
    @objc func showMoreText() {
        //        print("more text button is pressed")
        isExpanded = !isExpanded
        
        bodyLabel.numberOfLines = isExpanded ? 0 : 2
        showMoreButton.setTitle(isExpanded ? "less..." : "more...", for: .normal)
        delegate?.revealPost(for: self)
    }
    
    func configure(item: FeedItem) {
        isExpanded = false
        userIdLabel.text = String(item.userID)
        idLabel.text = String(item.id)
        titleLabel.text = item.title
        bodyLabel.text = item.body
        
        if bodyLabel.calculateMaxLines() <= 2 {
            showMoreButton.isHidden = true
        } else {
            showMoreButton.isHidden = false
        }
        bodyLabel.numberOfLines = 2
        
//        likeBarView.likeCounterLabel.text = String(item.likes?.count ?? 0)
//        likeBarView.viewsCounterLabel.text = String(item.views?.count ?? 0)
//        
//        if let photos = item.attachments?.compactMap({$0?.postPhoto})
//        { photoCollageView.photos  = photos }
//        
//        photoCollageView.collectionView.reloadData()
    }
    
//    func configureProfile(photo: String?, name: String?) {
//
//        let placeHolderImage = UIImage.gifImageWithName("spinner")
//
//        profileView.sourceName.text = name
//        PhotoService.shared.photo(url: photo!) { image in
//            self.profileView.sourceImage.image = image
//        }
//    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            userIdLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            userIdLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            userIdLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            userIdLabel.heightAnchor.constraint(equalToConstant: 50),
            
            idLabel.topAnchor.constraint(equalTo: userIdLabel.bottomAnchor),
            idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            idLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            idLabel.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
        ])
    }
}

protocol FeedTableViewCellDelegate: class {
    func revealPost(for cell: FeedTableViewCell)
}

