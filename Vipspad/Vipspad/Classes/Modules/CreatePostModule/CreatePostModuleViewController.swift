//
//  CreatePostModuleViewController.swift
//  Vipspad
//
//  Created by Azure on 31/1/23.
//  
//

import UIKit

class CreatePostModuleViewController: UIViewController {
    
    
    private var imageContext = ImageContext.Image1
    
    private var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .savedPhotosAlbum
        picker.allowsEditing = false
        return picker
    } ()
    
    private lazy var image1Button: UIButton = {
        let button = UIButton()
        button.setTitle("Cargar Imagen", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.orange.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        button.sizeToFit()
        button.clipsToBounds = true
        return button
    } ()
    
    private lazy var image2Button: UIButton = {
        let button = UIButton()
        button.setTitle("Cargar Imagen", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.orange.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        button.clipsToBounds = true
        button.sizeToFit()
        return button
    } ()
    
    private lazy var networksTitle: UILabel = {
        let label = UILabel()
        label.text = "Network :"
        label.textColor = .orange
        return label
    } ()
    
    private lazy var networksPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.layer.borderColor = UIColor.orange.cgColor
        picker.layer.borderWidth = 2
        picker.clipsToBounds = true
        picker.delegate = self
        picker.dataSource = self
        return picker
    } ()
    
    private lazy var risksTitle: UILabel = {
        let label = UILabel()
        label.text = "Risk Index:"
        label.textColor = .orange
        return label
    } ()
    
    private lazy var risksPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.layer.borderColor = UIColor.orange.cgColor
        picker.layer.borderWidth = 2
        picker.clipsToBounds = true
        picker.delegate = self
        picker.dataSource = self
        return picker
    } ()
    
    private lazy var postTitle: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.orange.cgColor
        textField.layer.borderWidth = 1.0
        textField.placeholder = "Call title"
        return textField
    } ()
    
    private lazy var postBody: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.orange.cgColor
        textField.layer.borderWidth = 1.0
        textField.placeholder = "Call body"
        return textField
    } ()
    
    private lazy var discordUrl: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.orange.cgColor
        textField.layer.borderWidth = 1.0
        textField.placeholder = "Discord Url"
        return textField
    } ()
    
    private lazy var externalUrl: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.orange.cgColor
        textField.layer.borderWidth = 1.0
        textField.placeholder = "External Url"
        return textField
    } ()
    
    private lazy var createPostButton: UIButton = {
        let button = UIButton()
        button.setTitle("POST A CALL", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(createPostClicked), for: .touchUpInside)
        return button
    } ()
    
    @objc private func chooseImage1() {
        self.imageContext = .Image1
    }
    
    @objc private func chooseImage2() {
        self.imageContext = .Image2
    }
    
    @objc private func createPostClicked() {
        
    }
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        self.setupUI()
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: CreatePostModulePresenter?
    
}

extension CreatePostModuleViewController: PresenterToViewCreatePostModuleProtocol{
    // TODO: Implement View Output Methods
    
    func updateRisks() {
        risksPicker.reloadAllComponents()
    }
    
    func updateNetworks() {
        networksPicker.reloadAllComponents()
    }
}

// MARK: - UI Setup
extension CreatePostModuleViewController {
    
    private func setupUI() {
        setupToolBar()
        setGradientBackground()
        
        view.addSubview(image1Button)
        view.addSubview(image2Button)
        view.addSubview(risksTitle)
        view.addSubview(risksPicker)
        view.addSubview(networksTitle)
        view.addSubview(networksPicker)
        view.addSubview(postTitle)
        view.addSubview(postBody)
        view.addSubview(discordUrl)
        view.addSubview(externalUrl)
        view.addSubview(createPostButton)
        
        image1Button.translatesAutoresizingMaskIntoConstraints = false
        image2Button.translatesAutoresizingMaskIntoConstraints = false
        risksTitle.translatesAutoresizingMaskIntoConstraints = false
        risksPicker.translatesAutoresizingMaskIntoConstraints = false
        networksTitle.translatesAutoresizingMaskIntoConstraints = false
        networksPicker.translatesAutoresizingMaskIntoConstraints = false
        postTitle.translatesAutoresizingMaskIntoConstraints = false
        postBody.translatesAutoresizingMaskIntoConstraints = false
        discordUrl.translatesAutoresizingMaskIntoConstraints = false
        externalUrl.translatesAutoresizingMaskIntoConstraints = false
        createPostButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: image1Button, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .topMargin, multiplier: 1, constant: 40).isActive = true
        NSLayoutConstraint(item: image1Button, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 20).isActive = true
        
