//
//  ViewController.m
//  SoftKeyBoardOperation
//
//  Created by 紫冬 on 13-7-1.
//  Copyright (c) 2013年 qsji. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"设备名字是：%@", [ViewController getDeviceName]);
    if (iPhone5)
    {
        NSLog(@"iphone5");
    }
    else
    {
        NSLog(@"not iphone5");
    }
    
    NSLog(@"高度是：%f", textField.frame.origin.y);
    textField.delegate = self;
    
    NSLog(@"y坐标是：%f", self.view.frame.origin.y);
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
}


//当键盘出现或改变时调用
- (void)keyboardDidShow:(NSNotification *)notification
{
    //获取键盘的高度，通过notification的userinfo来获得键盘的高度
    NSLog(@"显示键盘");
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGRect rectView = self.view.frame;
    rectView.origin.y = self.view.frame.size.height - textField.frame.origin.y - textField.frame.size.height - keyboardRect.size.height;
    self.view.frame = rectView;
}

- (void)keyboardDidChangeFrame:(NSNotification *)notification
{
    NSLog(@"改变了frame");
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGRect rectView = self.view.frame;
    rectView.origin.y = self.view.frame.size.height - textField.frame.origin.y - textField.frame.size.height - keyboardRect.size.height;
    self.view.frame = rectView;
}

//当输入框获得焦点的时候
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"开始编辑");
}

//当输入框失去焦点的时候
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"结束编辑");
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)notification
{
    CGRect rectView = self.view.frame;
    rectView.origin.y = 0;
    self.view.frame = rectView;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    NSLog(@"关闭键盘");
    [self closeSoftKeyboard:NSCloseSharpApplicationCloseStyle];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//获取设备的名字
+(NSString *)getDeviceName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceName = nil;
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone1,1"])
        deviceName = @"iPhone 1G";
    else if ([deviceString isEqualToString:@"iPhone1,2"])
        deviceName = @"iPhone 3G";
    else if ([deviceString isEqualToString:@"iPhone2,1"])
        deviceName = @"iPhone 3GS";
    else if ([deviceString isEqualToString:@"iPhone3,1"])
        deviceName = @"iPhone 4";
    else if ([deviceString isEqualToString:@"iPhone4,1"])
        deviceName = @"iPhone 4S";
    else if ([deviceString isEqualToString:@"iPhone3,2"])
        deviceName = @"Verizon iPhone 4";
    else if ([deviceString isEqualToString:@"iPod1,1"])
        deviceName = @"iPod Touch 1G";
    else if ([deviceString isEqualToString:@"iPod2,1"])
        deviceName = @"iPod Touch 2G";
    else if ([deviceString isEqualToString:@"iPod3,1"])
        deviceName = @"iPod Touch 3G";
    else if ([deviceString isEqualToString:@"iPod4,1"])
        deviceName = @"iPod Touch 4G";
    else if ([deviceString isEqualToString:@"iPad1,1"])
        deviceName = @"iPad";
    else if ([deviceString isEqualToString:@"iPad2,1"])
        deviceName = @"iPad 2 (WiFi)";
    else if ([deviceString isEqualToString:@"iPad2,2"])
        deviceName = @"iPad 2 (GSM)";
    else if ([deviceString isEqualToString:@"iPad2,3"])
        deviceName = @"iPad 2 (CDMA)";
    else if ([deviceString isEqualToString:@"i386"])
        deviceName = @"Simulator";
    else if ([deviceString isEqualToString:@"x86_64"])
        deviceName = @"Simulator";

    return deviceName;

}

//隐藏软键盘的几种方法，第一种
-(void)closeSoftKeyboard:(NSCloseSoftKeyboard)closeSoftKeyboardstyle
{
    switch (closeSoftKeyboardstyle)
    {
        case NSCloseSharpApplicationCloseStyle:      //通过系统隐藏软键盘
        {
            [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        }
            break;
        
        case NSCloseResignFirstStyle:                //遍历父窗体，使得输入框失去焦点
        {
            for (UIView *view in [self.view subviews])
            {
                if ([view isKindOfClass:[UITextView class]])
                {
                    [view resignFirstResponder];
                }
            }            
        }
            break;
        default:
            break;
    }
}



@end
