//
//  AlarmTableViewController.swift
//  Alarm
//
//  Created by Dheepthaa Anand on 21/11/17.
//  Copyright © 2017 Dheepthaa Anand. All rights reserved.
//

import UIKit
import CoreData

class AlarmTableViewController: UITableViewController{
    
    var timeobj: [Time] = []
    @IBOutlet weak var editbarbutton: UIBarButtonItem!
    
    @IBAction func switchChange(_ sender: UISwitch)
    {
        guard let cell = sender.superview?.superview as? AlarmTableViewCell else{return}
        let indexPath = self.tableView.indexPath(for: cell)
        Time().saveSwitch(obj: timeobj[(indexPath?.row)!],isOn: cell.switch1.isOn)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundView = nil
        self.tableView.backgroundColor = UIColor .black
        
        UserDefaults.standard.set("add", forKey: "view")
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        timeobj = Time().fetch()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        UserDefaults.standard.set("add", forKey: "view")
        timeobj = Time().fetch()
        tableView.reloadData()
        
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return timeobj.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellIdentifier = "AlarmTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AlarmTableViewCell  else{
            fatalError("The dequeued cell is not an instance of AlarmTableViewCell.")}
        
        cell.time.text = timeobj[indexPath.row].time
        cell.desc.text = timeobj[indexPath.row].label
        if timeobj[indexPath.row].days != ""
        {
            cell.desc.text = cell.desc.text! + ","
        }
        cell.desc.text = cell.desc.text!+" "+timeobj[indexPath.row].days!
        cell.switch1.isOn = timeobj[indexPath.row].isOn
        cell.desc.sizeToFit()
        cell.desc.numberOfLines = 1
        cell.desc.minimumScaleFactor = 0.5
        cell.desc.adjustsFontSizeToFitWidth = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        self.tableView.rowHeight = 100
        return 100
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if (editingStyle == UITableViewCellEditingStyle.delete)
        {
            Time().delete(obj: timeobj[indexPath.row]) //remove from CoreData
            timeobj.remove(at: indexPath.row) //remove from array
            tableView.deleteRows(at: [indexPath], with: .fade) //remove from tableview
        }
       
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle
    {
        return UITableViewCellEditingStyle.delete
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    override func setEditing(_ editing: Bool, animated: Bool)
    {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
    }
  

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if self.tableView.isEditing == true
        {
            UserDefaults.standard.set("edit", forKey: "view")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "AddAlarmViewController") as! ViewController
            resultViewController.obj = timeobj[indexPath.row]
            self.navigationController?.pushViewController(resultViewController, animated: true)
        }
    }
  
}