        NSLayoutConstraint(item: image2Button, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .topMargin, multiplier: 1, constant: 40).isActive = true
        NSLayoutConstraint(item: image2Button, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -20).isActive = true
        
        NSLayoutConstraint(item: risksTitle, attribute: .top, relatedBy: .equal, toItem: image1Button, attribute: .bottom, multiplier: 1, constant: 25).isActive = true
        NSLayoutConstraint(item: risksTitle, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 20).isActive = true
        
        NSLayoutConstraint(item: risksPicker, attribute: .top, relatedBy: .equal, toItem: risksTitle, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: risksPicker, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: risksPicker, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -20).isActive = true
        NSLayoutConstraint(item: risksPicker, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 50).isActive = true
        
        NSLayoutConstraint(item: networksTitle, attribute: .top, relatedBy: .equal, toItem: risksPicker, attribute: .bottom, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: networksTitle, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 20).isActive = true
        
        NSLayoutConstraint(item: networksPicker, attribute: .top, relatedBy: .equal, toItem: networksTitle, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: networksPicker, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: networksPicker, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -20).isActive = true
        NSLayoutConstraint(item: networksPicker, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 50).isActive = true
        
        NSLayoutConstraint(item: postTitle, attribute: .top, relatedBy: .equal, toItem: networksPicker, attribute: .bottom, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: postTitle, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: postTitle, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -20).isActive = true
        NSLayoutConstraint(item: postTitle, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 50).isActive = true

        NSLayoutConstraint(item: postBody, attribute: .top, relatedBy: .equal, toItem: postTitle, attribute: .bottom, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: postBody, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: postBody, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -20).isActive = true
        NSLayoutConstraint(item: postBody, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 50).isActive = true

        NSLayoutConstraint(item: discordUrl, attribute: .top, relatedBy: .equal, toItem: postBody, attribute: .bottom, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: discordUrl, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: discordUrl, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -20).isActive = true
        NSLayoutConstraint(item: discordUrl, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 50).isActive = true
        
        NSLayoutConstraint(item: externalUrl, attribute: .top, relatedBy: .equal, toItem: discordUrl, attribute: .bottom, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: externalUrl, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: externalUrl, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -20).isActive = true
        NSLayoutConstraint(item: externalUrl, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 50).isActive = true
        
        NSLayoutConstraint(item: createPostButton, attribute: .top, relatedBy: .equal, toItem: externalUrl, attribute: .bottom, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: createPostButton, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: createPostButton, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -20).isActive = true
        NSLayoutConstraint(item: createPostButton, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 50).isActive = true
    }
    
    func setGradientBackground() {
        let color1 =  UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let color2 = UIColor(red: 9.0/255.0, green: 9.0/255.0, blue: 9.0/255.0, alpha: 1.0).cgColor
        let color3 = UIColor(red: 33.0/255.0, green: 33.0/255.0, blue: 33.0/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [color1, color2, color3]
        gradientLayer.locations = [0,0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func setupToolBar() {
        navigationItem.title = "Crear una Call"
    }
    
}

extension CreatePostModuleViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == networksPicker) {
            return self.presenter?.networks.count ?? 0
        } else {
            return self.presenter?.risks.count ?? 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == networksPicker) {
            return self.presenter?.networks[row].name ?? ""
        } else {
            return self.presenter?.risks[row].name ?? ""
        }
    }
}

extension CreatePostModuleViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    }
}

extension CreatePostModuleViewController {
    enum ImageContext {
        case Image1
        case Image2
    }
}
