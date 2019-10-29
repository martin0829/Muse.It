//
//  PageCell.swift
//  TastyOrNasty3
//
//  Created by Martin Kim on 10/10/19.
//  Copyright © 2019 Martin Kim. All rights reserved.
//

import UIKit

class PageCollectionViewCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            guard let unwrappedPage = page else { return }
            catImageView.image = UIImage(named: unwrappedPage.imageName)
            let attributedText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25)])
            attributedText.append(NSMutableAttributedString(string: "\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSMutableAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]))
            descView.attributedText = attributedText
            descView.textAlignment = .center
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented ")
    }
    
    private let catImageView: UIImageView = {
        let catImage = UIImage(named: "cat")
        let imageView = UIImageView.init(image: catImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let descView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Join us today for fun and games!\n\n", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25)])
        attributedText.append(NSMutableAttributedString(string: "Lorem Ipsum We like to play and dance and this is just me typing as quickly as possible as filler words.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSMutableAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]))
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let prevButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.mainPink, for: .normal)
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .red
        pc.pageIndicatorTintColor = .gray
        return pc
    }()
    
        
    private func setupLayout() {
        let topImageContainerView = UIView()
        addSubview(topImageContainerView)
        topImageContainerView.addSubview(catImageView)
        addSubview(descView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier : 0.5).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        catImageView.widthAnchor.constraint(equalTo: topImageContainerView.widthAnchor, multiplier: 0.5).isActive = true
        catImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true
        catImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        catImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true

        descView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        descView.leftAnchor.constraint(equalTo: leftAnchor, constant: 30).isActive = true
        descView.rightAnchor.constraint(equalTo: rightAnchor, constant: -30).isActive = true
        descView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setupBottomControls() {
        let bottomControlsStackView = UIStackView(arrangedSubviews: [prevButton, pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        addSubview(bottomControlsStackView)
        NSLayoutConstraint.activate([bottomControlsStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                                     bottomControlsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                                     bottomControlsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                                     bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)])
    }
}
