//
//  WalletViewController.swift
//  bitPlayer
//
//  Created by Edward Yun on 8/15/15.
//  Copyright (c) 2015 Edward Yun. All rights reserved.
//

import UIKit
import Foundation

class WalletViewController: UIViewController {
    
    @IBOutlet weak var myWalletBalance: UILabel!
    @IBOutlet weak var otherWalletBalance: UILabel!
    @IBOutlet weak var betDescription: UILabel!
    
    let myWalletGUID = "da0151aa-10ad-4a20-874d-e71ef49abf0d"
    let otherWalletGUID = "2e90f007-3cf1-4ff2-acd4-e833cc5857fe"
    let myWalletPassword = "uZPcGmlOGNs5%5E6%245"
    let otherWalletPassword = "rKy12mEcXMt%29qAn8G"
    let myBitcoinAddress = "16KYjc7ZEs5caxoTzYSjaUxBQZtxx9oS7F"
    let otherBitcoinAddress = "1pzbrXxrHEif2Lf57uyFs9acoDt5HWXdW"
    
    let saroToBtc = 100000000.0
    var betAmount = 2.67
    var matchup = 0
    var stat = 0
    var home = false
    let userDefault = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBets()
        fetchWalletBalance()
        fetchOtherWalletBalance()
        populateBets(betAmount, matchup: matchup, stat: stat, home: home)
        //verifyBets()
        //makeOutgoingPayment()
    }
    
    override func viewDidAppear(animated: Bool) {
        getBets()
        populateBets(betAmount, matchup: matchup, stat: stat, home: home)
    }
    
    func getBets() {
        betAmount = userDefault.doubleForKey("betAmount")
        matchup = userDefault.integerForKey("matchup")
        stat = userDefault.integerForKey("stat")
        home = userDefault.boolForKey("home")    }
    
    func populateBets(betAmount: Double, matchup: Int, stat: Int, home: Bool) {
        var player = ""
        var condition = ""
        if matchup == 0 {
            if home {
                player = "James Harden"
            } else {
                player = "Stephen Curry"
            }
        } else if matchup == 1 {
            if home {
                player = "LeBron James"
            } else {
                player = "Kevin Durant"
            }
        } else {
            if home {
                player = "Blake Griffin"
            } else {
                player = "Anthony Davis"
            }
        }
        if stat == 0 {
            condition = "score the most points"
        } else if stat == 1 {
            condition = "create the most assists"
        } else {
            condition = "shoot the best percentage"
        }
        betDescription.text = NSString(format: "%.4f BTC on \(player) to \(condition)", betAmount) as String
        println("matchup is \(matchup). home is \(home). stat is \(stat)")
    }
    
    func fetchWalletBalance() {
        let url = NSURL(string: "https://blockchain.info/merchant/\(myWalletGUID)/balance?password=\(myWalletPassword)")!
        let request = NSMutableURLRequest(URL: url)
        var balance = 0.0
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data: NSData!, response: NSURLResponse!, error: NSError!) in
            
            if error != nil {
                // Handle error...
                return
            }
            
            //            println(error)
            //            println(response)
            //            println(NSString(data: data, encoding: NSUTF8StringEncoding))
            dispatch_async(dispatch_get_main_queue(), {
                let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
                let sarotoshi:AnyObject = dictionary["balance"]!
                let btc = sarotoshi as? NSNumber
                balance = Double(btc!.longLongValue)/self.saroToBtc
                self.myWalletBalance!.text = NSString(format: "My wallet contains %.4f BTC, or \u{24}%.2f", balance, balance*261.1) as String
            })
        }
        task.resume()
        
    }
    
    func fetchOtherWalletBalance() {
        let url = NSURL(string: "https://blockchain.info/merchant/\(otherWalletGUID)/balance?password=\(otherWalletPassword)")!
        let request = NSMutableURLRequest(URL: url)
        var balance = 0.0
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data: NSData!, response: NSURLResponse!, error: NSError!) in
            
            if error != nil {
                // Handle error...
                return
            }
            
            //            println(error)
            //            println(response)
            //            println(NSString(data: data, encoding: NSUTF8StringEncoding))
            dispatch_async(dispatch_get_main_queue(), {
                let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
                let sarotoshi:AnyObject = dictionary["balance"]!
                let btc = sarotoshi as? NSNumber
                balance = Double(btc!.longLongValue)/self.saroToBtc
                self.otherWalletBalance!.text = NSString(format: "The other wallet contains %.4f BTC, or \u{24}%.2f", balance, balance*261.1) as String
            })
            
        }
        task.resume()
    }
    
    func makeOutgoingPayment() {
        let url = NSURL(string: "https://blockchain.info/merchant/\(myWalletGUID)/payment?password=\(myWalletPassword)&address=\(otherBitcoinAddress)&amount=500000&from=\(myBitcoinAddress)")!
        //\(betAmount/self.saroToBtc)
        let request = NSMutableURLRequest(URL: url)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data: NSData!, response: NSURLResponse!, error: NSError!) in
            
            if error != nil {
                // Handle error...
                return
            }
            
            //            println(error)
            //            println(response)
            //            println(NSString(data: data, encoding: NSUTF8StringEncoding))
            
            dispatch_async(dispatch_get_main_queue(), {
                
            })
        }
        
        task.resume()
        
        fetchWalletBalance()
        fetchOtherWalletBalance()
    }
}
