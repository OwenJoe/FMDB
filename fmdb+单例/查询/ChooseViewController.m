//
//  ChooseViewController.m
//  fmdb+单例
//
//  Created by owen on 16/8/5.
//  Copyright © 2016年 owen. All rights reserved.
//

#import "ChooseViewController.h"
#import "Masonry.h"
#import "WBTableViewController.h"
#import "DBObject.h"

#import "SearchViewController.h"
@interface ChooseViewController ()

@end

@implementation ChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"数据查询";
    [self initButtonMethod];
}

-(void)initButtonMethod{

    UIButton *allBtn = [[UIButton alloc]init];
    [self.view addSubview:allBtn];
    [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view.mas_top).offset(100);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.4);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.05);
    }];
    [allBtn setTitle:@"全部查询" forState:UIControlStateNormal];
    [allBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    allBtn.backgroundColor = [UIColor blueColor];
    [allBtn addTarget:self action:@selector(allBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *partBtn = [[UIButton alloc]init];
    [self.view addSubview:partBtn];
    [partBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.4);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.05);
        make.top.mas_equalTo(allBtn.mas_bottom).offset(25);
        
    }];
    [partBtn setTitle:@"选择查询" forState:UIControlStateNormal];
    [partBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    partBtn.backgroundColor = [UIColor blueColor];
    [partBtn addTarget:self action:@selector(partBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)allBtnClick:(UIButton *)sender{

    //全部查找
        [[DBObject sharedInstance]selectAllMethod];
        WBTableViewController *wbTabVc = [[WBTableViewController alloc]init];
        [self.navigationController pushViewController:wbTabVc animated:YES];
}

-(void)partBtnClick:(UIButton *)sender{

    SearchViewController *searchVc = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:searchVc animated:YES];
}















@end
