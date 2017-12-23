//
//  RepeatViewController.swift
//  Alarm
//
//  Created by Dheepthaa Anand on 22/11/17.
//  Copyright © 2017 Dheepthaa Anand. All rights reserved.
//

import UIKit

class RepeatViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
   
    var days = ""
    var when = ["Every Sunday","Every Monday","Every Tuesday", "Every Wednesday", "Every Thursday", "Every Friday", "Every Saturday"]
    var str="Every"
    var check = [0,0,0,0,0,0,0]

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .orange
        self.tableView.tableFooterView = UIView()
      
        if UserDefaults.standard.string(forKey: "repeat") != "Never"
        {
            days = UserDefaults.standard.string(forKey: "repeat")!
            if days == "Every weekday"
            {
                check = [0,1,1,1,1,1,0]
            }
            if days == "Every weekend"
            {
                check = [1,0,0,0,0,0,1]
            }
            if days == "Every day"
            {
                check = [1,1,1,1,1,1,1]
            }
            let d = days.components(separatedBy: ",")
            for i in 0...(d.count-1)
            {
                if d[i] == "Every sun" || d[i] == "sun"
                {
                    check[0] = 1
                }
                if d[i] == "mon" || d[i] == "Every mon"
                {
                    check[1] = 1
                }
                if d[i] == "tue" || d[i] == "Every tue"
                {
                    check[2] = 1
                }
                if d[i] == "wed" || d[i] == "Every wed"
                {
                    check[3] = 1
                }
                if d[i] == "thur" || d[i] == "Every thur"
                {
                    check[4] = 1
                }
                if d[i] == "fri" || d[i] == "Every fri"
                {
                    check[5] = 1
                }
                if d[i] == "sat" || d[i] == "Every sat"
                {
                    check[6]=1
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return when.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RepeatTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RepeatTableViewCell
            else {
                fatalError("The dequeued cell is not an instance of RepeatTableViewCell.")
        }
        cell.when.text = when[indexPath.row]
        if check[indexPath.row] == 0
        {
               cell.accessoryType = .none
        }
        else
        {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.rowHeight = 50
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        str = "Every "
        guard let cell = tableView.cellForRow(at: indexPath) as? RepeatTableViewCell else { return }
        
        if cell.accessoryType == .checkmark
        {
            cell.accessoryType = .none
            switch cell.when.text!
            {
            case "Every Sunday":
                check[0] = 0
            case "Every Monday":
                check[1] = 0
            case "Every Tuesday":
                check[2] = 0
            case "Every Wednesday":
                check[3] = 0
            case "Every Thursday":
                check[4] = 0
            case "Every Friday":
                check[5] = 0
            case "Every Saturday":
                check[6] = 0
            default:
                print("d")
            }
        }
        else
        {
            cell.accessoryType = .checkmark
            switch cell.when.text!
            {
            case "Every Sunday":
                check[0] = 1
            case "Every Monday":
                check[1] = 1
            case "Every Tuesday":
                check[2] = 1
            case "Every Wednesday":
                check[3] = 1
            case "Every Thursday":
                check[4] = 1
            case "Every Friday":
                check[5] = 1
            case "Every Saturday":
                check[6] = 1
            default:
                print("d")
            }
            
        }
        if check == [0,1,1,1,1,1,0]
        {
            str = str + "weekday,"
        }
        else if check == [1,0,0,0,0,0,1]
        {
            str = str + "weekend,"
        }
        else if check == [1,1,1,1,1,1,1]
        {
            str = str + "day,"
        }
        else
        {
            if check[0] == 1
            {
                str = str + "sun,"
            }
            if check[1] == 1
            {
                str = str + "mon,"
            }
            if check[2] == 1
            {
                str = str + "tue,"
            }
            if check[3] == 1
            {
                str = str + "wed,"
            }
            if check[4] == 1
            {
                str = str + "thur,"
            }
            if check[5] == 1
            {
                str = str + "fri,"
            }
            if check[6] == 1
            {
                str = str + "sat,"
            }
        }
        if str == ""
        {
            str = "Never"
        }
        str = str.substring(to: (str.index(before: (str.endIndex))))
        UserDefaults.standard.set(str, forKey: "repeat")
    }
}



