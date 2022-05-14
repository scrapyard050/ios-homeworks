//
//  DocumentsViewCellTableViewCell.swift
//  Navigation
//
//  Created by Антон Соколов on 14.05.2022.
//

import UIKit

/// @brief Класс определяет ячейку в которой отображается содержимое директории
class DocumentsTableViewCell: UITableViewCell {
    static let tableViewCellId = "myDocumentsCell"
    private let contentsImage: UIImageView = {
        let contentsImage = UIImageView()
        contentsImage.toAutoLayout()
        contentsImage.contentMode = .scaleAspectFit
        contentsImage.backgroundColor = .white
        return contentsImage
    }()
   
   
    /// @brief Настраиваем констрейнты для отображения картинки в ячейке
    private func prepareUI() {
        contentView.addSubviews( self.contentsImage)
        let constraints =
        [
            self.contentsImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.contentsImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.contentsImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.contentsImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            self.contentsImage.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            self.contentsImage.heightAnchor.constraint(equalTo: self.contentView.heightAnchor),
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
    
    /// @brief  Передаем путь до картинки
    func setupCell(path: String) {
        self.contentsImage.image = UIImage(named: path)
        
    }

}
