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
   
    var core = ""
    var sun = 0, mon = 0, tue = 0, wed = 0, thurs = 0, fri = 0, sat = 0
    var when1 = ["Every Sunday","Every Monday","Every Tuesday", "Every Wednesday", "Every Thursday", "Every Friday", "Every Saturday"]
    var str="Every"
    var check = [0,0,0,0,0,0,0]

    override func viewDidLoad()
    {
        
        super.viewDidLoad()
         self.navigationController?.navigationBar.tintColor = .orange
        self.tableView.tableFooterView = UIView()
        if UserDefaults.standard.string(forKey: "core") != nil
        {
            core = UserDefaults.standard.string(forKey: "core")!
        
            if core == "Every weekday"
            {
                check = [0,1,1,1,1,1,0]
                mon=1
                tue=1
                wed=1
                thurs=1
                fri=1
                
            }
            if core == "Every weekend"
            {
                check = [1,0,0,0,0,0,1]
                sat=1
                sun=1
            }
            if core == "Every day"
            {
                 check = [1,1,1,1,1,1,1]
                mon=1
                tue=1
                wed=1
                thurs=1
                fri=1
                sat=1
                sun=1
            }
      
            let d = core.components(separatedBy: ",")
          
            for i in 0...(d.count-1)
            {
            
                if d[i] == "Every sun" || d[i]=="sun"
                    
                {
                    check[0]=1
                    sun=1
                  
                }
                if d[i] == "mon" || d[i]=="Every mon"
                {
                    check[1]=1
                    mon=1
                
                }
                if d[i] == "tue" || d[i]=="Every tue"
                {
                    check[2]=1
                    tue=1
                   
                }
                if d[i] == "wed" || d[i]=="Every wed"
                {
                    check[3]=1
                    wed=1
          
                }
                if d[i] == "thur" || d[i]=="Every thur"
                {
                    check[4]=1
                    thurs=1
               
                }
                if d[i] == "fri" || d[i]=="Every fri"
                {
                    check[5]=1
                    fri=1
       
                }
                if d[i] == "sat" || d[i]=="Every sat"
                {
                    check[6]=1
                    sat=1
                  
                }
                
                
            }
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return when1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RepeatTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RepeatTableViewCell
            else {
                fatalError("The dequeued cell is not an instance of RepeatTableViewCell.")
        }
        let when2 = when1[indexPath.row]
        cell.when.text = when2
        let check2 = check[indexPath.row]
        if check2 == 0
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        str = ""
        guard let cell = tableView.cellForRow(at: indexPath) as? RepeatTableViewCell else { return }
        
        if cell.accessoryType == .checkmark
        {
            
            cell.accessoryType = .none
            switch cell.when.text!
            {
            case "Every Sunday":
                sun = 0
            case "Every Monday":
                mon = 0
            case "Every Tuesday":
                tue = 0
            case "Every Wednesday":
                wed = 0
            case "Every Thursday":
                thurs = 0
            case "Every Friday":
                fri = 0
            case "Every Saturday":
                sat = 0
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
                sun = 1
            case "Every Monday":
                mon = 1
            case "Every Tuesday":
                tue = 1
            case "Every Wednesday":
                wed = 1
            case "Every Thursday":
                thurs = 1
            case "Every Friday":
                fri = 1
            case "Every Saturday":
                sat = 1
            default:
                print("d")
            }
            
        }
        if mon==1 && tue==1 && wed==1 && thurs==1 && fri==1 && sat==0 && sun==0
        {
            str = "weekday,"
            
        }
       else if mon==0 && tue==0 && wed==0 && thurs==0 && fri==0 && sun == 1 && sat == 1
        {
            str = "weekend,"
            
        }
        else if mon==1 && tue==1 && wed==1 && thurs==1 && fri==1 && sun == 1 && sat == 1
        {
            str = "day,"
        }
        else
        {
            if sun == 1
            {
                str = str + "sun,"
            }
            if mon == 1
            {
                str = str + "mon,"
            }
            if tue == 1
            {
                str = str + "tue,"
            }
            if wed == 1
            {
                str = str + "wed,"
            }
            if thurs == 1
            {
                str = str + "thur,"
            }
            if fri == 1
            {
                str = str + "fri,"
            }
            if sat == 1
            {
                str = str + "sat,"
            }
            
        }
        if str == nil
        {
            str = ","
        }
        UserDefaults.standard.set(str, forKey: "Day")
        
        
    }
    
    
    
    
}



