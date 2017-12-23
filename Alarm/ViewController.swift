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

    var titles = ["Repeat", "Label","Sound"]
    var value = ["Never","Alarm","Ringtone"]
    var obj = Time()
    var Formatter = DateFormatter()
    
    func setFormatter()
    {
        Formatter.dateFormat = "h:mm a"
        Formatter.amSymbol = "AM"
        Formatter.pmSymbol = "PM"
    }
 
    @IBAction func datePickerChanged(_ sender: UIDatePicker)
    {
        setFormatter()
        datestring = Formatter.string(from: sender.date)
    }
 
    
    @IBAction func save(_ sender: Any)
    {
        setFormatter()
        datestring = Formatter.string(from: datePicker.date)
        if value[0] == "Never"
        {
            value[0] = ""
        }
        let view = UserDefaults.standard.string(forKey: "view")
        if view == "edit"
        {
            Time().update(value,datestring,obj)
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
           Time().saveTime(value,datestring)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad()
    {
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        let titleDict: NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedStringKey : Any]
        self.navigationController?.navigationBar.backgroundColor = .black
        setFormatter()
        UserDefaults.standard.set("Never", forKey: "repeat")
        UserDefaults.standard.set("Label", forKey: "label")
        if UserDefaults.standard.string(forKey: "view") == "edit"
        {
            navigationItem.title = "Edit Alarm"
            datePicker.setDate(Formatter.date(from: obj.time!)!, animated: false)
            value = [obj.days!,obj.label!,"Ringtone"]
            if value[0] == ""
            {
                value[0] = "Never"
            }
            UserDefaults.standard.set(value[0], forKey: "repeat")
            UserDefaults.standard.set(value[1], forKey: "label")
        }
        else
        {
            datePicker.setDate(Formatter.date(from: datestring)!, animated: false)
        }
       
    }
    
    @IBAction func cancel(_ sender: Any)
    {
        if UserDefaults.standard.string(forKey: "view") == "edit"
        {
            self.navigationController?.popViewController(animated: true)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        value[0] = UserDefaults.standard.string(forKey: "repeat")!
        value[1] =  UserDefaults.standard.string(forKey: "label")!
        
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        if UserDefaults.standard.string(forKey: "view") == "edit"
        {
            navigationItem.title = "Edit Alarm"
        }
        setFormatter()
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
        datePicker.setDate(date, animated: false)
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section == 0
        {
             return titles.count
        }
        else
        {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddAlarmTableViewCell1", for: indexPath) as? AddAlarmTableViewCell
                else {
                    fatalError("The dequeued cell is not an instance of AddAlarmTableViewCell.")
            }
            cell.title.text = titles[indexPath.row]
            cell.value.text = value[indexPath.row]
            cell.value.numberOfLines = 1
            cell.value.minimumScaleFactor = 0.5
            cell.value.adjustsFontSizeToFitWidth = true
            UserDefaults.standard.set(value[0], forKey: "repeat")
            UserDefaults.standard.set(value[1], forKey: "label")
            return cell
        }
        else
        {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddAlarmTableViewCell2", for: indexPath) as? AddAlarmTableViewCell
                else {
                    fatalError("The dequeued cell is not an instance of AddAlarmTableViewCell.")}
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
    
    
    
    
    


