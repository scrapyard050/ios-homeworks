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
        author.translatesAutoresizingMaskIntoConstraints = false
        author.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        author.textColor = .black
        author.numberOfLines = 2
        return author
    }()
    
    private let postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
   
    private let descriptionPost: UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.font = .systemFont(ofSize: 14)
        description.textColor = .systemGray
        description.numberOfLines = 0
        return description
    }()
    
    private let likes: UILabel = {
        let likes = UILabel()
        likes.translatesAutoresizingMaskIntoConstraints = false
        likes.font = .systemFont(ofSize: 16)
        likes.textColor = .black
        return likes
    }()
    private let views: UILabel = {
        let views = UILabel()
        views.translatesAutoresizingMaskIntoConstraints = false
        views.font = .systemFont(ofSize: 16)
        views.textColor = .black
        return views
    }()

    private func setupComponents() {
        // настраиваем оторабражание компонентов
        contentView.addSubview(self.author)
        contentView.addSubview(self.postImage)
        contentView.addSubview(self.descriptionPost)
        contentView.addSubview(self.likes)
        contentView.addSubview(self.views)
        
        [
            self.author.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            self.author.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            self.author.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            self.postImage.topAnchor.constraint(equalTo: self.author.bottomAnchor, constant: 12.0),
            self.postImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.postImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.postImage.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            self.postImage.heightAnchor.constraint(equalTo: self.postImage.widthAnchor),
            self.descriptionPost.topAnchor.constraint(equalTo: self.postImage.bottomAnchor, constant: 16),
            self.descriptionPost.leadingAnchor.constraint(equalTo: self.author.leadingAnchor),
            self.descriptionPost.trailingAnchor.constraint(equalTo: self.author.trailingAnchor),
            self.likes.leadingAnchor.constraint(equalTo: self.descriptionPost.leadingAnchor) ,
            self.likes.topAnchor.constraint(equalTo: self.descriptionPost.bottomAnchor, constant: 16),
            self.likes.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            self.views.trailingAnchor.constraint(equalTo: self.descriptionPost.trailingAnchor),
            self.views.topAnchor.constraint(equalTo: self.likes.topAnchor),
            self.views.bottomAnchor.constraint(equalTo: self.likes.bottomAnchor)
        ].forEach{ $0.isActive = true}
        
        selectionStyle = .none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupComponents()
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
