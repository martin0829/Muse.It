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
            Song(title: "SLOW DANCING IN THE DARK", artist: "Joji", genre: "R&B", album: "album_cover1"),
            Song(title: "HIGHEST IN THE ROOM", artist: "Travis Scott", genre: "Hip Hop", album: "album_cover3"),
            Song(title: "Love You Too Late", artist: "Cole Swindelle", genre: "Pop", album: "album_cover2")
        ]
        return songs
    }
}
