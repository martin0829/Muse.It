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
                Song(title: "Find An Island", artist: "BENEE", genre: "Pop", album: "findanisland_album", timestamp:"0:07"),
                Song(title: "Kinfolks", artist: "Sam Hunt", genre: "Pop", album: "kinfolks_album", timestamp:"0:36"),
                Song(title: "Don't Start Now", artist: "Dua Lipa", genre: "Pop", album: "dontstartnow_album", timestamp:"0:47"),
                Song(title: "Lucky", artist: "Chelsea Cutler", genre: "Pop", album: "lucky_album", timestamp:"0:00"),
                Song(title: "Never Seen The Rain", artist: "Tones and I", genre: "Pop", album: "neverseentherain_album", timestamp:"1:07"),
                Song(title: "Broke", artist: "Samm Henshaw", genre: "Pop", album: "broke_album", timestamp:"0:55"),
                Song(title: "All You Need To Know", artist: "Gryffin, Slander", genre: "Pop", album: "allyouneedtoknow_album", timestamp:"0:50"),
                Song(title: "Me Necesita", artist: "PRETTYMUCH", genre: "Pop", album: "menecesita_album", timestamp:"0:49"),
                Song(title: "Lose You To Love Me", artist: "Selena Gomez", genre: "Pop", album: "loseyoutoloveme_album", timestamp:"1:07"),
                Song(title: "Easy", artist: "Camila Cabello", genre: "Pop", album: "easy_album", timestamp:"0:53"),
                Song(title: "Good As Hell", artist: "Lizzo", genre: "Pop", album: "goodashell_album", timestamp:"0:00"),
                Song(title: "Me Necesita", artist: "PRETTYMUCH", genre: "Pop", album: "menecesita_album", timestamp:"0:49"),
                Song(title: "Lose Control", artist: "MEDUZA", genre: "Pop", album: "losecontrol_album", timestamp:"0:33"),
                Song(title: "Photosynthesis", artist: "Saba", genre: "Pop", album: "photosynthesis_album", timestamp:"0:17"),
                Song(title: "Hold It Down", artist: "Mia Gladstone", genre: "Pop", album: "holditdown_album", timestamp:"2:14"),
                Song(title: "Bohemian Rhapsody", artist: "Queen", genre: "Pop", album: "bohemianrhapsody_album", timestamp:"0:53"),
                Song(title: "Chasing Cars", artist: "Snow Patrol", genre: "Pop", album: "chasingcars_album", timestamp:"0:35"),
                Song(title: "Lucky", artist: "CHOKER", genre: "Pop", album: "chokerlucky_album", timestamp:"2:20"),
                Song(title: "Sunkissed", artist: "Khai Dreams", genre: "Pop", album: "sunkissed_album", timestamp:"0:37"),
                Song(title: "Undrunk", artist: "Fletcher", genre: "Pop", album: "undrunk_album", timestamp:"0:50"),
                Song(title: "Indigo", artist: "88rising & niki", genre: "Pop", album: "indigo_album", timestamp:"2:17")
            ]
        } else if genre == "Hip Hop" {
            songs = [
                Song(title: "Panini", artist: "Lil Nas X", genre: "Pop", album: "panini_album", timestamp:"0:25"),
                Song(title: "Downtown", artist: "Macklemore", genre: "Pop", album: "downtown_album", timestamp:"1:06"),
                Song(title: "Immortal", artist: "21 Savage", genre: "Pop", album: "immortal_album", timestamp:"2:30"),
                Song(title: "Lose Yourself", artist: "Eminem", genre: "Pop", album: "loseyourself_album", timestamp:"1:00"),
                Song(title: "Brass Monkey", artist: "Beastie Boys", genre: "Pop", album: "brassmonkey_album", timestamp:"0:14"),
                Song(title: "Straight Outta Compton", artist: "NWA", genre: "Pop", album: "straightouttacompton_album", timestamp:"0:10"),
                Song(title: "God's Plan", artist: "Drake", genre: "Pop", album: "godsplan_album", timestamp:"0:40"),
                Song(title: "Send It Up", artist: "Kanye West", genre: "Pop", album: "senditup_album", timestamp:"1:20"),
                Song(title: "Me You", artist: "Russ", genre: "Pop", album: "meyou_album", timestamp:"0:39"),
                Song(title: "I am the Greatest", artist: "Logic", genre: "Pop", album: "iamthegreatest_album", timestamp:"1:00"),
                Song(title: "My Adidas", artist: "Run DMC", genre: "Pop", album: "myadidas_album", timestamp:"0:00"),
                Song(title: "When I Grow Up", artist: "NF", genre: "Pop", album: "whenigrowup_album", timestamp:"0:20"),
                Song(title: "Too Fast", artist: "AKLO", genre: "Pop", album: "toofast_album", timestamp:"0:20"),
                Song(title: "Shut em Down", artist: "Public Enemy", genre: "Pop", album: "shutemdown_album", timestamp:"0:50"),
                Song(title: "Big Tipper", artist: "Young Thug", genre: "Pop", album: "bigtipper_album", timestamp:"0:30")
            ]
        } else {
            songs = [
                Song(title: "All You Need To Know", artist: "Gryffin, Slander", genre: "EDM", album: "allyouneedtoknow_album", timestamp: "3:11"),
                Song(title: "Only You", artist: "Cheat Codes", genre: "EDM", album: "onlyyou_album", timestamp: "1:57"),
                Song(title: "Spicy", artist: "Herve Pagez, Diplo", genre: "EDM", album: "spicy_album", timestamp: "0:05"),
                Song(title: "Sweet Dreams", artist: "Eurythmics", genre: "EDM", album: "sweetdreams_album", timestamp: "0:53"),
                Song(title: "Trigger", artist: "Major Lazer & Khalid", genre: "EDM", album: "trigger_album", timestamp: "2:07"),
                Song(title: "All Around The World", artist: "R3HAB", genre: "EDM", album: "allaroundtheworld_album", timestamp: "0:00"),
                Song(title: "Happier", artist: "MarshMello", genre: "EDM", album: "happier_album", timestamp: "2:53"),
                Song(title: "Flying On My Own", artist: "Céline Dion", genre: "EDM", album: "flyingonmyown_album", timestamp: "2:36"),
                Song(title: "Colour", artist: "MNEK", genre: "EDM", album: "colour_album", timestamp: "0:23"),
                Song(title: "Beautiful Now", artist: "Zedd", genre: "EDM", album: "beautifulnow_album", timestamp: "3:37"),
                Song(title: "We Don't Care", artist: "Sigala, The Vamps", genre: "EDM", album: "wedontcare_album", timestamp: "2:39"),
                Song(title: "Something About You", artist: "Hayden James", genre: "EDM", album: "somethingaboutyou_album", timestamp: "2:22"),
                Song(title: "Rushing Back", artist: "Flume", genre: "EDM", album: "rushingback_album", timestamp: "1:22"),
                Song(title: "Right Now", artist: "Akon", genre: "EDM", album: "rightnow_album", timestamp: "1:07"),
                Song(title: "Beach House", artist: "The Chainsmokers", genre: "EDM", album: "beachhouse_album", timestamp: "0:52")
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
