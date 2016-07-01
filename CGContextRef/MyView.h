//
//  MyView.h
//  CGContextRef
//
//  Created by wanglixin on 16/7/1.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyView : UIView

@property (nonatomic, strong) UIColor *color;
//用来设置线条的宽度
@property (nonatomic, assign) CGFloat lineWidth;
//用来记录已有线条
@property (nonatomic, strong) NSMutableArray *allLine;

//初始化相关参数
-(void)initMyView;
//unDo操作
-(void)backImage;
//reDo操作
-(void)forwardImage;

-(void)resetDraw;

@end
