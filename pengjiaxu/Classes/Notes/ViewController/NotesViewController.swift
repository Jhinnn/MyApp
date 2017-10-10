//
//  NotesViewController.swift
//  pengjiaxu
//
//  Created by Arthur on 2017/9/21.
//  Copyright © 2017年 Arthur. All rights reserved.
//

import UIKit
import RealmSwift

class NotesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView: UITableView? = nil
    
    let realm = try! Realm()
    
    var dateformat = DateFormatter()
    
    //保存从数据库中查询出来的结果集
    var noteItems: Results<NoteItem>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        self.dateformat.dateFormat = "yyyy年MM月dd日 HH:mm"
        
        noteItems = realm.objects(NoteItem.self)
        
        setupTableView()
        
        setupBarButtonItem()
    }
    
    func setupBarButtonItem() {

        let backButton = UIButton.init(type: .custom)
        backButton.setImage(UIImage(named: "addNote"), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 26, height: 26)
        backButton.addTarget(self, action: #selector(addNoteAction), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: backButton)

    }

    
    func setupTableView() {

        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeight), style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.tableFooterView = UIView()
        tableView?.estimatedRowHeight = 44
        tableView?.separatorInset = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.register(UINib(nibName: "NoteCell", bundle: nil), forCellReuseIdentifier: "cell")
        view.addSubview(tableView!)
        
    }
    
    //返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noteItems!.count
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            //同一形式的单元格重复使用，在声明时已注册
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.selectionStyle = .none
            let item = self.noteItems?[indexPath.row]
            
            let titleLabel = cell.contentView.viewWithTag(10) as! UILabel
            titleLabel.font = SYSTEMFONT(size: 12)
            let contentLabel = cell.contentView.viewWithTag(11) as! UILabel
            contentLabel.font = SYSTEMFONT(size: 15)
            let timeLabel = cell.contentView.viewWithTag(12) as! UILabel
            timeLabel.font = SYSTEMFONT(size: 10)

            titleLabel.text = item?.title
            contentLabel.text = item?.content
            timeLabel.text = self.dateformat.string(from: (item?.date)!)
            
//            cell.textLabel?.text = (item?.name)! + " ￥" + String(format: "%.1f", (item?.cost)!)
//            cell.detailTextLabel?.text = self.dformatter.string(from: (item?.date)!)
            return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle{
        return .delete
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let item = self.noteItems?[indexPath.row]
            let alertController = UIAlertController(title: "确定删除笔记", message: "", preferredStyle: .alert)
            let alertAction1 = UIAlertAction(title: "确定", style: .default, handler: { (UIAlertAction) in
                //删除
                try! self.realm.write {
                    self.realm.delete(item!)
                }
                self.tableView?.reloadData()
            })
            
            let alertAction2 = UIAlertAction(title: "取消", style: .cancel, handler: { (UIAlertAction) in
                
            })
            alertController.addAction(alertAction1)
            alertController.addAction(alertAction2)
            present(alertController, animated: true, completion: { 
                
            })
        }
    }
    
    
    func addNoteAction() {
        
        let writeNoteVC = WirteNoteViewController()

        weak var weakself = self
        writeNoteVC.passValue = { (noteItem: NoteItem) -> Void in
            try! self.realm.write {
                self.realm.add(noteItem)
            }
            weakself?.tableView?.reloadData()
            
        }
        
        
        navigationController?.pushViewController(writeNoteVC, animated: true)
        
    }
    

}
