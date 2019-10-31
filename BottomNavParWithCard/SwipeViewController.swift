//
//  SwipeCollectionViewController.swift
//  BottomNavParWithCard
//
//  Created by Martin Kim on 10/29/19.
//  Copyright © 2019 Martin Kim. All rights reserved.
//

import UIKit

extension UIColor {
    static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
}

class SwipeViewController: UIViewController, UIScrollViewDelegate {
    let scrollView: UIScrollView = UIScrollView()

    let pages = [
    Page(imageName: "logo", headerText: "Only a swipe away from your next favorite song", bodyText: "Quickly discover new music with by swiping left or right", hasSpecialLayout: false),
    Page(imageName: "fifteen", headerText: "Tired of listening to whole songs?", bodyText: "We curate the 15 seconds of the hottest part of the song for your convenience.", hasSpecialLayout: false),
    Page(imageName: "library", headerText: "In a glance", bodyText: "You can listen to your favorited songs anytime by visiting the library.", hasSpecialLayout: false),
    Page(imageName: "library", headerText: "Select Your Favorite Genre", bodyText: "", hasSpecialLayout: true)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view?.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.isUserInteractionEnabled = true
        setupScrollView()
        setupBottomControls()
    }
    
    func setupScrollView() {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(pages.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        for i in 0 ..< pages.count  {
            let viewController = PageView()
            viewController.page = pages[i]
            viewController.view.frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(viewController.view)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
        changeArrowColor()
    }

    @objc private func buttonTapped() {
        print("Button was tapped")
    }
    
    @objc private func handlePrev() {
        let nextIndex: Int
        if (pageControl.currentPage > 0) {
            nextIndex = pageControl.currentPage - 1
        } else {
            nextIndex = pageControl.currentPage
        }
        pageControl.currentPage = nextIndex
        changeArrowColor()
    
        var frame = scrollView.frame;
        frame.origin.x = frame.size.width * CGFloat(pageControl.currentPage);
        frame.origin.y = 0;
        scrollView.scrollRectToVisible(frame, animated: true)
    }
    
    @objc private func handleNext() {
        let nextIndex: Int
        if (pageControl.currentPage >= pages.count - 1) {
            return
        }
        nextIndex = pageControl.currentPage + 1
        pageControl.currentPage = nextIndex
        changeArrowColor()
        var frame = scrollView.frame;
        frame.origin.x = frame.size.width * CGFloat(pageControl.currentPage);
        frame.origin.y = 0;
        scrollView.scrollRectToVisible(frame, animated: true)
    }
    
    func changeArrowColor() {
        if (pageControl.currentPage > 0) {
            prevButton.setTitleColor(.mainPink, for: .normal)
        } else {
            prevButton.setTitleColor(.gray, for: .normal)
        }
        if (pageControl.currentPage < pages.count - 1) {
            nextButton.setTitleColor(.mainPink, for: .normal)
        } else {
            nextButton.setTitleColor(.gray, for: .normal)
        }
    }
    
    private func setupBottomControls() {
        let bottomControlsStackView = UIStackView(arrangedSubviews: [prevButton, pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        view.addSubview(bottomControlsStackView)
        NSLayoutConstraint.activate([bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor), bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor), bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)])
    }
    //--------------------------- UI Elements --------------------------- //
    
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .red
        pc.pageIndicatorTintColor = .gray
        return pc
    }()
    
    private let prevButton: UIButton = {
          let button = UIButton(type: .system)
          button.setTitle("PREV", for: .normal)
          button.translatesAutoresizingMaskIntoConstraints = false
          button.setTitleColor(.gray, for: .normal)
          button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
          button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
          return button
      }()
      
      private let nextButton: UIButton = {
          let button = UIButton(type: .system)
          button.setTitle("NEXT", for: .normal)
          button.translatesAutoresizingMaskIntoConstraints = false
          button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
          button.setTitleColor(.mainPink, for: .normal)
          button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
          return button
      }()
}
