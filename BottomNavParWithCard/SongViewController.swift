//
//  SongViewController.swift
//  BottomNavParWithCard
//
//  Created by Martin Kim on 10/27/19.
//  Copyright © 2019 Martin Kim. All rights reserved.
//

import UIKit
import AVKit

class SongViewController: UIViewController {
    var player: AVPlayer = AVPlayer()
    var curSong: Song? = nil
    var songs: [Song]? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        initPlayer()
        view.backgroundColor = .white
        view.addSubview(albumImageView)
        view.addSubview(titleTextView)
        view.addSubview(playControllerView)
        setupLayout()
        // Do any additional setup after loading the view.
    }
    
    //----------------------- Functions --------------------------- //

    func initPlayer() {
        let interval = CMTime(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
            
            let seconds = CMTimeGetSeconds(progressTime)
            self.lengthLabel.text = String(format: "%02d:%02d", Int((seconds/60).rounded()), Int(seconds.truncatingRemainder(dividingBy: 60)))
        })
    }
    
    private func setupLayout() {
        //album image
        setupPlayControllerView()
        albumImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        albumImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80).isActive = true
        albumImageView.heightAnchor.constraint(equalTo: albumImageView.widthAnchor, multiplier: 1).isActive = true
        albumImageView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 4).isActive = true
        
        //song title and artist
        titleTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        titleTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        titleTextView.topAnchor.constraint(equalTo: albumImageView.bottomAnchor).isActive = true
        titleTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
             
    }
        
    private func setupPlayControllerView() {
        playControllerView.topAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        playControllerView.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        playControllerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        playControllerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        playControllerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        // play button
        playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playButton.topAnchor.constraint(equalToSystemSpacingBelow: playControllerView.topAnchor, multiplier: 1).isActive = true

        // slider
        slider.widthAnchor.constraint(equalTo: playControllerView.widthAnchor, multiplier: 0.8).isActive = true
        slider.centerXAnchor.constraint(equalTo: playControllerView.centerXAnchor).isActive = true
        slider.topAnchor.constraint(greaterThanOrEqualTo: playButton.bottomAnchor, constant: 5).isActive = true
        slider.bottomAnchor.constraint(lessThanOrEqualTo: lengthLabel.bottomAnchor, constant: -10).isActive = true
//        videoSlider.bottomAnchor.constraint(equalTo: lengthLabel.topAnchor).isActive = true

        //setup label
        lengthLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lengthLabel.bottomAnchor.constraint(equalTo: playControllerView.bottomAnchor, constant: -5).isActive = true
    }
    
    @objc private func handlePause() {
        print("Trying to pause")
        let icon = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .bold))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        playButton.addTarget(self, action: #selector(handlePlay), for: .touchUpInside)
        playButton.setImage(icon, for: .normal)
        player.pause()
    }

    @objc private func handlePlay() {
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
    
    func updateCardView() {
       if let song = curSong {
            let image = UIImage(named: "\(song.album ?? "")")
            albumImageView.translatesAutoresizingMaskIntoConstraints = false
            albumImageView.contentMode = .scaleAspectFit
            albumImageView.image = image
        
            let attributedText = NSMutableAttributedString(string: "\(song.title ?? "")", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)])
            attributedText.append(NSMutableAttributedString(string: "\n\(song.artist ?? "")", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSMutableAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]))
            titleTextView.attributedText = attributedText
            titleTextView.textAlignment = .center
        }
        
    }

    //----------------------- UI Elements --------------------------- //

    lazy var albumImageView: UIImageView = {
        if let song = curSong {
            let image = UIImage(named: "\(song.album ?? "")")
            let imageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            return imageView
        } else {
            print("Current song does not exist!")
            return UIImageView()
       }
    }()
    
    lazy var titleTextView: UITextView = {
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
    
    lazy var playControllerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playButton)
        view.addSubview(slider)
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
