//
//  SongAPI.swift
//  TableViewExample
//
//  Created by Martin Kim on 10/17/19.
//  Copyright © 2019 Martin Kim. All rights reserved.
//
import UIKit

class SongAPI {
    static func getSongs() -> [Song] {
        let songs = [
            Song(title: "SLOW DANCING IN THE DARK", artist: "Joji", genre: "R&B", url: Bundle.main.path(forResource: "SLOW DANCING IN THE DARK", ofType: "mp3"), album: "album_cover1"),
            Song(title: "HIGHEST IN THE ROOM", artist: "Travis Scott", genre: "Hip Hop", url: Bundle.main.path(forResource: "HIGHEST IN THE ROOM", ofType: "mp3"), album: "album_cover3")
        ]
        return songs
    }
}
