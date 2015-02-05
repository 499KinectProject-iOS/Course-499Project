//
//  ViewController.swift
//  Course-499Project
//
//  Created by 陈喆 on 15/2/4.
//  Copyright (c) 2015年 Zhe Chen. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {

    var moviePlayer:MPMoviePlayerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if var filePath = NSBundle.mainBundle().pathForResource("test", ofType: "mp4") {
            var filePathUrl = NSURL.fileURLWithPath(filePath)
            moviePlayer = MPMoviePlayerController(contentURL: filePathUrl)
        } else {
            var url:NSURL = NSURL(string: "http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v")!
            moviePlayer = MPMoviePlayerController(contentURL: url)
        }
        
        
        // 'Exit Fullscreen' listener
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onMPMoviePlayerWillExitFullscreenNotificationReceived:", name: MPMoviePlayerWillExitFullscreenNotification, object: nil)

        // 'Did Finish' listener
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onMPMoviePlayerPlaybackDidFinishNotificationReceived:", name: MPMoviePlayerPlaybackDidFinishNotification, object: nil)
    }
    
    // work with NotificationCenter
    func onMPMoviePlayerWillExitFullscreenNotificationReceived(notification: NSNotification){
        println("onMPMoviePlayerWillExitFullscreenNotificationReceived")
        self.moviePlayer.view.removeFromSuperview()
    }
    
    // work with NotificationCenter
    func onMPMoviePlayerPlaybackDidFinishNotificationReceived(notification: NSNotification) {
        println("onMPMoviePlayerPlaybackDidFinishNotificationReceived")
        self.moviePlayer.view.removeFromSuperview()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func PlayVideo(sender: UIButton) {
        moviePlayer.view.sizeToFit()
        self.view.addSubview(moviePlayer.view)
        moviePlayer.fullscreen = true
        moviePlayer.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        moviePlayer.controlStyle = MPMovieControlStyle.Embedded

        
    }

}

