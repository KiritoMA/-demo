//
//  LIstTableViewController.swift
//  私人通讯录
//
//  Created by Yuki.Ma on 2017/12/6.
//  Copyright © 2017年 Yuki.Ma. All rights reserved.
//

import UIKit

class LIstTableViewController: UITableViewController {
    //加载数据
    var personList = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //闭包实现数据调用
        loadData{ (list) in
            self.personList += list
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: 添加新数据
    @IBAction func addNewPerson(_ sender: Any) {
        performSegue(withIdentifier: "listToDetail", sender: nil)
    }
    
    
    //MARK: 控制器
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! PersonTableViewController
        //点击对应的cell把数据传到personviewcontroller
        if let indexpath = sender as? IndexPath{
            viewController.person = personList[indexpath.row]
            
            //如果对已有数据修改的话，也用completionCallBack来保存
            viewController.completionCallBack = {
                self.tableView.reloadRows(at: [indexpath], with: .automatic)
            }
        }else{
            //把新建的人物信息保存到listviewcontroller
            viewController.completionCallBack = {
                guard let person = viewController.person else{
                    return
                }
                self.personList.insert(person, at: 0)
                self.tableView.reloadData()
            }
        }
        
    }
    
    //MARK：点击cell跳转
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "listToDetail", sender: indexPath)
    }
    
    // MARK: 载入数据
    //括号内是闭包
    func loadData( completion:@escaping (_ list:[Person])->())->(){
        // 异步线程生成数据，主线程调回，global为异步线程
        DispatchQueue.global().async {
            //定义person的数据来存放数据
            var personArray = [Person]()
            //添加数据
            for i in 1...20{
                
                var person = Person()
                person.name = "Person - \(i)"
                //“%06d”为格式化输入，%为格式化输入接受参数的标记，0格式化命令，6填充位数
                person.phone = "1888" + String(format: "%06d", arc4random_uniform(1000000))
                person.title = "boss"
                //添加数据
                personArray.append(person)
                print(personArray)
            }
            //主线程回调
            DispatchQueue.main.async{
                execute:do {
                    completion(personArray)
                }
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        cell.textLabel?.text = personList[indexPath.row].name
        cell.detailTextLabel?.text = personList[indexPath.row].phone
        return cell
    }
}
