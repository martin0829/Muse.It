//
//  SongAPI.swift
//  TableViewExample
//
//  Created by Martin Kim on 10/17/19.
//  Copyright © 2019 Martin Kim. All rights reserved.
//
import UIKit

class SongAPI {
    static func getSongs(genre: String) -> [Song] {
        var songs: [Song]? = nil
        if genre == "Pop" {
            songs = [
                Song(title: "Find An Island", artist: "Joji", genre: "Pop", album: "findanisland_album"),
                Song(title: "Kinfolks", artist: "Travis Scott", genre: "Pop", album: "album_cover3"),
                Song(title: "Don't Start Now", artist: "Cole Swindelle", genre: "Pop", album: "album_cover2"),
                Song(title: "Lucky", artist: "Travis Scott", genre: "Pop", album: "album_cover3"),
                Song(title: "Neer Seen The Rain", artist: "Joji", genre: "Pop", album: "album_cover1"),
                Song(title: "Broke", artist: "Joji", genre: "Pop", album: "album_cover1"),
                Song(title: "All You Need To Know", artist: "Travis Scott", genre: "Pop", album: "album_cover3"),
                Song(title: "Me Necesita", artist: "Cole Swindelle", genre: "Pop", album: "album_cover2"),
                Song(title: "Lose You To Love Me", artist: "Travis Scott", genre: "Pop", album: "album_cover3"),
                Song(title: "Easy", artist: "Joji", genre: "Pop", album: "album_cover1"),
                Song(title: "Broke", artist: "Joji", genre: "Pop", album: "album_cover1"),
                Song(title: "Never Seen The Rain", artist: "Travis Scott", genre: "Pop", album: "album_cover3"),
                Song(title: "Good As Hell", artist: "Cole Swindelle", genre: "Pop", album: "album_cover2"),
                Song(title: "Good As Hell", artist: "Travis Scott", genre: "Pop", album: "album_cover3"),
                Song(title: "Me Necesita", artist: "Joji", genre: "Pop", album: "album_cover1")
            ]
        } else if genre == "Hip Hop" {
            songs = [
                Song(title: "Panini", artist: "Joji", genre: "Pop", album: "album_cover1"),
                Song(title: "Downtown", artist: "Travis Scott", genre: "Pop", album: "album_cover3"),
                Song(title: "Immortal", artist: "Cole Swindelle", genre: "Pop", album: "album_cover2"),
                Song(title: "Lose Yourself", artist: "Travis Scott", genre: "Pop", album: "album_cover3"),
                Song(title: "Brass Monkey", artist: "Joji", genre: "Pop", album: "album_cover1"),
                Song(title: "Straight Outta Compton", artist: "Joji", genre: "Pop", album: "album_cover1"),
                Song(title: "God's Plan", artist: "Travis Scott", genre: "Pop", album: "album_cover3"),
                Song(title: "Send It Up", artist: "Cole Swindelle", genre: "Pop", album: "album_cover2"),
                Song(title: "Me You", artist: "Travis Scott", genre: "Pop", album: "album_cover3"),
                Song(title: "I am the Greatest", artist: "Joji", genre: "Pop", album: "album_cover1"),
                Song(title: "My Adidas", artist: "Joji", genre: "Pop", album: "album_cover1"),
                Song(title: "When I Grow Up", artist: "Travis Scott", genre: "Pop", album: "album_cover3"),
                Song(title: "Too Fast", artist: "Cole Swindelle", genre: "Pop", album: "album_cover2"),
                Song(title: "Shut em Down", artist: "Travis Scott", genre: "Pop", album: "album_cover3"),
                Song(title: "Big Tipper", artist: "Joji", genre: "Pop", album: "album_cover1")
            ]
        } else {
            
        }
        if let songs = songs {
            return songs
        } else {
            print("That genre was not found")
            return songs!
        }
    }
}
