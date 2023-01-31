//
//  PostFeedModuleViewController.swift
//  Vipspad
//
//  Created by Azure on 28/1/23.
//  
//

import UIKit

class PostFeedModuleViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    } ()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        imageView.backgroundColor = .black
        return imageView
    } ()
    
    @objc private func closeImage() {
        imageView.isHidden = true
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        self.setupUI()
        super.viewDidLoad()
        setupClicks()
        
        self.presenter?.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: PostFeedModulePresenter?
    
}

extension PostFeedModuleViewController: PresenterToViewPostFeedModuleProtocol{
    func reloadTableView() {
        tableView.reloadData()
    }
    // TODO: Implement View Output Methods
}

// MARK: - UI Setup
extension PostFeedModuleViewController {
    
    private func setupUI() {
        setGradientBackground()
        setupToolbar()
        
        view.addSubview(tableView)
        view.addSubview(imageView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.backgroundColor = .clear
        
        NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -10).isActive = true
        
        NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        
    }
    
    private func setupClicks() {
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(closeImage))
        imageView.addGestureRecognizer(imageGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    private func setGradientBackground() {
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
    
    func setupToolbar() {
        let imageView = UIImageView(image: UIImage(named: "vips_logo"))
            
        NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 34).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: imageView, attribute: .height, multiplier: 1, constant: 0).isActive = true

        self.navigationItem.titleView = imageView
    }
    
}


extension PostFeedModuleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.posts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell,
              let post = presenter?.posts[indexPath.row] else {return .init()}
        cell.delegate = self
        cell.setupCell(post: post)
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PostFeedModuleViewController: PostTableViewCellDelegate {
    func imageClicked(imageURL: String) {
        guard let image = URL(string: imageURL) else {return}
        imageView.load(url: image)
        imageView.isHidden = false
    }
    
    func deletePost(postId: Int) {
        //TODO
    }
    
    func openWebView(link: String) {
        guard let url = URL(string: link) else { return }
        UIApplication.shared.open(url)
    }
    
    
}
