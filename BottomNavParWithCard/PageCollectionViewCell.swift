//
//  PageCell.swift
//  TastyOrNasty3
//
//  Created by Martin Kim on 10/10/19.
//  Copyright © 2019 Martin Kim. All rights reserved.
//

import UIKit

protocol MyCustomCellDelegate: class {
    func didPressButton()
    
}

class PageCollectionViewCell: UICollectionViewCell {
    weak var delegate: MyCustomCellDelegate?

    var page: Page? {
        didSet {
            guard let unwrappedPage = page else { return }
            imageView.image = UIImage(named: unwrappedPage.imageName)
            let attributedText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 35)])
            attributedText.append(NSMutableAttributedString(string: "\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSMutableAttributedString.Key.font : UIFont.systemFont(ofSize: 25)]))
            descView.attributedText = attributedText
            descView.textAlignment = .center
//            if unwrappedPage.hasButton {
//                setupButton()
//            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented ")
    }
    
    private func setupButton() {
        
    }
    
    private func setupLayout() {
        let topContainerView = UIView()
        addSubview(topContainerView)
        topContainerView.addSubview(imageView)
        topContainerView.backgroundColor = .red
        topContainerView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        topContainerView.translatesAutoresizingMaskIntoConstraints = false
        topContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier : 0.5).isActive = true
        topContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        imageView.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.5).isActive = true
        imageView.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.5).isActive = true
        imageView.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor).isActive = true
        
        let bottomContainerView = UIView()
        addSubview(bottomContainerView)
        bottomContainerView.translatesAutoresizingMaskIntoConstraints = false
        bottomContainerView.addSubview(descView)
        bottomContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bottomContainerView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        bottomContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        bottomContainerView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor).isActive = true
        bottomContainerView.backgroundColor = .green
        bottomContainerView.isUserInteractionEnabled = true
        descView.topAnchor.constraint(equalTo: bottomContainerView.topAnchor).isActive = true
        descView.leftAnchor.constraint(equalTo: bottomContainerView.leftAnchor, constant: 30).isActive = true
        descView.rightAnchor.constraint(equalTo: bottomContainerView.rightAnchor, constant: -30).isActive = true
        descView.heightAnchor.constraint(equalTo: bottomContainerView.heightAnchor, multiplier: 0.5).isActive = true
//        setupButton()
        bottomContainerView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: descView.bottomAnchor, constant: 30).isActive = true
        button.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    private let imageView: UIImageView = {
        let image = UIImage(named: "cat")
        let imageView = UIImageView.init(image: image)
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
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Let's Go!", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.backgroundColor = .red
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    @objc private func buttonPressed() {
        print("Button is pressed")
        delegate?.didPressButton()
    }
}
