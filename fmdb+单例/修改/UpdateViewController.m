//
//  UpdateViewController.m
//  fmdb+单例
//
//  Created by owen on 16/8/5.
//  Copyright © 2016年 owen. All rights reserved.
//

#import "UpdateViewController.h"
#import "Masonry.h"
#import "DBObject.h"
#import "UIView+Toast.h"

@interface UpdateViewController ()<UITextFieldDelegate>

@end

@implementation UpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改数据";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addUIMethod];
}

-(void)addUIMethod{
    
    //用户名字
    UILabel *titleLabPre = [[UILabel alloc]init];
    [self.view addSubview: titleLabPre];
    [titleLabPre mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(95);
        make.left.offset(15);
        make.width.offset(100);
        
    }];
    titleLabPre.text = @"平台名称  :";
    titleLabPre.textColor = [UIColor blackColor];
    
    //用户输入框
    self.titleField = [[UITextField alloc]init];
    [self.view addSubview:self.titleField];
    [self.titleField mas_makeConstraints:^(MASConstraintMaker *make) {
         make.height.offset(30);
        make.top.offset(90);
        make.right.offset(-15);
        make.left.mas_equalTo(titleLabPre.mas_right);
    }];
    self.titleField.placeholder = @"请输入平台名称";
    self.titleField.layer.borderWidth = 0.3;
    self.titleField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.titleField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.titleField.delegate = self;
    [self.titleField addTarget:self action:@selector(title:) forControlEvents:UIControlEventEditingChanged];
    
    //新用户
    UILabel *newerNameLabPre = [[UILabel alloc]init];
    [self.view addSubview:newerNameLabPre];
    [newerNameLabPre mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(titleLabPre.mas_bottom).offset(30);
        make.left.offset(15);
        make.width.offset(100);
        
    }];
    newerNameLabPre.text = @"新用户名称:";
    newerNameLabPre.textColor = [UIColor blackColor];
    
    //新用户输入框
    self.newerNameField = [[UITextField alloc]init];
    [self.view addSubview:self.newerNameField];
    [self.newerNameField mas_makeConstraints:^(MASConstraintMaker *make) {
         make.height.offset(30);
        make.top.mas_equalTo(titleLabPre.mas_bottom).offset(25);
        make.right.offset(-15);
        make.left.mas_equalTo(titleLabPre.mas_right);
    }];
    self.newerNameField.placeholder = @"请输入新用户名称";
    self.newerNameField.layer.borderWidth = 0.3;
    self.newerNameField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.newerNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.newerNameField.delegate = self;
    [self.newerNameField addTarget:self action:@selector(newerName:) forControlEvents:UIControlEventEditingChanged];
    
    //修改
    UIButton *updateBtn = [[UIButton alloc]init];
    [self.view addSubview:updateBtn];
    [updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //        make.left.offset(15);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(_newerNameField.mas_bottom).offset(35);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.2);
        make.height.offset(30);
    }];
    [updateBtn setTitle:@"修改" forState:UIControlStateNormal];
    updateBtn.backgroundColor  = [UIColor blackColor];
    [updateBtn addTarget:self action:@selector(updateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)updateBtnClick:(UIButton *)sender{
    
    [[DBObject sharedInstance]updateWithNewName:[[NSUserDefaults standardUserDefaults]objectForKey:@"newerNameFd"]
                                    WithTitle:[[NSUserDefaults standardUserDefaults]objectForKey:@"titleFd"]
     ];
   
    
    if ([self.titleField.text isEqualToString:@""]&&[self.newerNameField.text isEqualToString:@""]) {
        [self.view makeToast:@"平台或新用户不能为空"
                    duration:2.0
                    position:CSToastPositionCenter];
    } else {
        [self.view makeToast:@"数据修改成功"
                    duration:2.0
                    position:CSToastPositionCenter];
    }
    self.titleField.text =@"";
    self.newerNameField.text = @"";
}


-(void)title:(UITextField *)sender{
    
    [[NSUserDefaults standardUserDefaults]setObject:[sender text] forKey:@"titleFd"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(void)newerName:(UITextField *)sender{
    
    [[NSUserDefaults standardUserDefaults]setObject:[sender text] forKey:@"newerNameFd"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}



@end
