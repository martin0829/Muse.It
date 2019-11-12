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
                Song(title: "Find An Island", artist: "BENEE", genre: "Pop", album: "findanisland_album"),
                Song(title: "Kinfolks", artist: "Sam Hunt", genre: "Pop", album: "kinfolks_album"),
                Song(title: "Don't Start Now", artist: "Dua Lipa", genre: "Pop", album: "dontstartnow_album"),
                Song(title: "Lucky", artist: "Chelsea Cutler", genre: "Pop", album: "lucky_album"),
                Song(title: "Never Seen The Rain", artist: "Tones and I", genre: "Pop", album: "neverseentherain_album"),
                Song(title: "Broke", artist: "Joji", genre: "Samm Henshaw", album: "broke_album"),
                Song(title: "All You Need To Know", artist: "Gryffin, Slander", genre: "Pop", album: "allyouneedtoknow_album"),
                Song(title: "Me Necesita", artist: "PRETTYMUCH", genre: "Pop", album: "menecesita_album"),
                Song(title: "Lose You To Love Me", artist: "Selena Gomez", genre: "Pop", album: "loseyoutoloveme_album"),
                Song(title: "Easy", artist: "Camila Cabello", genre: "Pop", album: "easy_album"),
                Song(title: "Broke", artist: "Samm Henshaw", genre: "Pop", album: "broke_album"),
//                Song(title: "Never Seen The Rain", artist: "Tones and I", genre: "Pop", album: "neverseentherain_album"),
                Song(title: "Good As Hell", artist: "Lizzo", genre: "Pop", album: "goodashell_album"),
//                Song(title: "Good As Hell", artist: "Lizzo", genre: "Pop", album: "goodashell_album"),
                Song(title: "Me Necesita", artist: "PRETTYMUCH", genre: "Pop", album: "menecesita_album")
            ]
        } else if genre == "Hip Hop" {
            songs = [
                Song(title: "Panini", artist: "Lil Nas X", genre: "Pop", album: "panini_album"),
                Song(title: "Downtown", artist: "Macklemore", genre: "Pop", album: "downtown_album"),
                Song(title: "Immortal", artist: "21 Savage", genre: "Pop", album: "immortal_album"),
                Song(title: "Lose Yourself", artist: "Eminem", genre: "Pop", album: "loseyourself_album"),
                Song(title: "Brass Monkey", artist: "Beastie Boys", genre: "Pop", album: "brassmonkey_album"),
                Song(title: "Straight Outta Compton", artist: "NWA", genre: "Pop", album: "straightouttacompton_album"),
                Song(title: "God's Plan", artist: "Drake", genre: "Pop", album: "godsplan_album"),
                Song(title: "Send It Up", artist: "Kanye West", genre: "Pop", album: "senditup_album"),
                Song(title: "Me You", artist: "Russ", genre: "Pop", album: "meyou_album"),
                Song(title: "I am the Greatest", artist: "Logic", genre: "Pop", album: "iamthegreatest_album"),
                Song(title: "My Adidas", artist: "Run DMC", genre: "Pop", album: "myadidas_album"),
                Song(title: "When I Grow Up", artist: "NF", genre: "Pop", album: "whenigrowup_album"),
                Song(title: "Too Fast", artist: "AKLO", genre: "Pop", album: "toofast_album"),
                Song(title: "Shut em Down", artist: "Public Enemy", genre: "Pop", album: "shutemdown_album"),
                Song(title: "Big Tipper", artist: "Young Thug", genre: "Pop", album: "bigtipper_album")
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
