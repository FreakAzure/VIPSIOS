//
//  HomeModuleViewController.swift
//  Vipspad
//
//  Created by Azure on 25/1/23.
//  
//

import UIKit
import Alamofire

class HomeModuleViewController: UIViewController {
    let refreshControl = UIRefreshControl()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "CategoryCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        tableView.refreshControl = refreshControl
        return tableView
    } ()
    
    private lazy var alertController: UIAlertController = {
        // Crear el UIAlertController
        let alert = UIAlertController(title: "Cerrar Sesión", message: "¿Estás seguro de que quieres salir de tu cuenta?", preferredStyle: .alert)

        let option1 = UIAlertAction(title: "Aceptar", style: .default) { (action) in
            self.presenter?.logout()
            alert.dismiss(animated: true)
        }

        let option2 = UIAlertAction(title: "Cancelar", style: .cancel) { (action) in
            alert.dismiss(animated: true)
        }

        // Agregar las opciones al UIAlertController
        alert.addAction(option1)
        alert.addAction(option2)
        
        return alert
    } ()
    
    private lazy var createPostButton: UIView = {
        let view = UIView()
        let title = UILabel()
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        title.sizeToFit()
        title.text = "CREATE A CALL"
        title.font = VipsFont.getFont(.extraLarge, .bold)
        view.sizeToFit()
        NSLayoutConstraint(item: title, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: title, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        view.backgroundColor = .orange
        return view
    } ()
    
    @objc func createPostClicked(sender: UITapGestureRecognizer) {
        // Aquí puedes escribir el código que deseas ejecutar cuando se detecte el click
        presenter?.navigateToCreatePost()
        
    }
    
    @objc func refreshTableView() {
        presenter?.updateCategories()
        refreshControl.endRefreshing()
    }
    
    @objc private func logoutClicked() {
        self.present(alertController, animated: true, completion: nil)
    }
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        self.setupUI()
        super.viewDidLoad()
        self.presenter?.viewWillLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    // MARK: - Properties
    var presenter: HomeModulePresenter?
    
}

extension HomeModuleViewController: PresenterToViewHomeModuleProtocol{
    // TODO: Implement View Output Methods
    func setupToolbar(userImage: String) {
        let leftTitle = UILabel()
        let imageView = UIImageView(image: UIImage(named: "vips_logo"))
        let userImageView = UIImageView()
        let logoutGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(logoutClicked))
        guard let imageURL = URL(string: userImage) else {return}
            
        userImageView.load(url: imageURL)
        userImageView.contentMode = .scaleAspectFit
        userImageView.layer.cornerRadius = imageView.frame.size.width / 2
        userImageView.clipsToBounds = true
        userImageView.addGestureRecognizer(logoutGestureRecognizer)
          
        NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 34).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: imageView, attribute: .height, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: userImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 34).isActive = true
        NSLayoutConstraint(item: userImageView, attribute: .width, relatedBy: .equal, toItem: userImageView, attribute: .height, multiplier: 1, constant: 0).isActive = true
        
        leftTitle.text = "V1P$ CALLS"
        leftTitle.sizeToFit()
        leftTitle.font = VipsFont.getFont(.extraLarge, .bold)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftTitle)
        self.navigationItem.titleView = imageView
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: userImageView)
    }
    
    func reloadTable() {
        tableView.reloadData()
        if (Singleton.shared.user?.isAdmin == false) {
            createPostButton.isHidden = true
        } else {
            createPostButton.isHidden = false
        }
    }
}

// MARK: - UI Setup
extension HomeModuleViewController {

    private func setupUI() {
        setGradientBackground()
        setupGestureRecognizers()
        view.addSubview(tableView)
        view.addSubview(createPostButton)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        createPostButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: createPostButton, attribute: .top, relatedBy: .equal, toItem: self.tableView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: createPostButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottomMargin, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: createPostButton, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: createPostButton, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: createPostButton, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 40).isActive = true
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
    
    func setupGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(createPostClicked(sender:)))
        createPostButton.addGestureRecognizer(tapGestureRecognizer)
    }
    
}

extension HomeModuleViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.categories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryTableViewCell else { return .init() }
        guard let category = presenter?.categories[indexPath.row] else {
            return UITableViewCell()}
        cell.delegate = self
        cell.setupCell(category)
        cell.selectionStyle = .none
        return cell
    }
}

extension HomeModuleViewController: CategoryTableViewCellDelegate {
    func categoyButtonClicked(_ category: Category) {
        // Navigate
        presenter?.navigateToPostFeed(category)
        print("Navigate to feed")
    }
    
    
}

