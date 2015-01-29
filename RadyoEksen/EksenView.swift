//
//  EksenView.swift
//  RadyoEksen
//
//  Created by Cem Olcay on 28/01/15.
//  Copyright (c) 2015 Cem Olcay. All rights reserved.
//

import Cocoa
import AVFoundation

class EksenView: NSView {

    @IBOutlet var playButton: NSButton!
    @IBOutlet var eksenLabel: NSTextView!
    
    let url: String = "http://46.20.3.198/listen.pls"
    var player: AVPlayer!
    
    var isPlaying: Bool = false {
        didSet {
            if isPlaying {
                playButton.image = NSImage (named: "pause.png")
            } else {
                playButton.image = NSImage (named: "play.png")
            }
        }
    }
   
    
    @IBAction func playPressed(sender: AnyObject) {
        if isPlaying {
            pause ()
        } else {
            play ()
        }
    }
    
    func play () {
        let item = AVPlayerItem (URL: NSURL (string: url)!)
        
        item.addObserver(self,
            forKeyPath: "timedMetadata",
            options: .New,
            context: nil)
        
        player = AVPlayer (playerItem: item)
        player.play()
        isPlaying = true
    }
    
    func pause () {
        player.pause()
        isPlaying = false
    }

    override func observeValueForKeyPath(
        keyPath: String,
        ofObject object: AnyObject,
        change: [NSObject : AnyObject],
        context: UnsafeMutablePointer<Void>) {
            
        if let item = object as? AVPlayerItem {
            if keyPath == "timedMetadata" {
                var meta = (change["new"] as [AVMetadataItem])[0]
                let label = meta.value() as String
                let title = label.componentsSeparatedByString("\r")
                eksenLabel.string = title[0]
                pushNotification(title[0])
            }
        }
    }
    
    func pushNotification (title: String) {
        let tit = title.componentsSeparatedByString("-")
        let artist = tit[0]
        let song = tit[1]
        
        let notif = NSUserNotification ()
        notif.title = artist
        notif.informativeText = song
        notif.deliveryDate = NSDate (timeInterval: 1, sinceDate: NSDate())
        NSUserNotificationCenter.defaultUserNotificationCenter().scheduleNotification(notif)
    }
}
