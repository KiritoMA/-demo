//
//  PersonTableViewController.swift
//  私人通讯录
//
//  Created by Yuki.Ma on 2017/12/6.
//  Copyright © 2017年 Yuki.Ma. All rights reserved.
//

import UIKit

class PersonTableViewController: UITableViewController {

    var person : Person?
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    
    var completionCallBack : (()->())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if person != nil {
            nameField.text = person?.name
            phoneField.text = person?.phone
            titleField.text = person?.title
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: 载入数据

    @IBAction func save(_ sender: Any) {
        if person == nil{
            person = Person()
        }
        person?.name = nameField.text
        person?.phone = phoneField.text
        person?.title = titleField.text
        
        completionCallBack?()
        
        navigationController?.popViewController(animated: true)
    }
    
}
