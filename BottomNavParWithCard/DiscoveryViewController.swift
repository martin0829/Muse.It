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
    var player: AVPlayer = AVPlayer()
    var songs : [Song]? = nil
    var curSongIndex: Int = 0
    var originalCardCenter: CGPoint? = nil
    let depthOfSongTree: Int = 4
    var genre: String? = nil

    
    //----------------------- Functions --------------------------- //

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cardView)
        view.addSubview(playControllerView)
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Discovery"
        
        setupCardView()
        setupPlayControllerView()
    }
    
    func setGenreAndGetSong(genre: String) {
        self.genre = genre
        songs = SongAPI.getSongs(genre: genre)
        
        if let songs = songs {
            let song = songs[curSongIndex]
            let image = UIImage(named: "\(song.album ?? "")")
            albumImageView.image = image
            let attributedText = NSMutableAttributedString(string: "\(song.title ?? "")", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)])
            attributedText.append(NSMutableAttributedString(string: "\n\(song.artist ?? "")", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSMutableAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]))
            titleTextView.attributedText = attributedText
            titleTextView.textAlignment = .center
        }
        initPlayer()
    }
    
    func addCurSongToLibrary() {
        print("Trying to add song to my library")
        let libraryViewController = self.tabBarController!.viewControllers![1] as! LibraryViewController
        libraryViewController.addSong((songs?[curSongIndex])!)
    }
    
    // The Pan Gesture
    func createPanGestureRecognizer(targetView: UIView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        targetView.addGestureRecognizer(panGesture)
    }
    
    func enterCard() {
        self.cardView.transform = .identity
        self.cardView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 40)
        self.thumbsImageView.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.cardView.alpha = 1
        })
    }
    
    func initPlayer() {
        let filePath = Bundle.main.path(forResource: songs?[curSongIndex].title, ofType: "mp3")
        let fileURL = URL(fileURLWithPath: filePath!)
        let avAsset = AVAsset(url: fileURL as URL)
        let assetKeys = ["playable"]
        let playerItem = AVPlayerItem(asset: avAsset, automaticallyLoadedAssetKeys: assetKeys)
        player = AVPlayer(playerItem: playerItem)
        let interval = CMTime(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
            let seconds = CMTimeGetSeconds(progressTime)
            let finished = (self.curSongIndex >= Int(pow(2.0, Double(self.depthOfSongTree))) - 1)
            if seconds > 15 && !finished {
                self.handleDislike()
                return
            }
            self.lengthLabel.text = String(format: "%02d:%02d", Int((seconds/60).rounded()), Int(seconds.truncatingRemainder(dividingBy: 60)))
        })
    }
    
    @objc private func handleHeart() {
        print("Trying to Heart")
        addCurSongToLibrary()
        showNextSong(likedCurSong: true)
    }
    @objc private func handleDislike() {
       print("Trying to Dislike")
        showNextSong(likedCurSong: false)
   }
    
    @objc private func handlePanGesture(panGesture: UIPanGestureRecognizer) {
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
                    self.cardView.center = CGPoint(x: self.view.frame.minX - 300, y: self.view.frame.midY)
                    self.cardView.alpha = 0
                }, completion: { (true) in
                    self.handleDislike()
                })
            } else if (cardView.center.x > (view.frame.width - 75)){
                UIView.animate(withDuration: 0.3, animations: {
                    self.cardView.center = CGPoint(x: self.view.frame.midX + 300, y: self.view.frame.midY)
                    self.cardView.alpha = 0
                }, completion: { (true) in
                    self.handleHeart()
                })
            } else {
                resetCard()
            }
        }
        print(cardView.center.x)
    }
    
    @objc private func handlePause() {
         print("Trying to pause")
         let icon = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .bold))?.withTintColor(.black, renderingMode: .alwaysOriginal)
         playButton.addTarget(self, action: #selector(handlePlay), for: .touchUpInside)
         playButton.setImage(icon, for: .normal)
         player.pause()
    }
    
    @objc func handlePlay() {
        print("Trying to play")
        let icon = UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .bold))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        playButton.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        playButton.setImage(icon, for: .normal)
        if (player.currentItem != nil) {
            player.play()
        } else {
            print("Current player item is null!")
        }
    }
    
    @objc private func handleSlider() {
        print("Trying to slide")
        if let duration = player.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(slider.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player.seek(to: seekTime, completionHandler: { (completedSeek)
                in
            })
        }
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
        
//        // slider
//        slider.widthAnchor.constraint(equalTo: playControllerView.widthAnchor, multiplier: 0.8).isActive = true
//        slider.centerXAnchor.constraint(equalTo: playControllerView.centerXAnchor).isActive = true
//        slider.topAnchor.constraint(greaterThanOrEqualTo: playButton.bottomAnchor, constant: 5).isActive = true
//        slider.bottomAnchor.constraint(lessThanOrEqualTo: lengthLabel.bottomAnchor, constant: -10).isActive = true
//        //setup label
        lengthLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lengthLabel.bottomAnchor.constraint(equalTo: playControllerView.bottomAnchor, constant: -5).isActive = true
    }
    
    func showNextSong(likedCurSong: Bool) {
        if curSongIndex >= Int(pow(2.0, Double(depthOfSongTree - 1))) - 1 {
            print("All Songs have been displayed")
            let finalViewController = FinalViewController()
            addChild(finalViewController)
            finalViewController.modalPresentationStyle = .fullScreen
            finalViewController.modalTransitionStyle = .flipHorizontal
            present(finalViewController, animated: true, completion: nil)
            return
        }
        if likedCurSong {
            curSongIndex = curSongIndex * 2 + 2
        } else {
            curSongIndex = curSongIndex * 2 + 1
        }
        let nextSong: Song = (songs?[curSongIndex])!
        let image = UIImage(named: "\(nextSong.album ?? "")")
        albumImageView.image = image
        let attributedText = NSMutableAttributedString(string: "\(nextSong.title ?? "")", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)])
        attributedText.append(NSMutableAttributedString(string: "\n\(nextSong.artist ?? "")", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSMutableAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]))
        titleTextView.attributedText = attributedText
        titleTextView.textAlignment = .center
        let filePath = Bundle.main.path(forResource: nextSong.title, ofType: "mp3")
        let fileURL = URL(fileURLWithPath: filePath!)
        let avAsset = AVAsset(url: fileURL as URL)
        let assetKeys = ["playable"]
        let playerItem = AVPlayerItem(asset: avAsset, automaticallyLoadedAssetKeys: assetKeys)
        player.replaceCurrentItem(with: playerItem)
        player.play()
