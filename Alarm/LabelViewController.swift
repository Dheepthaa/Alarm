//
//  LabelViewController.swift
//  Alarm
//
//  Created by Dheepthaa Anand on 22/11/17.
//  Copyright © 2017 Dheepthaa Anand. All rights reserved.
//

import UIKit

class LabelViewController: UIViewController, UITextFieldDelegate {

   var str=""
    
    @IBOutlet weak var text: UITextField!
    @objc func typingName(textField:UITextField)
    {
        if let typedText = textField.text
        {
            str = typedText
            UserDefaults.standard.set(str, forKey: "label")
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .orange
        text.delegate = self
        text.autocapitalizationType = .sentences
        text.text = UserDefaults.standard.string(forKey: "label")
        text.becomeFirstResponder()
        text.addTarget(self, action: #selector(typingName), for: .editingChanged)
    }
    
    func textFieldShouldReturn(_ text: UITextField) -> Bool
    {
        text.resignFirstResponder()
        self.navigationController?.popViewController(animated: true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        guard let textfield = text.text else {return true}
        let curlength = textfield.characters.count + string.characters.count - range.length
        return curlength <= 20
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
