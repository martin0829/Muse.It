import UIKit
import AVKit

class LibraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var songs: [Song] = []
    var playerItems: [AVPlayerItem] = []
    let songsTableView = UITableView()
    let songViewController = SongViewController()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        cell.textLabel?.text = songs[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        songViewController.curSong = songs[indexPath.row]
        let playerItem = playerItems[indexPath.row]
        songViewController.player.replaceCurrentItem(with: playerItem)
        songViewController.updateCardView()
        present(songViewController, animated: true, completion: {
            self.songViewController.handlePlay()
        })
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Library"
        songViewController.songs = songs
        
        view.addSubview(songsTableView)
        songsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "songCell")
        songsTableView.dataSource = self
        songsTableView.delegate = self
        
        songsTableView.translatesAutoresizingMaskIntoConstraints = false
        songsTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        songsTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        songsTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        songsTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }
    
    func addSong(_ song: Song) {
        songs.append(song)
        let filePath = Bundle.main.path(forResource: song.title, ofType: "mp3")
        let fileURL = URL(fileURLWithPath: filePath!)
        let avAsset = AVAsset(url: fileURL as URL)
        let assetKeys = ["playable"]
        let playerItem = AVPlayerItem(asset: avAsset, automaticallyLoadedAssetKeys: assetKeys)
        playerItems.append(playerItem)
        songsTableView.reloadData()
        print("reloaded data")
    }
}


