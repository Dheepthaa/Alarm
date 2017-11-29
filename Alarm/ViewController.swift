//
//  ViewController.swift
//  Alarm
//
//  Created by Dheepthaa Anand on 21/11/17.
//  Copyright © 2017 Dheepthaa Anand. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    var datestring = "12:00 AM"
    
    var title1 = ["Repeat", "Label","Sound"]
    var value1 = ["Never","Alarm","Ringtone"]
    var obj = Time()

 
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let Formatter = DateFormatter()
        Formatter.dateFormat = "h:mm a"
        Formatter.amSymbol = "AM"
        Formatter.pmSymbol = "PM"
        datestring = Formatter.string(from: sender.date)
        let view = UserDefaults.standard.string(forKey: "view")
        if view == "edit"
        {
               obj.time = datestring
            
        }
     
    }
 
    
    @IBAction func save(_ sender: Any) {
 
        let time = Time()
        let Formatter = DateFormatter()
        Formatter.dateFormat = "h:mm a"
        Formatter.amSymbol = "AM"
        Formatter.pmSymbol = "PM"
        datestring = Formatter.string(from: datePicker.date)
        if value1[0] == "Never"
        {
            value1[0]=""
        }
        let view = UserDefaults.standard.string(forKey: "view")
        if view != "edit"
        {
            time.save1(value1,datestring)
        }
        else
        {
            
            Time().update(value1,datestring,obj)
            self.navigationController?.popViewController(animated: true)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        self.navigationController?.navigationBar.backgroundColor = .black
        let titleDict: NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedStringKey : Any]
        
        if UserDefaults.standard.string(forKey: "view") == "edit"
        {
          
             navigationItem.title = "Edit Alarm"
            let Formatter = DateFormatter()
            Formatter.dateFormat = "h:mm a"
            Formatter.amSymbol = "AM"
            Formatter.pmSymbol = "PM"
            let date : Date
            date = Formatter.date(from: obj.time!)!
            datePicker.setDate(date, animated: false)
            value1 = [obj.days!,obj.label!,"Ringtone"]
         
            if value1[0] == nil || value1[0] == ""
            {
                
                UserDefaults.standard.set("Never", forKey: "core")
                value1[0]="Never"
            }
            else
            {
                 UserDefaults.standard.set(value1[0], forKey: "core")
            }
           
            UserDefaults.standard.set(value1[1], forKey: "core1")
        }
        else
        {
            let Formatter = DateFormatter()
            Formatter.dateFormat = "h:mm a"
            Formatter.amSymbol = "AM"
            Formatter.pmSymbol = "PM"
            let date : Date
            date = Formatter.date(from: datestring)!
            datePicker.setDate(date, animated: false)
        }
       
    }
    @IBAction func cancel(_ sender: Any) {
        
        if UserDefaults.standard.string(forKey: "view") == "edit"
        {
            self.navigationController?.popViewController(animated: true)
        }
        self.dismiss(animated: true, completion: nil)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        var indexPath = IndexPath(row: 0, section: 0)
        guard let cell = tableView.cellForRow(at: indexPath) as? AddAlarmTableViewCell else {return}

        if UserDefaults.standard.string(forKey: "view") == "edit"
        {
        
            navigationItem.title = "Edit Alarm"
        
        }
        var str = UserDefaults.standard.string(forKey: "Day")
    
        
        if str != nil && str != ""
        {
            str = str?.substring(to: (str!.index(before: (str!.endIndex))))
            str = "Every "+str!
            value1[0] = str!
            let value2 = value1[indexPath.row]
            cell.value.text = value2
            UserDefaults.standard.set(value1[0], forKey: "core")
            UserDefaults.standard.removeObject(forKey: "Day")
        }
        let str1 = UserDefaults.standard.string(forKey: "Label")
        if str1 != nil && str1 != ""
        {
            value1[1] = str1!
            let indexPath = IndexPath(row: 1, section: 0)
            guard let cell = tableView.cellForRow(at: indexPath) as? AddAlarmTableViewCell else {return}
            let value2 = value1[indexPath.row]
            cell.value.text = value2
            UserDefaults.standard.set(value1[1], forKey: "core1")
            UserDefaults.standard.removeObject(forKey: "Label")
        }
        let Formatter = DateFormatter()
        Formatter.dateFormat = "h:mm a"
        Formatter.amSymbol = "AM"
        Formatter.pmSymbol = "PM"
        let date : Date
        if UserDefaults.standard.string(forKey: "view") != "edit"
        {
           
            date = Formatter.date(from: datestring)!
        }
        else
        {
            date = Formatter.date(from: obj.time!)!
            datestring = obj.time!
            
        }
        if(date != nil)
        {
            
            datePicker.setDate(date, animated: false)
           
        }
        else
        {
            datestring = Formatter.string(from: datePicker.date)
        }
        
        
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0
        {
             return title1.count
        }
        else
        {
            return 1
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
       if indexPath.section == 0
       {
        let cellIdentifier = "AddAlarmTableViewCell1"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AddAlarmTableViewCell
            else {
                fatalError("The dequeued cell is not an instance of AddAlarmTableViewCell.")
        }
        var str: String? = nil
        str = UserDefaults.standard.string(forKey: "Day")
        
       
        if str != "" && str != nil
        {
            str = str?.substring(to: (str!.index(before: (str!.endIndex))))
            
            value1[0] = "Every "+str!
            UserDefaults.standard.removeObject(forKey: "Day")
        }
        
        let str1 = UserDefaults.standard.string(forKey: "Label")
        if str1 != nil && str1 != ""
        {
            value1[1] = str1!
            UserDefaults.standard.removeObject(forKey: "Label")
        }
        
        
            let title2 = title1[indexPath.row]
            let value2 = value1[indexPath.row]
            cell.title.text = title2
            cell.value.text = value2
        cell.value.numberOfLines = 1
        cell.value.minimumScaleFactor = 0.5
        cell.value.adjustsFontSizeToFitWidth = true
           UserDefaults.standard.set(value1[0], forKey: "core")
           UserDefaults.standard.set(value1[1], forKey: "core1")
        
        return cell
       }
        else
       {
        let cellIdentifier = "AddAlarmTableViewCell2"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AddAlarmTableViewCell
            else {
                fatalError("The dequeued cell is not an instance of AddAlarmTableViewCell.")
        }
        cell.snooze.text = "Snooze"
        return cell
        
        }
        
        
        
        
    }
    
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.rowHeight = 50
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       if indexPath.row == 0 && indexPath.section == 0
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "RepeatViewController") as! RepeatViewController
            
            self.navigationController?.pushViewController(resultViewController, animated: true)
        }
        if indexPath.row == 1
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "LabelViewController") as! LabelViewController
            
            self.navigationController?.pushViewController(resultViewController, animated: true)
        }
        
        
        
        
        
    }
}
    
    
    
    
    


