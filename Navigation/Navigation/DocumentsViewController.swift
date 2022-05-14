//
//  DocumentsViewController.swift
//  Navigation
//
//  Created by Антон Соколов on 14.05.2022.
//

import UIKit

/// @brief Класс отображает содержимое директории Documents
class DocumentsViewController: UIViewController {
    //weak var coordinator: DocumentsCoordinator?
    var imagePicker: UIImagePickerController = UIImagePickerController()
    var titleInfo: String?
    var fileManager: FileManagerWrapper?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        // регистрируем ячейку и выставляем себя на получение событий от tableView
        tableView.register(DocumentsTableViewCell.self, forCellReuseIdentifier: DocumentsTableViewCell.tableViewCellId)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    /// @brief Настройка UI
    private func setupUI() {
        self.view.backgroundColor = UIColor.white
        self.title = self.titleInfo
        // файловый менеджен для работы с файловой системой
        self.fileManager = FileManagerWrapper()
        // добавляем кнопку добавления фотографий
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.addPhoto, style: .plain, target: self, action: #selector(self.tappedAddPhoto))
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        self.view.addSubviews(self.tableView)
        let constraints =
        [
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    
        guard let fileManager = self.fileManager else {
            return
        }
        
        //проверяем если данныt в директорие документы
        guard !fileManager.isDocumentsDirEmpty() else {
            self.tableView.isHidden = true
            documentsEmptyShowAlert()
            return
        }
    }
    
    /// @brief Отображаем уведомление о необходимости добавить фото
    private func documentsEmptyShowAlert() {
        let alert = UIAlertController(title: Constants.addPhoto, message: Constants.addPleasePhoto, preferredStyle: .alert)
        let ok = UIAlertAction(title: Constants.ok, style: .default, handler: { _ in
            self.dismiss(animated: true) {
                NSLog("Controller is dismissed")
            }
        })
        alert.addAction(ok)
        self.present(alert, animated: true) {
            NSLog("Alert is shown")
        }
    }
    
    /// @brief отображаем контроллер выбора фото
    @objc private func tappedAddPhoto(){
           present(imagePicker, animated: true) {
               print("UIImagePickerController: presented")
           }
       }
}

extension DocumentsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // получаем путь до изобрадения
        guard let  imageURL = info[UIImagePickerController.InfoKey.imageURL] as? NSURL else {
            return
        }
        
        // получаем имя файла
        guard let imageName:String = imageURL.lastPathComponent else {
            return
        }
        
        // получаем выбранное изображение
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        picker.dismiss(animated: true) { [unowned self] in
            guard let fileManager = self.fileManager else {
                return
            }
         
            fileManager.addPhoto(image: selectedImage, name: imageName)
            // перезагружаем таблицу
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            print("dismissed")
        }
    }
}

extension DocumentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section == 0, let cell = tableView.dequeueReusableCell(withIdentifier: DocumentsTableViewCell.tableViewCellId, for: indexPath ) as? DocumentsTableViewCell else { return UITableViewCell()}
        
        guard let fileManager = self.fileManager else {
            return UITableViewCell()
        }
      
        cell.setupCell(path: fileManager.documentsDir()[indexPath.row].path)
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let fileManager = self.fileManager else {
            return 0
        }
        
        return fileManager.documentsDir().count
    }
    
}

extension DocumentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        /// @todo значение выбрано в качестве тестового, чтобы картинки отображались компактно
        return 150 // UITableView.automaticDimension
    }
}
