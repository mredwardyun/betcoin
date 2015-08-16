//
//  ViewController.swift
//  bitPlayer
//
//  Created by Edward Yun on 8/15/15.
//  Copyright (c) 2015 Edward Yun. All rights reserved.
//

import UIKit
import Parse
import Bolts

class TodaysGamesViewController: UIViewController {
    
    @IBOutlet weak var homePlayerLabel: UILabel!
    @IBOutlet weak var awayPlayerLabel: UILabel!
    var homePlayerStar: String!
    var awayPlayerStar: String!
    @IBOutlet weak var homePlayerImageView: UIImageView!
    var homePlayerStats = [String: Double]()
    @IBOutlet weak var awayPlayerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var homePPGLabel: UILabel!
    @IBOutlet weak var homeAPGLabel: UILabel!
    @IBOutlet weak var homeFGPLabel: UILabel!
    @IBOutlet weak var awayPPGLabel: UILabel!
    @IBOutlet weak var awayAPGLabel: UILabel!
    @IBOutlet weak var awayFGPLabel: UILabel!
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var awayButton: UIButton!
    
    @IBOutlet weak var gameSelectionControl: UISegmentedControl!
    @IBOutlet weak var gameSelectionLabel: UILabel!
    @IBOutlet weak var statsSelectionControl: UISegmentedControl!
    @IBOutlet weak var statsSelectionLabel: UILabel!
    
    @IBOutlet weak var betSlider: UISlider!
    @IBOutlet weak var betLabel: UILabel!
    @IBOutlet weak var usdAmount: UILabel!
    @IBOutlet weak var btcAmount: UILabel!
    
    var betAmount = 0.0
    let userDefault = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var query = PFQuery(className:"NbaSchedule")
        query.getObjectInBackgroundWithId("I41iguslOF") {
            (nbaGame: PFObject?, error:NSError?) -> Void in
            if error == nil {
                if let nbaGame = nbaGame {
                    self.homePlayerLabel.text = nbaGame["homeTeamStar"] as? String
                    self.awayPlayerLabel.text = nbaGame["awayTeamStar"] as? String
                    var homePlayerStats = nbaGame["homeStarStats"] as! [Double]
                    var awayPlayerStats = nbaGame["awayStarStats"] as! [Double]
                    self.homePPGLabel.text = NSString(format: "%.1f PPG", homePlayerStats[0]) as String
                    self.homeAPGLabel.text = NSString(format: "%.1f ASG", homePlayerStats[1]) as String
                    self.homeFGPLabel.text = NSString(format: "%.1f FG%%", homePlayerStats[2]) as String
                    self.awayPPGLabel.text = NSString(format: "%.1f PPG", awayPlayerStats[0]) as String
                    self.awayAPGLabel.text = NSString(format: "%.1f APG", awayPlayerStats[1]) as String
                    self.awayFGPLabel.text = NSString(format: "%.1f FG%%", awayPlayerStats[2]) as String

                }
                if let playerPhoto = nbaGame?["homePlayerImage"] as? PFFile{
                    playerPhoto.getDataInBackgroundWithBlock {
                        (imageData: NSData?, error: NSError?) -> Void in
                        if (error == nil) {
                            self.homePlayerImageView.image = UIImage(data:imageData!)
                        }
                    }
                }
                if let playerPhoto = nbaGame?["awayPlayerImage"] as? PFFile{
                    playerPhoto.getDataInBackgroundWithBlock {
                        (imageData: NSData?, error: NSError?) -> Void in
                        if (error == nil) {
                            self.awayPlayerImageView.image = UIImage(data:imageData!)
                        }
                    }
                }
            } else {
                println(error)
            }
        }


    }
    
    @IBAction func gameChanged(sender: AnyObject) {
    }
    
    @IBAction func statsChanged(sender: UISegmentedControl) {
        
        switch statsSelectionControl.selectedSegmentIndex
        {
        case 0:
            titleLabel.text = "Who will score the most points tonight?"
        case 1:
            titleLabel.text = "Who will have the most assists tonight?"
        case 2:
            titleLabel.text = "Who will shoot the best percentage tonight?"
        default:
            break
        }
        
    }

    @IBAction func betSliderValueChanged(sender: UISlider) {
        betAmount = Double(sender.value)
        var usdValue = betAmount*266.91
        self.btcAmount.text = NSString(format: "%.4f BTC", betAmount) as String
        self.usdAmount.text = NSString(format:"\u{24}%.2f", usdValue) as String
        userDefault.setDouble(betAmount, forKey: "betAmount")
    }
    
    @IBAction func homePlayerTouched(sender: UIButton) {
        colorHomeText(UIColor.greenColor())
        colorAwayText(UIColor.blackColor())
    }
    
    @IBAction func awayPlayerTouched(sender: UIButton) {
        colorAwayText(UIColor.greenColor())
        colorHomeText(UIColor.blackColor())
    }
    
    
    func colorHomeText(color: UIColor) {
        homePlayerLabel.textColor = color
        homePPGLabel.textColor = color
        homeAPGLabel.textColor = color
        homeFGPLabel.textColor = color
    }
    
    func colorAwayText(color: UIColor) {
        awayPlayerLabel.textColor = color
        awayPPGLabel.textColor = color
        awayAPGLabel.textColor = color
        awayFGPLabel.textColor = color
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
