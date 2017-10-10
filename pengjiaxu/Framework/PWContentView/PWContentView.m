//
//  PWContentView.m
//  标签
//
//  Created by DFSJ on 17/1/18.
//  Copyright © 2017年 Oriental Horizon. All rights reserved.
//

#import "PWContentView.h"

@implementation PWContentView

-(instancetype) initWithFrame:(CGRect)frame dataArr:(NSArray *)array{

    if (self = [super initWithFrame:frame]) {

        for (int i = 0; i < array.count; i ++) {
            NSString *title = array[i];
            static UIButton *recordBtn =nil;
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            
            
            CGRect rect = [title boundingRectWithSize:CGSizeMake(self.frame.size.width - 10, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:btn.titleLabel.font} context:nil];
            
            CGFloat BtnW = rect.size.width + 20;
            CGFloat BtnH = rect.size.height + 6;
            
            if (i == 0) {
                btn.frame =CGRectMake(5, 4, BtnW, BtnH);
            }
            else{
                CGFloat yuWidth = self.frame.size.width - 20 - recordBtn.frame.origin.x - recordBtn.frame.size.width;
                if (yuWidth >= rect.size.width) {
                    btn.frame =CGRectMake(recordBtn.frame.origin.x + recordBtn.frame.size.width + 5, recordBtn.frame.origin.y, BtnW, BtnH);
                }else{
                    btn.frame =CGRectMake(5, recordBtn.frame.origin.y+recordBtn.frame.size.height + 7, BtnW, BtnH);
                }
            }
            
            btn.titleLabel.font = [UIFont fontWithName:@"Heiti SC" size:14];
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 2;
            btn.layer.borderWidth = 0.5;
            btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:12/255.0 green:108/255.0 blue:254/255.0 alpha:1] forState:UIControlStateSelected];
            
            btn.tag = i;
            

            [btn setTitle:title forState:UIControlStateNormal];
            [self addSubview:btn];
            
            self.frame = CGRectMake(0, 106, [UIScreen mainScreen].bounds.size.width,CGRectGetMaxY(btn.frame)+10);
            recordBtn = btn;
    
            [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }


    return self;

}

-(void) BtnClick:(UIButton *)sender{
    
    sender.selected = !sender.selected;

    __weak typeof(self) weakSelf = self;
    
    if (weakSelf.btnBlock) {
        
        weakSelf.btnBlock(sender.titleLabel.text,sender.tag);
    }

}

-(void) btnClickBlock:(BtnBlock)btnBlock{

    self.btnBlock = btnBlock;

}


@end
