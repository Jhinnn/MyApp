//
//  NoteItem.swift
//  pengjiaxu
//
//  Created by Arthur on 2017/9/21.
//  Copyright © 2017年 Arthur. All rights reserved.
//

import UIKit
import RealmSwift

class NoteItem: Object {
    
    //标题
    dynamic var title = ""
    
    //事件
    dynamic var content = ""
    
    //时间
    dynamic var date = Date()

}
