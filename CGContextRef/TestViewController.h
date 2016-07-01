//
//  TestViewController.h
//  CGContextRef
//
//  Created by wanglixin on 16/7/1.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyView.h"

@interface TestViewController : UIViewController

//@property(strong,nonatomic) MyView *myView;
@property (weak, nonatomic) IBOutlet UISlider *mySlider;
@property (weak, nonatomic) IBOutlet MyView *myView;
- (IBAction)backwardAction:(id)sender;
- (IBAction)forwardAction:(id)sender;
- (IBAction)saveAction:(id)sender;
- (IBAction)resetAction:(id)sender;
- (IBAction)linewidthAction:(id)sender;
- (IBAction)pickColorAction:(id)sender;

@end
