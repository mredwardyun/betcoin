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
        
        let scores = [generatePlayerData("James Harden"), generatePlayerData("Stephen Curry"), generatePlayerData("LeBron James"), generatePlayerData("Kevin Durant"), generatePlayerData("Blake Griffin"), generatePlayerData("Anthony Davis")]
        
        return scores
    }
    
    func generatePlayerData(playerName: String) -> PlayerStats {
        var image = UIImage(named: playerName)
        var points = Double(arc4random_uniform(140) + 200)/10
        var assists = Double(arc4random_uniform(70) + 30)/10
        var fgp = Double(arc4random_uniform(200) + 350)/10
        return PlayerStats(name: playerName, image: image!, ppg: points, apg: assists, fgp: fgp)
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

