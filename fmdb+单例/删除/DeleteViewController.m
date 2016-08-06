//
//  UpdateViewController.m
//  fmdb+单例
//
//  Created by owen on 16/8/5.
//  Copyright © 2016年 owen. All rights reserved.
//

#import "DeleteViewController.h"
#import "DBObject.h"
#import "Masonry.h"
#import "UIView+Toast.h"

@interface DeleteViewController ()<UITextFieldDelegate>

@end

@implementation DeleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"删除数据";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addUIMethod];
}

-(void)addUIMethod{
    
    //平台名字
    UILabel *titleLabPre = [[UILabel alloc]init];
    [self.view addSubview: titleLabPre];
    [titleLabPre mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(95);
        make.left.offset(15);
        make.width.offset(80);
        
    }];
    titleLabPre.text = @"平台名称:";
    titleLabPre.textColor = [UIColor blackColor];
    
    //平台输入框
    self.titleField = [[UITextField alloc]init];
    [self.view addSubview:self.titleField];
    [self.titleField mas_makeConstraints:^(MASConstraintMaker *make) {
         make.height.offset(30);
        make.top.offset(90);
        make.right.offset(-15);
        make.left.mas_equalTo(titleLabPre.mas_right);
    }];
    self.titleField.placeholder = @"请输入旧平台名称";
    self.titleField.layer.borderWidth = 0.3;
    self.titleField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.titleField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.titleField.delegate = self;
    [self.titleField addTarget:self action:@selector(titleDelete:) forControlEvents:UIControlEventEditingChanged];
    
  
    
    //删除
    UIButton *deleteBtn = [[UIButton alloc]init];
    [self.view addSubview:deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //        make.left.offset(15);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.titleField.mas_bottom).offset(35);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.2);
        make.height.offset(30);
    }];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    deleteBtn.backgroundColor  = [UIColor blackColor];
    [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}



-(void)deleteBtnClick:(UIButton *)sender{
    
    [[DBObject sharedInstance]deleteWithTitle:[[NSUserDefaults standardUserDefaults]objectForKey:@"titleDelete"]];

    
    if ([self.titleField.text isEqualToString:@""]) {
        [self.view makeToast:@"平台名称不能为空"
                    duration:2.0
                    position:CSToastPositionCenter];
    }
    else{
        [self.view makeToast:@"数据删除成功"
                    duration:2.0
                    position:CSToastPositionCenter];
    }
       self.titleField.text = @"";
}


-(void)titleDelete:(UITextField *)sender{
    
    [[NSUserDefaults standardUserDefaults]setObject:[sender text] forKey:@"titleDelete"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}



@end
