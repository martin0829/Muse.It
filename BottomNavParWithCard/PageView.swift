//
//  PageCell.swift
//  TastyOrNasty3
//
//  Created by Martin Kim on 10/10/19.
//  Copyright © 2019 Martin Kim. All rights reserved.
//

import UIKit

class PageView: UIViewController {
    var hasSpecialLayout: Bool = false
    var source: UIViewController? = nil
    
    var page: Page? {
        didSet {
            guard let unwrappedPage = page else { return }
            imageView.image = UIImage(named: unwrappedPage.imageName)
            let attributedText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 35)])
            attributedText.append(NSMutableAttributedString(string: "\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSMutableAttributedString.Key.font : UIFont.systemFont(ofSize: 25)]))
            descView.attributedText = attributedText
            descView.textAlignment = .center
            hasSpecialLayout = unwrappedPage.hasSpecialLayout
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if hasSpecialLayout {
            setupSpecialLayout()
        } else {
            setupLayout()
        }
    }
    
    private func setupSpecialLayout() {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        
        let attributedText = NSMutableAttributedString(string: "Select your favorite genre\n\n", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25), NSAttributedString.Key.paragraphStyle: style])
        textView.attributedText = attributedText
        view.addSubview(textView)
        textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        textView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.25).isActive = true
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        let stackView = UIStackView()
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.isUserInteractionEnabled = true
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 30).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height * 0.25).isActive = true
    
        print("Adding button to stackView")
        
        let popButton = UIButton(type: .system)
        popButton.setTitle("Pop", for: .normal)
        popButton.translatesAutoresizingMaskIntoConstraints = false
        popButton.setTitleColor(.black, for: .normal)
        popButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        popButton.layer.cornerRadius = 10
        popButton.layer.borderWidth = 5
        popButton.addTarget(source!, action: #selector(handlePopButton), for: .touchUpInside)
        stackView.addArrangedSubview(popButton)
        stackView.addArrangedSubview(hiphopButton)
        stackView.addArrangedSubview(edmButton)
//        popButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.8).isActive = true
//        hiphopButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.8).isActive = true
//        edmButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.8).isActive = true
//
    }

//    private var popButton: UIButton = UIButton(type: .system)

    private let hiphopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Hip Hop", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 5
        button.addTarget(self, action: #selector(handleHipHopButton), for: .touchUpInside)
        return button
    }()

    private let edmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("EDM", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 5
        button.addTarget(self, action: #selector(handleEDMButton), for: .touchUpInside)
        return button
    }()
    
    @objc func handlePopButton() {
        print("Handling pop button")
//        self.view.window!.rootViewController = MainViewController()
//        let options: UIView.AnimationOptions = .transitionCrossDissolve
//        UIView.transition(with: self.view.window!, duration: 0.5, options: options, animations: {}, completion: nil)
    }
    
    @objc func handleHipHopButton() {
        print("Handling Hip Hop button")
        self.view.window!.rootViewController = MainViewController()
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        UIView.transition(with: self.view.window!, duration: 0.5, options: options, animations: {}, completion: nil)
    }
    
    
    @objc func handleEDMButton() {
        print("Handling Hip Hop button")
        self.view.window!.rootViewController = MainViewController()
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        UIView.transition(with: self.view.window!, duration: 0.5, options: options, animations: {}, completion: nil)
    }
    
    private func setupLayout() {
        let topContainerView = UIView()
        view.addSubview(topContainerView)
        topContainerView.addSubview(imageView)
//        topContainerView.backgroundColor = .red
        topContainerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        topContainerView.translatesAutoresizingMaskIntoConstraints = false
        topContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier : 0.5).isActive = true
        topContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        imageView.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.5).isActive = true
        imageView.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.5).isActive = true
        imageView.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor).isActive = true
        
        let bottomContainerView = UIView()
        view.addSubview(bottomContainerView)
        bottomContainerView.translatesAutoresizingMaskIntoConstraints = false
        bottomContainerView.addSubview(descView)
        bottomContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomContainerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        bottomContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        bottomContainerView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor).isActive = true
//        bottomContainerView.backgroundColor = .green
        bottomContainerView.isUserInteractionEnabled = true
        descView.topAnchor.constraint(equalTo: bottomContainerView.topAnchor).isActive = true
        descView.leftAnchor.constraint(equalTo: bottomContainerView.leftAnchor, constant: 30).isActive = true
        descView.rightAnchor.constraint(equalTo: bottomContainerView.rightAnchor, constant: -30).isActive = true
        descView.heightAnchor.constraint(equalTo: bottomContainerView.heightAnchor, multiplier: 0.5).isActive = true
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
}
