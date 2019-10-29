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

class SwipeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let pages = [
    Page(imageName: "cat", headerText: "Join us for fun and games!", bodyText: "Lorem Ipsum We like to play and dance and this is just me typing as quickly as possible as filler words."),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.isPagingEnabled = true
        setupBottomControls()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCollectionViewCell
        let page = pages[indexPath.item]
        cell.page = page
        return cell
    }
    
    @objc private func handlePrev() {
        let nextIndex: Int
        if (pageControl.currentPage > 0) {
            nextIndex = pageControl.currentPage - 1
        } else {
            nextIndex = pageControl.currentPage
        }
        pageControl.currentPage = nextIndex
        let indexPath = IndexPath(item: nextIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func handleNext() {
        let nextIndex: Int
        if (pageControl.currentPage < pages.count - 1) {
            nextIndex = pageControl.currentPage + 1
        } else {
            nextIndex = pageControl.currentPage
        }
        pageControl.currentPage = nextIndex
        let indexPath = IndexPath(item: nextIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
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
