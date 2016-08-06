//
//  WBTableViewController.m
//  fmdb+单例
//
//  Created by owen on 16/8/4.
//  Copyright © 2016年 owen. All rights reserved.
//

#import "Masonry.h"
#import "WBTableViewController.h"
#import "WBTableViewCell.h"
#import "DBObject.h"
@interface WBTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *wbTableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation WBTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"数据查询";
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self initTableViewMethod];
    [self initTableHeaderMethod];

    //从数组里边取出字典
    NSArray *Krry = [[NSUserDefaults standardUserDefaults]objectForKey:@"Arry"];
    _dataSource = Krry;
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.wbTableView reloadData];
}

/**
 *  显示的TableView
 */
-(void)initTableViewMethod{
    
    self.wbTableView  = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.wbTableView.delegate = self;
    self.wbTableView.dataSource =self;
    [self.view addSubview:self.self.wbTableView];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *iDs = @"cell";
    WBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iDs];
    if (!cell) {
        cell = [[WBTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iDs];
    }
    cell.titleLab.text = [_dataSource[indexPath.row] objectForKey:@"dictTitle"];
    cell.nameLab.text = [_dataSource[indexPath.row] objectForKey:@"dictName"];
    cell.pwdLab.text = [_dataSource[indexPath.row] objectForKey:@"dictPwd"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 54;
}

#pragma mark -- tableView固定头部,不滑动
-(void)initTableHeaderMethod{
    
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(self.view.mas_width);
        
        make.top.mas_equalTo(self.view.mas_top).offset(64);
        make.left.offset(0);
        make.height.offset(40);
    }];
    headerView.layer.borderWidth = 0.5;
    headerView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    
    
    
    //分割线1
    UILabel *leftLab = [[UILabel alloc]init];
    [headerView addSubview:leftLab];
    [leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.offset(1);
        make.top.offset(5);
        make.bottom.offset (-5);
        make.left.offset(self.view.frame.size.width/3);
    }];
    leftLab.backgroundColor = [UIColor lightGrayColor];
    
    
    //分割线2
    UILabel *rightLab = [[UILabel alloc]init];
    [headerView addSubview:rightLab];
    [rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.offset(1);
        make.top.offset(5);
        make.bottom.offset (-5);
        make.left.offset(self.view.frame.size.width/3*2);
    }];
    rightLab.backgroundColor = [UIColor lightGrayColor];
    
    //名称
    UILabel *nameLab = [[UILabel alloc]init];
    [headerView addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(0);
        make.left.offset(0);
        make.width.offset(self.view.frame.size.width/3);
        make.height.offset(40);
    }];
    nameLab.text = @"平台";
    nameLab.textColor = [UIColor lightGrayColor];
    nameLab.textAlignment= NSTextAlignmentCenter;
    
    //金额
    UILabel *moneyLab = [[UILabel alloc]init];
    [headerView addSubview:moneyLab];
    [moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(0);
        make.left.mas_equalTo(nameLab.mas_right);
        make.width.offset(self.view.frame.size.width/3);
        make.height.offset(40);
    }];
    moneyLab.text = @"用户名";
    moneyLab.textColor = [UIColor lightGrayColor];
    moneyLab.textAlignment= NSTextAlignmentCenter;
    
    //单数
    UILabel *countLab = [[UILabel alloc]init];
    [headerView addSubview:countLab];
    [countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.mas_equalTo(moneyLab.mas_right);
        make.width.offset(self.view.frame.size.width/3);
        make.height.offset(40);
    }];
    countLab.text = @"密码";
    countLab.textColor = [UIColor lightGrayColor];
    countLab.textAlignment= NSTextAlignmentCenter;
}

@end
