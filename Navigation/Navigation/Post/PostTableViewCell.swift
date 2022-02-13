//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Антон Соколов on 23.12.2021.
//

import UIKit
class PostTableViewCell : UITableViewCell {
    static let tableViewCellId = "myCell"
    
    private let author: UILabel = {
        let author = UILabel()
        author.toAutoLayout()
        author.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        author.textColor = .black
        author.numberOfLines = 2
        return author
    }()
    
    private let postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
   
    private let descriptionPost: UILabel = {
        let description = UILabel()
        description.toAutoLayout()
        description.font = .systemFont(ofSize: 14)
        description.textColor = .systemGray
        description.numberOfLines = 0
        return description
    }()
    
    private let likes: UILabel = {
        let likes = UILabel()
        likes.toAutoLayout()
        likes.font = .systemFont(ofSize: 16)
        likes.textColor = .black
        return likes
    }()
    private let views: UILabel = {
        let views = UILabel()
        views.toAutoLayout()
        views.font = .systemFont(ofSize: 16)
        views.textColor = .black
        return views
    }()

    private func prepareUI() {
        // настраиваем оторабражание компонентов
        contentView.addSubviews(self.author,
                                self.postImage,
                                self.descriptionPost,
                                self.likes,
                                self.views)
        let constraints =
        [
            self.author.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.defaultMargin),
            self.author.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.defaultMargin),
            self.author.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.defaultMargin),
            self.postImage.topAnchor.constraint(equalTo: self.author.bottomAnchor, constant: Constants.postImageTopMargin),
            self.postImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.postImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.postImage.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            self.postImage.heightAnchor.constraint(equalTo: self.postImage.widthAnchor),
            self.descriptionPost.topAnchor.constraint(equalTo: self.postImage.bottomAnchor, constant: Constants.defaultMargin),
            self.descriptionPost.leadingAnchor.constraint(equalTo: self.author.leadingAnchor),
            self.descriptionPost.trailingAnchor.constraint(equalTo: self.author.trailingAnchor),
            self.likes.leadingAnchor.constraint(equalTo: self.descriptionPost.leadingAnchor) ,
            self.likes.topAnchor.constraint(equalTo: self.descriptionPost.bottomAnchor, constant: Constants.defaultMargin),
            self.likes.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.defaultMargin),
            self.views.trailingAnchor.constraint(equalTo: self.descriptionPost.trailingAnchor),
            self.views.topAnchor.constraint(equalTo: self.likes.topAnchor),
            self.views.bottomAnchor.constraint(equalTo: self.likes.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        selectionStyle = .none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.prepareUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(extendedPost: ExtendedPost) {
        self.author.text = extendedPost.author
        self.descriptionPost.text = extendedPost.description
        self.likes.text = "Likes: \(extendedPost.likes)"
        self.views.text = "Views: \(extendedPost.views)"
        self.postImage.image = UIImage(named: extendedPost.image)
        
    }
}
