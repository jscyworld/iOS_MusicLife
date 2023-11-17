//
//  TrackManager.swift
//  MusicLife
//
//  Created by JONG SOO KIM on 11/17/23.
//

import UIKit
import AVFoundation

class TrackManager {
    
    var tracks: [AVPlayerItem] = []
    var albums: [Album] = []
    var todaysTrack: AVPlayerItem?
    
    init() {
        let tracks = loadTrack()
        self.tracks = tracks
        self.albums = loadAlbum(tracks: tracks)
        self.todaysTrack = self.tracks.randomElement()
    }
    
    func loadTrack() -> [AVPlayerItem] {
        // read files -> make them AVPlayerItem
        let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []
//        var items: [AVPlayerItem] = []
//        for url in urls {
//            let item = AVPlayerItem(url: url)
//            items.append(item)
//        }
        let items = urls.map { url in
            return AVPlayerItem(url: url)
        }
        return items
    }
    
    func track(at index: Int) -> Track? {
        let playerItem = tracks[index]
        let track = playerItem.convertToTrack()
        return track
    }
    
    func loadAlbum(tracks: [AVPlayerItem]) -> [Album] {
        let trackList: [Track] = tracks.compactMap { track in
            track.convertToTrack()
        }
        let albumDics = Dictionary(grouping: trackList) { track in
            track.albumName
        }
        var albums: [Album] = []
        for (key, value) in albumDics {
            let title = key
            let tracks = value
            let album = Album(title: title, tracks: tracks)
            albums.append(album)
        }
        return albums
    }
    
    func loadOtherTodaysTrack() {
        self.todaysTrack = self.tracks.randomElement()
    }
}
