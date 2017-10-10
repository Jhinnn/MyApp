//
//  WirteNoteViewController.swift
//  pengjiaxu
//
//  Created by Arthur on 2017/9/21.
//  Copyright © 2017年 Arthur. All rights reserved.
//

import UIKit

typealias passValueClosure = (NoteItem) ->Void  //定义闭包类型

class WirteNoteViewController: UIViewController {

    var passValue: passValueClosure?
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var datepicker: UIDatePicker!
    var contentLabel: UILabel?
    var contentTextView: UITextView?
    
    var moodContainArray = [String]()
    
    let moodArray = ["愉快","超级失望","高兴","特难过","兴奋","很烦","难过","马上想不开","有点绝望","超级开心","简直爽翻天","不开心","不爽","超级无敌开心","绝望","开心","失望"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor.white
        title = "记录"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(completeAction))
        
        setupView()

    }
    
    
    
    func setupView() {
        titleLable.font = SYSTEMFONT(size: 17)

        let pwView = PWContentView(frame: CGRect(x: 0, y: 20, width: KScreenWidth, height: 0), dataArr: moodArray)
        pwView?.backgroundColor = UIColor.white
        pwView?.btnClick({ (title, index) in
           
            if self.moodContainArray.contains(title!) {  //如果数组包含此心情，则移除
                self.moodContainArray.remove(at: self.moodContainArray.index(of: title!)!)
            }else {
                self.moodContainArray.append(title!)
            }
        })
        
        view.addSubview(pwView!)
        
        
        contentLabel = UILabel(frame: CGRect(x: 0, y: (pwView?.bottom)!, width: KScreenWidth, height: 30))
        contentLabel?.text = "你的笔记"
        contentLabel?.textAlignment = .center
        contentLabel?.font = SYSTEMFONT(size: 17)
        view.addSubview(contentLabel!)
        
        contentTextView = UITextView(frame: CGRect(x: 8, y: (contentLabel?.bottom)! + 4, width: KScreenWidth - 16, height: 140))
        contentTextView?.font = SYSTEMFONT(size: 15)
        ViewBorderRadius(view: contentTextView!, radius: 4, width: 0.5, color: UIColor.lightGray)
        view.addSubview(contentTextView!)
        
        
    }
    
    
    
    func completeAction() {
        
        let str = self.moodContainArray.joined(separator: ",")
        
        let content: String = (self.contentTextView?.text)!
        
        let noteItem = NoteItem(value: [str,content,datepicker.date])
        if passValue != nil {
            self.passValue!(noteItem)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
