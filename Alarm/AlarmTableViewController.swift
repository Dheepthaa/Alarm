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
    @IBAction func switchChange(_ sender: UISwitch) {
        
        guard let cell = sender.superview?.superview as? AlarmTableViewCell else {
            return
        }
       let indexPath = self.tableView.indexPath(for: cell)
        Time().saveSwitch(obj: timeobj[(indexPath?.row)!],isOn: cell.switch1.isOn)
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       self.tableView.tableFooterView = UIView()
        self.tableView.backgroundView = nil
        self.tableView.backgroundColor = UIColor .black

        UserDefaults.standard.set("add", forKey: "view")
        //editbarbutton = self.editButtonItem
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        timeobj = Time().fetch()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //self.tableView.isEditing = false
       //self.navigationItem.leftBarButtonItem?.title = "Edit"
        UserDefaults.standard.set("add", forKey: "view")
        timeobj = Time().fetch()
        tableView.reloadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return timeobj.count
    }

    func getContext() -> NSManagedObjectContext{
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "AlarmTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AlarmTableViewCell  else{
            fatalError("The dequeued cell is not an instance of AlarmTableViewCell.")}
      
//        if(cell.isSelected)
//        {
//            cell.backgroundColor = .grey
//
//        }
//        else
//        {
//            cell.backgroundColor = UIColor.clearColor()
//        }
        cell.time.text = timeobj[indexPath.row].time
        cell.desc1.text = timeobj[indexPath.row].label
        if timeobj[indexPath.row].days != ""
        {
            cell.desc1.text = cell.desc1.text! + ","
        }
        cell.desc1.text = cell.desc1.text!+" "+timeobj[indexPath.row].days!
        cell.switch1.isOn = timeobj[indexPath.row].isOn
        cell.desc1.sizeToFit()
        cell.desc1.numberOfLines = 1
        cell.desc1.minimumScaleFactor = 0.5
        cell.desc1.adjustsFontSizeToFitWidth = true
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.tableView.rowHeight = 100
        return 100
    }
    
 
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete)
        {
            Time().delete(obj: timeobj[indexPath.row])
            timeobj.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
       
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func setEditing(_ editing: Bool, animated: Bool)
    {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
        
    }
  

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.tableView.isEditing == true
        {
            UserDefaults.standard.set("edit", forKey: "view")
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "AddAlarmViewController") as! ViewController
           
            
            let obj = timeobj[indexPath.row]
            resultViewController.obj = obj
        
            
            self.navigationController?.pushViewController(resultViewController, animated: true)
           
        }
        
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
