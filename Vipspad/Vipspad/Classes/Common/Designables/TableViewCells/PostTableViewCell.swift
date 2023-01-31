//
//  PostTableViewCel.swift
//  Vipspad
//
//  Created by Azure on 28/1/23.
//

import Foundation
import UIKit

class PostTableViewCell: UITableViewCell {
    
    var post: Post?
    
    private  lazy var collectionView: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageViewCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        return collectionView
    } ()
    
    private lazy var dotsIndicator: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .systemGray5
        pageControl.currentPageIndicatorTintColor = .orange
        pageControl.numberOfPages = 2
        pageControl.currentPage = 0
        return pageControl
    } ()
    
    private lazy var  postTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = VipsFont.getFont(.title, .bold)
        label.sizeToFit()
        return label
    } ()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = VipsFont.getFont(.small)
        label.sizeToFit()
        return label
    } ()
    
    private lazy var postHosterTitle: UILabel = {
        let label = UILabel()
        label.font = VipsFont.getFont(.large)
        label.text = "Call Hoster:"
        label.sizeToFit()
        return label
    } ()
    
    private lazy var postHoster: UILabel = {
        let label = UILabel()
        label.font = VipsFont.getFont(.large)
        label.sizeToFit()
        return label
    } ()
    
    
    private lazy var  postCommentTitle: UILabel = {
        let label = UILabel()
        label.font = VipsFont.getFont(.standard, .bold)
        label.text = "Comment:"
        label.sizeToFit()
        return label
    } ()
    
    private lazy var  postComment: UILabel = {
        let label = UILabel()
        label.font = VipsFont.getFont(.standard)
        label.sizeToFit()
        return label
    } ()
    
    private lazy var  networkLabel: UILabel = {
        let label = UILabel()
        label.font = VipsFont.getFont(.standard, .bold)
        label.sizeToFit()
        label.text = "RED: "
        return label
    } ()
    
    private lazy var webLabel: UILabel = {
        let label = UILabel()
        label.font = VipsFont.getFont(.standard, .bold)
        label.sizeToFit()
        label.text = "ABRIR EN"
        return label
    } ()
    
    private lazy var webIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "explorer_icon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    } ()
    
    private lazy var webButtonView: UIView = {
        let view = UIView()
        
        view.addSubview(webIcon)
        view.addSubview(webLabel)
        
        webIcon.translatesAutoresizingMaskIntoConstraints = false
        webLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: webLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: webLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: webLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: webLabel, attribute: .trailing, relatedBy: .equal, toItem: webIcon, attribute: .leading, multiplier: 1, constant: 8).isActive = true

        NSLayoutConstraint(item: webIcon, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: webIcon, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: webIcon, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true

        NSLayoutConstraint(item: webIcon, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 30).isActive = true
        NSLayoutConstraint(item: webIcon, attribute: .width, relatedBy: .equal, toItem: webIcon, attribute: .height, multiplier: 1, constant: 0).isActive = true
        
        return view
    } ()
    
    private lazy var discordLabel: UILabel = {
        let label = UILabel()
        label.font = VipsFont.getFont(.standard, .bold)
        label.text = "ABRIR EN"
        return label
    } ()
    
    private lazy var discordIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "discord_icon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    } ()
    
    private lazy var discordButtonView: UIView = {
        let view = UIView()
        
        view.addSubview(discordIcon)
        view.addSubview(discordLabel)
        
        discordIcon.translatesAutoresizingMaskIntoConstraints = false
        discordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: discordLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: discordLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: discordLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: discordLabel, attribute: .trailing, relatedBy: .equal, toItem: discordIcon, attribute: .leading, multiplier: 1, constant: 8).isActive = true

        NSLayoutConstraint(item: discordIcon, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: discordIcon, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: discordIcon, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true

        NSLayoutConstraint(item: discordIcon, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 30).isActive = true
        NSLayoutConstraint(item: discordIcon, attribute: .width, relatedBy: .equal, toItem: discordIcon, attribute: .height, multiplier: 1, constant: 0).isActive = true
        
        return view
    } ()
    
    
    
    func setupCell(post: Post) {
        self.post = post
        setupUI()
    }
    
    private func setupUI(){
        
        self.contentView.layer.borderWidth = 2.0
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.borderColor = CGColor(red: 255.0, green: 165, blue: 0, alpha: 1)
        self.clipsToBounds = true
        self.backgroundColor = .clear
        
        self.contentView.addSubview(postTitle)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(postHosterTitle)
        self.contentView.addSubview(postHoster)
        self.contentView.addSubview(postCommentTitle)
        self.contentView.addSubview(postComment)
        self.contentView.addSubview(networkLabel)
        self.contentView.addSubview(webButtonView)
        self.contentView.addSubview(discordButtonView)
        self.contentView.addSubview(collectionView)
        self.contentView.addSubview(dotsIndicator)
        
        
        postTitle.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        postHosterTitle.translatesAutoresizingMaskIntoConstraints = false
        postHoster.translatesAutoresizingMaskIntoConstraints = false
        postCommentTitle.translatesAutoresizingMaskIntoConstraints = false
        networkLabel.translatesAutoresizingMaskIntoConstraints = false
        webButtonView.translatesAutoresizingMaskIntoConstraints = false
        discordButtonView.translatesAutoresizingMaskIntoConstraints = false
        dotsIndicator.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        postComment.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: postTitle, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: postTitle, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: postTitle, attribute: .bottom, relatedBy: .equal, toItem: self.collectionView, attribute: .top, multiplier: 1, constant: -20).isActive = true
        
        NSLayoutConstraint(item: dateLabel, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: dateLabel, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailingMargin, multiplier: 1, constant: -20).isActive = true
        
        NSLayoutConstraint(item: postHosterTitle, attribute: .top, relatedBy: .equal, toItem: self.dateLabel, attribute: .bottom, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint(item: postHosterTitle, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailingMargin, multiplier: 1, constant: -20).isActive = true
        
        NSLayoutConstraint(item: postHoster, attribute: .top, relatedBy: .equal, toItem: self.postHosterTitle, attribute: .bottom, multiplier: 1, constant: 4).isActive = true
        NSLayoutConstraint(item: postHoster, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailingMargin, multiplier: 1, constant: -20).isActive = true
        NSLayoutConstraint(item: postHoster, attribute: .bottom, relatedBy: .equal, toItem: self.collectionView, attribute: .top, multiplier: 1, constant: -20).isActive = true
        
        NSLayoutConstraint(item: collectionView, attribute: .centerX, relatedBy: .equal, toItem: self.contentView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 200).isActive = true
        
        NSLayoutConstraint(item: dotsIndicator, attribute: .bottom, relatedBy: .equal, toItem: collectionView, attribute: .bottom, multiplier: 1, constant: -8).isActive = true
        NSLayoutConstraint(item: dotsIndicator, attribute: .centerX, relatedBy: .equal, toItem: collectionView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: postCommentTitle, attribute: .top, relatedBy: .equal, toItem: collectionView, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: postCommentTitle, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1, constant: 20).isActive = true
        
        NSLayoutConstraint(item: postComment, attribute: .top, relatedBy: .equal, toItem: postCommentTitle, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: postComment, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: postComment, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1, constant: -20).isActive = true
        
        NSLayoutConstraint(item: networkLabel, attribute: .top, relatedBy: .equal, toItem: postComment, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: networkLabel, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: networkLabel, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: -20).isActive = true
        
        NSLayoutConstraint(item: webButtonView, attribute: .top, relatedBy: .equal, toItem: postComment, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: webButtonView, attribute: .leading, relatedBy: .equal, toItem: self.networkLabel, attribute: .trailing, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint(item: webButtonView, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: -20).isActive = true
        
        NSLayoutConstraint(item: discordButtonView, attribute: .top, relatedBy: .equal, toItem: postComment, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: discordButtonView, attribute: .leading, relatedBy: .equal, toItem: self.webButtonView, attribute: .trailing, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint(item: discordButtonView, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1, constant: -20).isActive = true
        NSLayoutConstraint(item: discordButtonView, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: -20).isActive = true
            
        guard let post = self.post else { return }
        postTitle.text = post.title
        postComment.text = post.body
        networkLabel.text = "RED: \(post.network.name)"
        postHoster.text = "@\(post.creator.name)"
        dateLabel.text = post.createdAt.convertDateString(fromFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ", toFormat: "MMM d, yyyy")
    }
}

extension PostTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageViewCollectionViewCell, let post = self.post else { return .init()}
        switch indexPath.row {
        case 0:
            let image = post.imageURL
            cell.setupCell(url: image)
        case 1:
            let image = post.image2URL
            cell.setupCell(url: image)
        default:
            return .init()
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.dotsIndicator.currentPage = Int((collectionView.contentOffset.x / collectionView.frame.width)
                   .rounded(.toNearestOrAwayFromZero))
    }
    
}

extension PostTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height

        return CGSize(width: width, height: height)
    }
}