//        player?.seek(to: CMTime(value: Int64(nextSong.startTime), timescale: 1))
        enterCard()
        handlePlay()
    }
    
    func resetCard() {
        UIView.animate(withDuration: 0.1, animations: {
            self.cardView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 40)
            self.cardView.alpha = 1
            self.cardView.transform = .identity
            self.thumbsImageView.alpha = 0
        })
    }
    
    //----------------------- UI Elements --------------------------- //
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
        let curSong = songs?[curSongIndex]
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
        let curSong = songs?[curSongIndex]
        let textView = UITextView(frame: CGRect(x: 100, y: 100, width: 500, height: 500))
        let attributedText = NSMutableAttributedString(string: "\(curSong?.title ?? "")", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)])
        attributedText.append(NSMutableAttributedString(string: "\n\(curSong?.artist ?? "")", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSMutableAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]))
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.backgroundColor = .none
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    
    let heartButtonView: UIButton = {
        let green = UIColor(displayP3Red: 80/255, green: 200/255, blue: 120/255, alpha: 1.0)
        let image = UIImage(systemName: "heart.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 65, weight: .bold))?.withTintColor(.green, renderingMode: .alwaysOriginal)
        let button = UIButton()
        button.setBackgroundImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleHeart), for: .touchUpInside)
        return button
    }()
    
    let dislikeButtonView: UIButton = {
        let image = UIImage(systemName: "heart.slash.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 65, weight: .bold))?.withTintColor(.red, renderingMode: .alwaysOriginal)
        let button = UIButton()
        button.setBackgroundImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleDislike), for: .touchUpInside)
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
        stackView.addArrangedSubview(dislikeButtonView)
        stackView.addArrangedSubview(heartButtonView)
        return stackView
    }()
    
    lazy var playControllerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playButton)
//        view.addSubview(slider)
        view.addSubview(lengthLabel)
        view.layer.cornerRadius = 10.0
        return view
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(handleSlider),
                         for: .valueChanged)
        return slider
    }()
    
    let lengthLabel: UILabel = {
       let label = UILabel()
        label.text = "00:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    

}
