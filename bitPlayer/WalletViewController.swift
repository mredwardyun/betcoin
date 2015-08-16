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
    
    let myWalletGUID = "da0151aa-10ad-4a20-874d-e71ef49abf0d"
    let otherWalletGUID = "2e90f007-3cf1-4ff2-acd4-e833cc5857fe"
    let myWalletPassword = "uZPcGmlOGNs5%5E6%245"
    let otherWalletPassword = "rKy12mEcXMt%29qAn8G"
    let myBitcoinAddress = "16KYjc7ZEs5caxoTzYSjaUxBQZtxx9oS7F"
    let otherBitcoinAddress = "1pzbrXxrHEif2Lf57uyFs9acoDt5HWXdW"
    
    let saroToBtc = 100000000.0
    var betAmount = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefault = NSUserDefaults.standardUserDefaults()
        betAmount = userDefault.doubleForKey("betAmount")
        fetchWalletBalance()
        fetchOtherWalletBalance()
        makeOutgoingPayment()
    }

    override func viewDidAppear(animated: Bool) {
        var nav = self.navigationController?.navigationBar
        
        nav?.barStyle = UIBarStyle.Black
        nav?.tintColor = UIColor.blueColor()
        
        let imageView = UIImageView(frame: CGRect(x:0, y:0, width: 40, height: 40))
        imageView.contentMode = .ScaleAspectFit
        
        let image = UIImage(named: "Bitcoin")
        imageView.image = image
        
        navigationItem.titleView = imageView
    }
    
    func fetchWalletBalance() {
        let url = NSURL(string: "https://blockchain.info/merchant/\(myWalletGUID)/balance?password=\(myWalletPassword)")!
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
            
            let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
            let sarotoshi:AnyObject = dictionary["balance"]!
            let btc = sarotoshi as? NSNumber
            let balance = Double(btc!.longLongValue)/self.saroToBtc
            
            self.myWalletBalance.text = NSString(format: "%.4f BTC", balance) as String
        }
        task.resume()
    }
    
    func fetchOtherWalletBalance() {
        let url = NSURL(string: "https://blockchain.info/merchant/\(otherWalletGUID)/balance?password=\(otherWalletPassword)")!
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
            
            let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
            let sarotoshi:AnyObject = dictionary["balance"]!
            let btc = sarotoshi as? NSNumber
            let balance = Double(btc!.longLongValue)/self.saroToBtc
            
            self.otherWalletBalance.text = NSString(format: "%.4f BTC", balance) as String
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
            
            println("bet completed")
        }
        
        task.resume()
        
        fetchWalletBalance()
        fetchOtherWalletBalance()
    }
}
