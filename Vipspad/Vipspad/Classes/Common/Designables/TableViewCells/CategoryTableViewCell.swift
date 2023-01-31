//
//  CategoryTableViewCell.swift
//  Vipspad
//
//  Created by Azure on 27/1/23.
//

import Foundation
import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    private var category: Category?
    var delegate: CategoryTableViewCellDelegate?
    
    private lazy var categoryImage: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    } ()
    
    private lazy var categoryTitle: UILabel = {
        let label = UILabel()
        label.font = VipsFont.getFont(.extraLarge, .bold)
        label.sizeToFit()
        label.textColor = .white
        return label
    }()
    
    private lazy var categoryNetwork: UILabel = {
        let label = UILabel()
        label.font = VipsFont.getFont(.standard, .bold)
        label.sizeToFit()
        label.textColor = .white
        return label
    }()
    
    private lazy var categoryRiskIndex: UILabel = {
        let label = UILabel()
        label.font = VipsFont.getFont(.standard, .bold)
        label.sizeToFit()
        label.textColor = .gray
        return label
    }()
    
    private lazy var  categoryButton: UIButton = {
        let button = UIButton()
        // Check this
        button.setTitle("VER MÁS", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.orange, for: .normal)
        button.titleLabel?.font = VipsFont.getFont(.standard, .bold)
        button.addTarget(self, action: #selector(navigateToFeed), for: .touchDown)
        return button
    } ()
    
    func setupCell(_ category: Category){
        self.category = category
        setupUI()
        setupImage(image: category.image)
        categoryTitle.text = category.name
        categoryNetwork.text = "RED: " + category.network.name
        categoryRiskIndex.text = category.riskIndex.name + "  RISK CALL"
    }
    
    private func setupImage(image: String) {
        guard let imageURL = URL(string: image) else { return }
        categoryImage.load(url: imageURL)
    }
    
    @objc private func navigateToFeed() {
        guard let category = self.category else { return }
        delegate?.categoyButtonClicked(category)
    }
    private func setupUI() {
        self.backgroundColor = .black.withAlphaComponent(0.5)
        
        self.contentView.addSubview(categoryImage)
        self.contentView.addSubview(categoryTitle)
        self.contentView.addSubview(categoryNetwork)
        self.contentView.addSubview(categoryRiskIndex)
        self.contentView.addSubview(categoryButton)
        
        categoryImage.translatesAutoresizingMaskIntoConstraints = false
        categoryTitle.translatesAutoresizingMaskIntoConstraints = false
        categoryNetwork.translatesAutoresizingMaskIntoConstraints = false
        categoryRiskIndex.translatesAutoresizingMaskIntoConstraints = false
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: categoryImage, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: categoryImage, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: categoryImage, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 100).isActive = true
        NSLayoutConstraint(item: categoryImage, attribute: .width, relatedBy: .equal, toItem: categoryImage, attribute: .height, multiplier: 1, constant: 0).isActive = true

        NSLayoutConstraint(item: categoryTitle, attribute: .leading, relatedBy: .equal, toItem: self.categoryImage, attribute: .trailing, multiplier: 1, constant: 10).isActive = true
        // Leading -- Size to fit --
        NSLayoutConstraint(item: categoryTitle, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: categoryTitle, attribute: .bottom, relatedBy: .equal, toItem: self.categoryNetwork, attribute: .top, multiplier: 1, constant: -10).isActive = true
        
        NSLayoutConstraint(item: categoryNetwork, attribute: .leading, relatedBy: .equal, toItem: self.categoryImage, attribute: .trailing, multiplier: 1, constant: 14).isActive = true
        NSLayoutConstraint(item: categoryNetwork, attribute: .top, relatedBy: .equal, toItem: self.categoryTitle, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: categoryNetwork, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: -10).isActive = true
        
        NSLayoutConstraint(item: categoryRiskIndex, attribute: .leading, relatedBy: .equal, toItem: self.categoryNetwork, attribute: .trailing, multiplier: 1, constant: 30).isActive = true
        NSLayoutConstraint(item: categoryRiskIndex, attribute: .top, relatedBy: .equal, toItem: self.categoryNetwork, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: categoryRiskIndex, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: -10).isActive = true
        
        NSLayoutConstraint(item: categoryButton, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: categoryButton, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        
    }
    
    
}

protocol CategoryTableViewCellDelegate {
    func categoyButtonClicked(_ category: Category)
}
