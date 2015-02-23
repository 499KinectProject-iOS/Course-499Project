// Playground - noun: a place where people can play

import UIKit
import XCPlayground
import SwiftHTTP

//XCPSetExecutionShouldContinueIndefinitely()

var request = HTTPTask()
request.GET("http://vluxe.io", parameters: nil, success: {(response: HTTPResponse) in
    if response.responseObject != nil {
        let data = response.responseObject as NSData
        let str = NSString(data: data, encoding: NSUTF8StringEncoding)
        println("response: \(str)") //prints the HTML of the page
    }
    },failure: {(error: NSError) in
        println("error: \(error)")
})