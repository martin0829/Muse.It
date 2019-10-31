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
    Page(imageName: "logo", headerText: "Only a swipe away from your next favorite song", bodyText: "Quickly discover new music with by swiping left or right", hasButton: false),
    Page(imageName: "fifteen", headerText: "Tired of listening to whole songs?", bodyText: "We curate the 15 seconds of the hottest part of the song for your convenience.", hasButton: false),
    Page(imageName: "library", headerText: "In a glance", bodyText: "You can listen to your favorited songs anytime by visiting the library.", hasButton: true),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.isUserInteractionEnabled = true
        view.isUserInteractionEnabled = true
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? PageCollectionViewCell
        cell?.isUserInteractionEnabled = true
        cell?.contentView.isUserInteractionEnabled = true
        let page = pages[indexPath.item]
        
//        if let cell = cell as? PageCollectionViewCell {
//            cell.page = page
//        } else {
//            print("not a pageCollectionViewCell")
//        }
        cell!.page = page
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
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
        changeArrowColor()
        if (pageControl.currentPage == pages.count - 1) {
            nextButton.addTarget(self, action: #selector(transitionToGenreSelection), for: .touchUpInside)
        }
        let indexPath = IndexPath(item: nextIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc func transitionToGenreSelection() {
        self.view.window!.rootViewController = MainViewController()
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
