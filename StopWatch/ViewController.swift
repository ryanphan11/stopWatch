//
//  ViewController.swift
//  StopWatch
//
//  Created by Ryan Phan on 11/2/18.
//  Copyright © 2018 Ryan Phan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var secondLabel: UILabel!
    var data = [String]()
    var timer = Timer()
    var second = 0
  
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if (indexPath.row < data.count) {
            cell.textLabel?.text = data[indexPath.row]
        }
        else {
            cell.textLabel?.text = ""
        }
        return cell
    }
    @objc func updateTime() {
        second += 1;
        secondLabel.text = timeString(time:TimeInterval(second))
    }
    @IBAction func start(_ sender: UIButton) {
        if (!timer.isValid) {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(ViewController.updateTime), userInfo: nil, repeats: true)
            startButton.setTitle("Lap", for: UIControl.State.normal)
        }
        else {
            data.append(timeString(time:TimeInterval(second)))
            tableView.reloadData()
        }
    }
    
    @IBAction func reset(_ sender: UIButton) {
        timer.invalidate()
        second = 0
        secondLabel.text = "\(0)"
        startButton.setTitle("Start", for: UIControl.State.normal)
        data = [String]()
        tableView.reloadData()
    }
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String.init(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }


}

