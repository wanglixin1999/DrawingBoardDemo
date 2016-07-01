//
//  TestViewController.m
//  CGContextRef
//
//  Created by wanglixin on 16/7/1.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "TestViewController.h"
#import "MSColorSelectionViewController.h"

@interface TestViewController ()<MSColorSelectionViewControllerDelegate>

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.myView = [[MyView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.myView initMyView];
//    [self.view addSubview:self.myView];
    
    [self.mySlider setMaximumValue:10];
    [self.mySlider setValue:5 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/////通过segmentControl来设置线条的颜色
//- (IBAction)tapSegment:(id)sender {
//    switch (self.mySegment.selectedSegmentIndex) {
//        case 0:
//            self.myView.color = [UIColor redColor];
//            break;
//        case 1:
//            self.myView.color = [UIColor blackColor];
//            break;
//        case 2:
//            self.myView.color = [UIColor greenColor];
//            break;
//            
//        default:
//            break;
//    }
//}
- (void)Save {
    //截屏
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.myView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *uiImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //截取画图版部分
    CGImageRef sourceImageRef = [uiImage CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, self.myView.bounds);
//    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, self.myView.frame);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    //把截的屏保存到相册
    UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil);
    
    //给个保存成功的反馈
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"存储照片成功"
                                                    message:@"您已将照片存储于图片库中，打开照片程序即可查看。"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)forwardAction:(id)sender {
    [self.myView forwardImage];
}

- (IBAction)saveAction:(id)sender {
    [self Save];
}

- (IBAction)resetAction:(id)sender {
    [self.myView resetDraw];
}
- (IBAction)backwardAction:(id)sender {
    [self.myView backImage];
}
- (IBAction)linewidthAction:(id)sender {
    self.myView.lineWidth = self.mySlider.value;
}

- (IBAction)pickColorAction:(id)sender {
    MSColorSelectionViewController *colorSelectionController = [[MSColorSelectionViewController alloc] init];
    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:colorSelectionController];
    
    navCtrl.modalPresentationStyle = UIModalPresentationPopover;
//    navCtrl.popoverPresentationController.delegate = self;
    navCtrl.popoverPresentationController.sourceView = (UIButton *)sender;
    navCtrl.popoverPresentationController.sourceRect = ((UIButton *)sender).bounds;
    navCtrl.preferredContentSize = [colorSelectionController.view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    colorSelectionController.delegate = self;
    colorSelectionController.color = self.view.backgroundColor;
    
    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", ) style:UIBarButtonItemStyleDone target:self action:@selector(ms_dismissViewController:)];
        colorSelectionController.navigationItem.rightBarButtonItem = doneBtn;
    }
    
    [self presentViewController:navCtrl animated:YES completion:nil];
}

- (void)colorViewController:(MSColorSelectionViewController *)colorViewCntroller didChangeColor:(UIColor *)color
{
//    self.view.backgroundColor = color;
    [self.myView setColor:color];
}

#pragma mark - Private
- (void)ms_dismissViewController:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
