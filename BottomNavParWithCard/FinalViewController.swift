//
//  FinalViewController.swift
//  BottomNavParWithCard
//
//  Created by Martin Kim on 11/3/19.
//  Copyright © 2019 Martin Kim. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        // Do any additional setup after loading the view.
    }
    
    private func setupLayout() {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        
        let attributedText = NSMutableAttributedString(string: "Thank you for trying our app out!\n", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 33), NSAttributedString.Key.paragraphStyle: style])
        attributedText.append(NSMutableAttributedString(string: "\nWere you able to discover a song you liked? We would love to hear your feedback on our app!", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSMutableAttributedString.Key.font : UIFont.systemFont(ofSize: 23), NSAttributedString.Key.paragraphStyle: style]))
        textView.attributedText = attributedText
        view.addSubview(textView)
        textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        textView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.5).isActive = true
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let button = UIButton(type: .system)
        view.addSubview(button)
        button.setTitle("Reset Demo", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 5
        button.topAnchor.constraint(equalTo:textView.bottomAnchor, constant: 50).isActive = true
        button.widthAnchor.constraint(equalTo:view.widthAnchor, multiplier: 0.5).isActive = true
        button.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        button.addTarget(self, action: #selector(handleResetButton), for: .touchUpInside)
    }
    
    @objc func handleResetButton() {
        let viewController = SwipeViewController()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
