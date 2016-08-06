//
//  ViewController.m
//  fmdb+单例
//
//  Created by owen on 16/8/4.
//  Copyright © 2016年 owen. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "DBObject.h"
#import "WBTableViewCell.h"
#import "WBTableViewController.h"
#import "ChooseViewController.h"
#import "DeleteViewController.h"
#import "UpdateViewController.h"
#import "UIView+Toast.h"

#define titleFd  @"titleField"
#define nameFd  @"nameField"
#define passwordFd  @"passwordField"


@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"fmdb简单使用";
    
    //打开数据库并新建表
    [[DBObject sharedInstance]addDatabaseAndTableMethod];
    
    [self initUIMethod];
    

}


/**
 *  增删查改 基本控件
 */
-(void)initUIMethod{
    
    //平台名字
    self.titleLabPre = [[UILabel alloc]init];
    [self.view addSubview: self.titleLabPre];
    [ self.titleLabPre mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(95);
        make.left.offset(15);
        make.width.offset(70);
        
    }];
    self.titleLabPre.text = @"平  台:";
    self.titleLabPre.textColor = [UIColor blackColor];
    
    //平台输入框
    self.titleField = [[UITextField alloc]init];
    [self.view addSubview:self.titleField];
    [self.titleField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(90);
        make.right.offset(-15);
        make.left.mas_equalTo( self.titleLabPre.mas_right);
        make.height.offset(30);
    }];
    self.titleField.placeholder = @"请输入平台名称";
    self.titleField.layer.borderWidth = 0.3;
    self.titleField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.titleField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.titleField.delegate = self;
    [self.titleField addTarget:self action:@selector(titleFieldMethod:) forControlEvents:UIControlEventEditingChanged];
    
    //用户名或者邮箱
    self.nameLabPre = [[UILabel alloc]init];
    [self.view addSubview:self.nameLabPre];
    [self.nameLabPre mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo( self.titleLabPre.mas_bottom).offset(30);
        make.left.offset(15);
        make.width.offset(70);
        
        
    }];
    self.nameLabPre.text = @"用  户:";
    self.nameLabPre.textColor = [UIColor blackColor];
    
    //用户名输入框
    self.nameField = [[UITextField alloc]init];
    [self.view addSubview:self.nameField];
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo( self.titleLabPre.mas_bottom).offset(25);
        make.right.offset(-15);
        make.left.mas_equalTo(self.nameLabPre.mas_right);
        make.height.offset(30);
    }];
    self.nameField.placeholder = @"请输入用户名或邮箱";
    self.nameField.layer.borderWidth = 0.3;
    self.nameField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameField.delegate = self;
    [self.nameField addTarget:self action:@selector(nameFieldMethod:) forControlEvents:UIControlEventEditingChanged];
    
    //密码
    self.pwdLabPre = [[UILabel alloc]init];
    [self.view addSubview:self.pwdLabPre];
    [self.pwdLabPre mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.nameLabPre.mas_bottom).offset(30);
        make.left.offset(15);
        make.width.offset(70);
        
    }];
    self.pwdLabPre.text = @"密  码:";
    self.pwdLabPre.textColor = [UIColor blackColor];
    
    //密码输入框
    self.pwdField = [[UITextField alloc]init];
    [self.view addSubview:self.pwdField];
    [self.pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.nameLabPre.mas_bottom).offset(25);
        make.right.offset(-15);
        make.left.mas_equalTo(self.pwdLabPre.mas_right);
        make.height.offset(30);
    }];
    self.pwdField.placeholder = @"请输入密码";
    self.pwdField.layer.borderWidth = 0.3;
    self.pwdField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.pwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pwdField.secureTextEntry = YES;
    self.pwdField.delegate = self;
    [self.pwdField addTarget:self action:@selector(passwordFieldMethod:) forControlEvents:UIControlEventEditingChanged];
   
    
    //增加
    self.addBtn = [[UIButton alloc]init];
    [self.view addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.top.mas_equalTo(self.pwdLabPre.mas_bottom).offset(35);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.2);
        make.height.offset(30);
    }];
    [self.addBtn setTitle:@"增加" forState:UIControlStateNormal];
    self.addBtn.backgroundColor  = [UIColor blackColor];
    [self.addBtn addTarget:self action:@selector(addBtnClickMethod) forControlEvents:UIControlEventTouchUpInside];
    
    //删除
    self.deleteBtn = [[UIButton alloc]init];
    [self.view addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.addBtn.mas_right).offset(15);
        make.top.mas_equalTo(self.pwdLabPre.mas_bottom).offset(35);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.2);
        make.height.offset(30);
    }];
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    self.deleteBtn.backgroundColor  = [UIColor blackColor];
    [self.deleteBtn addTarget:self action:@selector(deleteClickMethod) forControlEvents:UIControlEventTouchUpInside];
    
    //查找
    self.selectBtn = [[UIButton alloc]init];
    [self.view addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.deleteBtn.mas_right).offset(15);
        make.top.mas_equalTo(self.pwdLabPre.mas_bottom).offset(35);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.2);
        make.height.offset(30);
    }];
    [self.selectBtn setTitle:@"查询" forState:UIControlStateNormal];
    self.selectBtn.backgroundColor  = [UIColor blackColor];
    [self.selectBtn addTarget:self action:@selector(selectBtnClickMethod) forControlEvents:UIControlEventTouchUpInside];
    
    
    //修改
    self.changeBtn = [[UIButton alloc]init];
    [self.view addSubview:self.changeBtn];
    [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.selectBtn.mas_right).offset(15);
        make.top.mas_equalTo(self.pwdLabPre.mas_bottom).offset(35);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.2);
        make.height.offset(30);
    }];
    [self.changeBtn setTitle:@"修改" forState:UIControlStateNormal];
    self.changeBtn.backgroundColor  = [UIColor blackColor];
    [self.changeBtn addTarget:self action:@selector(changeBtnClickMethod) forControlEvents:UIControlEventTouchUpInside];
}




