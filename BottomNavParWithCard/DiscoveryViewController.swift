//
//  ViewController.swift
//  Play_Music
//
//  Created by Martin Kim on 10/12/19.
//  Copyright © 2019 Martin Kim. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class DiscoveryViewController: UIViewController {
    var player = AVQueuePlayer()
    var songs = SongAPI.getSongs()
    var curSong: Song? = nil
    var originalCardCenter: CGPoint? = nil
    
    //----------------------- Functions --------------------------- //

    override func viewDidLoad() {
        super.viewDidLoad()
        curSong = songs.popLast()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Discovery"
        view.addSubview(cardView)
        view.addSubview(playControllerView)
    
        setupCardView()
        setupPlayControllerView()
//        originalCardCenter = CGPoint(x: 0, y: 0) TODO
//        print("Original card center: \(originalCardCenter)")
    }
    
    private func setupCardView() {
        cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cardView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
        cardView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.83).isActive = true
        cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
//        originalCardCenter = cardView.center
//        print("Original card center: \(originalCardCenter)")
        
        //album image
        albumImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        albumImageView.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.80).isActive = true
        albumImageView.heightAnchor.constraint(equalTo: albumImageView.widthAnchor, multiplier: 1).isActive = true
        albumImageView.topAnchor.constraint(equalToSystemSpacingBelow: cardView.topAnchor, multiplier: 4).isActive = true
        
        //song title and artist
        titleTextView.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.8).isActive = true
        titleTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        titleTextView.topAnchor.constraint(equalTo: albumImageView.bottomAnchor).isActive = true
        titleTextView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        
        preferenceView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10).isActive = true
        preferenceView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        preferenceView.heightAnchor.constraint(equalToConstant: 95).isActive = true
        preferenceView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupPlayControllerView() {
        playControllerView.topAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        playControllerView.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        playControllerView.widthAnchor.constraint(equalTo: cardView.widthAnchor).isActive = true
        playControllerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        playControllerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // play button
        playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playButton.topAnchor.constraint(equalToSystemSpacingBelow: playControllerView.topAnchor, multiplier: 1).isActive = true
        
        // slider
        videoSlider.widthAnchor.constraint(equalTo: playControllerView.widthAnchor, multiplier: 0.8).isActive = true
        videoSlider.centerXAnchor.constraint(equalTo: playControllerView.centerXAnchor).isActive = true
        videoSlider.topAnchor.constraint(greaterThanOrEqualTo: playButton.bottomAnchor, constant: 5).isActive = true
        videoSlider.bottomAnchor.constraint(lessThanOrEqualTo: lengthLabel.bottomAnchor, constant: -10).isActive = true
//        videoSlider.bottomAnchor.constraint(equalTo: lengthLabel.topAnchor).isActive = true
        
        //setup label
        lengthLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lengthLabel.bottomAnchor.constraint(equalTo: playControllerView.bottomAnchor, constant: -5).isActive = true
    }
    
    @objc private func handlePlay() {
        print("Trying to play")
        let icon = UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .bold))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        playButton.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        playButton.setImage(icon, for: .normal)
