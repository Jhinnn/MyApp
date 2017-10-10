//
//  PWContentView.h
//  标签
//
//  Created by DFSJ on 17/1/18.
//  Copyright © 2017年 Oriental Horizon. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^BtnBlock)(NSString *text, NSInteger index);

@interface PWContentView : UIView

@property (nonatomic,copy) BtnBlock btnBlock;

-(void) btnClickBlock:(BtnBlock) btnBlock;

-(instancetype) initWithFrame:(CGRect)frame dataArr:(NSArray *)array;

@end
