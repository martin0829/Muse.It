import UIKit

class LibraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var songs: [Song] = []
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
        present(songViewController, animated: true, completion: nil)
        print(songs)
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
        songsTableView.reloadData()
        print("reloaded data")
    }
}


