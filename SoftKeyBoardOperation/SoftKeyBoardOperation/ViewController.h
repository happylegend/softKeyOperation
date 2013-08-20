//
//  ViewController.h
//  SoftKeyBoardOperation
//
//  Created by 紫冬 on 13-7-1.
//  Copyright (c) 2013年 qsji. All rights reserved.
//
#import <sys/utsname.h>
#import <UIKit/UIKit.h>

/*
 该项目主要介绍了软键盘的以下几种操作
 1.隐藏软键盘
 2.监听软键盘的状态
 */
/*
 监听键盘的系统通知：
 UIKeyboardWillShowNotification
 UIKeyboardDidShowNotification
 UIKeyboardWillHideNotification
 UIKeyboardDidHideNotification
 UIKeyboardWillChangeFrameNotification
 UIKeyboardDidChangeFrameNotification
 
 */

//在使用的时候，尽量不要使用具体的手机尺寸，要用宏（变量）代替
#define Screen_height   [[UIScreen mainScreen] bounds].size.height        //获得当前屏幕的高度
#define Screen_width    [[UIScreen mainScreen] bounds].size.width         //获得当前屏幕的宽度


//判断当前手机是否是iphone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


//定义一个枚举变量，表示关闭软键盘的方式
typedef enum
{
    NSCloseSharpApplicationCloseStyle,
    NSCloseResignFirstStyle
} NSCloseSoftKeyboard;

@interface ViewController : UIViewController<UITextFieldDelegate>

{
    IBOutlet UITextField *textField;
}

@end