//        MPMediaLibrary.requestAuthorization{ (status) in
//            if (status == .authorized) {
//                if (self.musicPlayer.nowPlayingItem == nil) {
//                    self.musicPlayer.setQueue(with: .songs())
//                }
//                self.musicPlayer.play()
//            }
//        }
    }
    
    @objc private func handlePause() {
        print("Trying to pause")
        let icon = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .bold))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        playButton.addTarget(self, action: #selector(handlePlay), for: .touchUpInside)
        playButton.setImage(icon, for: .normal)
//        musicPlayer.pause()
    }
    
    @objc private func handleHeart() {
        print("Trying to Heart")
        addCurSongToLibrary()
        showNextSong()
    }
    
    func addCurSongToLibrary() {
        let libraryViewNavigationController = self.tabBarController?.viewControllers![1] as! UINavigationController
        let libraryViewController = libraryViewNavigationController.viewControllers[0] as! LibraryViewController
        if let curSong = curSong {
            libraryViewController.addSong(curSong)
        }
    }
    
    func showNextSong() {
        curSong = songs.popLast()
        let image = UIImage(named: "\(curSong?.album ?? "")")
        albumImageView.image = image
        let attributedText = NSMutableAttributedString(string: "\(curSong?.title ?? "")", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)])
        attributedText.append(NSMutableAttributedString(string: "\n\(curSong?.artist ?? "")", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSMutableAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]))
        titleTextView.attributedText = attributedText
        titleTextView.textAlignment = .center
        resetCard()
    }

    // The Pan Gesture
    func createPanGestureRecognizer(targetView: UIView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        targetView.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        let point = panGesture.translation(in: cardView)
        let xFromCenter = cardView.center.x - view.center.x
        cardView.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        let divisor = (view.frame.width / 2) / 0.61
        cardView.transform = CGAffineTransform(rotationAngle: xFromCenter / divisor)
        
        if xFromCenter > 5 {
            self.thumbsImageView.image = #imageLiteral(resourceName: "thumbs_up")
        } else if xFromCenter < -5 {
            self.thumbsImageView.image = #imageLiteral(resourceName: "thumbs_down")
        }
        
        thumbsImageView.alpha = abs(xFromCenter) / view.center.x
        
        if (panGesture.state == UIGestureRecognizer.State.ended) {
            if (cardView.center.x < 75) {
                UIView.animate(withDuration: 0.3, animations: {
                    self.cardView.center = CGPoint(x: self.view.frame.minX - 200, y: self.view.frame.maxY + 75)
                })
                self.addCurSongToLibrary()
                self.showNextSong()
            } else if (cardView.center.x > (view.frame.width - 75)){
                UIView.animate(withDuration: 0.3, animations: {
                    self.cardView.center = CGPoint(x: self.view.frame.minX + 200, y: self.view.frame.maxY + 75)
                })
                self.showNextSong()
            } else {
                resetCard()
            }
        }
        
    }
    
    func resetCard() {
        UIView.animate(withDuration: 0.1, animations: {
//            print("Using original card center: \(self.originalCardCenter!)")
            self.cardView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 60)
            self.cardView.alpha = 1
            self.cardView.transform = .identity
            self.thumbsImageView.alpha = 0
            print(self.thumbsImageView.alpha)
        })
    }
    //Views
    lazy var cardView: UIView = {
        let cardView = UIView()
        cardView.addSubview(thumbsImageView)
        cardView.addSubview(albumImageView)
        cardView.addSubview(titleTextView)
        cardView.addSubview(preferenceView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.layer.cornerRadius = 10.0
        cardView.layer.borderWidth = 6
        cardView.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.3)
        createPanGestureRecognizer(targetView: cardView)
        return cardView
    }()
    
    lazy var albumImageView: UIImageView = {
        let image = UIImage(named: "\(curSong?.album ?? "")")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var thumbsImageView: UIImageView = {
        let image = #imageLiteral(resourceName: "thumbs_up")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        return imageView
    }()
    
    
    lazy var titleTextView: UITextView = {
        let textView = UITextView(frame: CGRect(x: 100, y: 100, width: 500, height: 500))
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = 5
        let attributedText = NSMutableAttributedString(string: "\(curSong?.title ?? "")", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)])
        attributedText.append(NSMutableAttributedString(string: "\n\(curSong?.artist ?? "")", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSMutableAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]))
//        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedText.length))
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.backgroundColor = .none
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    
    let heartButtonView: UIButton = {
        let green = UIColor(displayP3Red: 80/255, green: 200/255, blue: 120/255, alpha: 1.0)
        let heart = UIImage(systemName: "heart.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 65, weight: .bold))?.withTintColor(.green, renderingMode: .alwaysOriginal)
        let button = UIButton()
        button.setBackgroundImage(heart, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleHeart), for: .touchUpInside)
        return button
    }()
    
    let hateButtonView: UIButton = {
        let hate = UIImage(systemName: "heart.slash.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 65, weight: .bold))?.withTintColor(.red, renderingMode: .alwaysOriginal)
        let button = UIButton()
        button.setBackgroundImage(hate, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let playButton: UIButton = {
        let play = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .bold))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let button = UIButton()
        button.setImage(play, for: .normal)
        button.addTarget(self, action: #selector(handlePlay), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFill
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var preferenceView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .none
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(hateButtonView)
        stackView.addArrangedSubview(heartButtonView)
        return stackView
    }()
    
    lazy var playControllerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playButton)
        view.addSubview(videoSlider)
        view.addSubview(lengthLabel)
        view.layer.cornerRadius = 10.0
        return view
    }()
    
    let videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    let lengthLabel: UILabel = {
       let label = UILabel()
        label.text = "00:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    

}
