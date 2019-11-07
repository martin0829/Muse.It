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
            songs = [
                Song(title: "All You Need To Know", artist: "Gryffin, Slander", genre: "EDM", album: "allyouneedtoknow_album"),
                Song(title: "Only You", artist: "Cheat Codes", genre: "EDM", album: "onlyyou_album"),
                Song(title: "Spicy", artist: "Herve Pagez, Diplo", genre: "EDM", album: "spicy_album"),
                Song(title: "Sweet Dreams", artist: "Eurythmics", genre: "EDM", album: "sweetdreams_album"),
                Song(title: "Trigger", artist: "Major Lazer & Khalid", genre: "EDM", album: "trigger_album"),
                Song(title: "All Around The World", artist: "R3HAB", genre: "EDM", album: "allaroundtheworld_album"),
                Song(title: "Happier", artist: "MarshMello", genre: "EDM", album: "happier_album"),
                Song(title: "Flying On My Own", artist: "Céline Dion", genre: "EDM", album: "flyingonmyown_album"),
                Song(title: "Colour", artist: "MNEK", genre: "EDM", album: "colour_album"),
                Song(title: "Beautiful Now", artist: "Zedd", genre: "EDM", album: "beautifulnow_album"),
                //download album image
                Song(title: "We Don't Care", artist: "Sigala, The Vamps", genre: "EDM", album: "wedontcare_album"),
                Song(title: "Something About You", artist: "Hayden James", genre: "EDM", album: "somethingaboutyou_album"),
                Song(title: "Rushing Back", artist: "Flume", genre: "EDM", album: "rushingback_album"),
                Song(title: "Right Now", artist: "Akon", genre: "EDM", album: "rightnow_album"),
                Song(title: "Beach House", artist: "The Chainsmokers", genre: "EDM", album: "beachhouse_album")
            ]
        }
        if let songs = songs {
            return songs
        } else {
            print("That genre was not found")
            return songs!
        }
    }
}
