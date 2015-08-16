//
//  ScoresViewController.swift
//  bitPlayer
//
//  Created by Edward Yun on 8/15/15.
//  Copyright (c) 2015 Edward Yun. All rights reserved.
//

import UIKit

class PlayerStats: NSObject {
    var name: String
    var image: UIImage
    var ppg: Double
    var apg: Double
    var fgp: Double
    
    init(name: String, image: UIImage, ppg: Double, apg: Double, fgp: Double){
        self.name = name
        self.image = image
        self.ppg = ppg
        self.apg = apg
        self.fgp = fgp
        
        super.init()
    }
}

class ScoresViewController: UITableViewController {
    
    var scores: [PlayerStats] = scoresData
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlayerCell", forIndexPath: indexPath) as! UITableViewCell
        
        let scores = generateData()
        let score = scores[indexPath.row] as PlayerStats
        
        if let nameLabel = cell.viewWithTag(100) as? UILabel {
            nameLabel.text = score.name
        }
        if let imageView = cell.viewWithTag(101) as? UIImageView {
            imageView.image = score.image
        }
        if let ppgLabel = cell.viewWithTag(102) as? UILabel {
            ppgLabel.text = NSString(format: "%.1f points", score.ppg) as String
        }
        if let apgLabel = cell.viewWithTag(103) as? UILabel {
            apgLabel.text = NSString(format: "%.1f assists", score.apg) as String
        }
        if let fgpLabel = cell.viewWithTag(104) as? UILabel {
            fgpLabel.text = NSString(format: "%.1f FG%%", score.fgp) as String
        }
        
        return cell
    }
    
    func generateData() -> [PlayerStats] {
        let scoresData = [
            PlayerStats(name: "James Harden", image: UIImage(named: "James Harden")!, ppg: 27.0, apg: 7.0, fgp: 44.0),
            PlayerStats(name: "Stephen Curry", image: UIImage(named: "Stephen Curry")!, ppg: 25.8, apg: 7.7, fgp: 48.5),
            PlayerStats(name: "LeBron James", image: UIImage(named: "LeBron James")!, ppg: 0.0, apg: 0.0, fgp: 0.0),
            PlayerStats(name: "Kevin Durant", image: UIImage(named: "Kevin Durant")!, ppg: 0.0, apg: 0.0, fgp: 0.0),
            PlayerStats(name: "Blake Griffin", image: UIImage(named: "Blake Griffin")!, ppg: 0.0, apg: 0.0, fgp: 0.0),
            PlayerStats(name: "Anthony Davis", image: UIImage(named: "Anthony Davis")!, ppg: 0.0, apg: 0.0, fgp: 0.0)]
        
        return scoresData
    }
    
    
    // Use this when grabbing live data.
    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("PlayerCell", forIndexPath: indexPath) as! UITableViewCell
//        
//        let score = scores[indexPath.row] as PlayerStats
//        
//        if let nameLabel = cell.viewWithTag(100) as? UILabel {
//            nameLabel.text = score.name
//        }
//        if let imageView = cell.viewWithTag(101) as? UIImageView {
//            imageView.image = score.image
//        }
//        if let ppgLabel = cell.viewWithTag(102) as? UILabel {
//            ppgLabel.text = NSString(format: "%.1f points", score.ppg) as String
//        }
//        if let apgLabel = cell.viewWithTag(103) as? UILabel {
//            apgLabel.text = NSString(format: "%.1f assists", score.apg) as String
//        }
//        if let fgpLabel = cell.viewWithTag(104) as? UILabel {
//            fgpLabel.text = NSString(format: "%.1f FG%%", score.fgp) as String
//        }
//        
//        return cell
//    }
    
}