/**
 *  获取输入的平台信息
 *
 */
-(void)titleFieldMethod:(UITextField *)sender{

    NSLog(@"输入的title:%@",[sender text]);
    [[NSUserDefaults standardUserDefaults]setObject:[sender text] forKey:titleFd];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

/**
 *  获取输入的用户名信息
 *
 */
-(void)nameFieldMethod:(UITextField *)sender{
     NSLog(@"输入的用户名:%@",[sender text]);
    [[NSUserDefaults standardUserDefaults]setObject:[sender text] forKey:nameFd];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

/**
 *  获取输入的密码信息
 *
 */
-(void)passwordFieldMethod:(UITextField *)sender{
     NSLog(@"输入的密码%@",[sender text]);
    [[NSUserDefaults standardUserDefaults]setObject:[sender text] forKey:passwordFd];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


/**
 *  增加事件
 */
-(void)addBtnClickMethod{
    
    [[DBObject sharedInstance]insetTitle:[[NSUserDefaults standardUserDefaults]objectForKey:titleFd] WithName:[[NSUserDefaults standardUserDefaults]objectForKey:nameFd] WithPassWord:[[NSUserDefaults standardUserDefaults]objectForKey:passwordFd]];
    if ([self.titleField.text isEqualToString:@""]&&[self.nameField.text isEqualToString:@""]&&[self.pwdField.text isEqualToString:@""]) {
        [self.view makeToast:@"请完整填好数据"
                    duration:2.0
                    position:CSToastPositionCenter];
        
    } else {
        
        [self.view makeToast:@"数据添加成功"
                    duration:2.0
                    position:CSToastPositionCenter];
    }
    //成功添加后,要清空输入框内容
    self.titleField.text = @"";
    self.nameField.text = @"";
    self.pwdField.text = @"";
    
   
    
}

/**
 *  删除事件
 */
-(void)deleteClickMethod{
    

    DeleteViewController *deleteVc = [[DeleteViewController alloc]init];
    [self.navigationController pushViewController:deleteVc animated:YES];

}

/**
 *  查询事件
 */
-(void)selectBtnClickMethod{

    ChooseViewController *searchVc = [[ChooseViewController alloc]init];
    [self.navigationController pushViewController:searchVc animated:YES];

}

/**
 *  修改事件
 */
-(void)changeBtnClickMethod{

    UpdateViewController *updateVc = [[UpdateViewController alloc]init];
    [self.navigationController pushViewController:updateVc animated:YES];

}

























@end
