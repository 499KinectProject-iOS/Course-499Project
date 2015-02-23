//
//  ViewController.swift
//  Course-499Project
//
//  Created by 陈喆 on 15/2/4.
//  Copyright (c) 2015年 Zhe Chen. All rights reserved.
//

import UIKit
import MediaPlayer
import Foundation
import SwiftHTTP





class ViewController: UIViewController {

    var moviePlayer:MPMoviePlayerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if var filePath = NSBundle.mainBundle().pathForResource("123", ofType: "mp4") {
            var filePathUrl = NSURL.fileURLWithPath(filePath)
            moviePlayer = MPMoviePlayerController(contentURL: filePathUrl)
        } else {
            
            
            //create a HTTP request to server
            //retrieve data via API, json.
            var request = HTTPTask()
            request.GET("http://129.105.36.214/index2.php?StartTime=2015-02-13%2000:00:00&EndTime=2015-02-13%2023:00:00", parameters: nil, success: {(response: HTTPResponse) in
                if let data = response.responseObject as? NSData {
                    let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("response: \(str)") //prints the HTML of the page
                }
                },failure: {(error: NSError, response: HTTPResponse?) in
                    println("error: \(error)")
            })
            
            
            var url:NSURL = NSURL(string: "http://129.105.36.214/home/juchenquan/test.mp4")!
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

