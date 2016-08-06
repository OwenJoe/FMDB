//
//  SearchViewController.m
//  fmdb+单例
//
//  Created by owen on 16/8/5.
//  Copyright © 2016年 owen. All rights reserved.
//

#import "SearchViewController.h"
#import "DBObject.h"
#import "WBTableViewCell.h"
@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating>


//searchController
@property (nonatomic,retain) UISearchController *searchController;

//tableView
@property (nonatomic,strong) UITableView *skTableView;

//数据源
@property (nonatomic,strong) NSMutableArray *dataListArry;
@property (nonatomic,strong) NSMutableArray *searchListArry;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //在iOS9中，UISearchDisplayController 已经被UISearchController替代。搜索框是一种常用的控件。
    self.title = @"搜索列表";
    
    self.dataListArry = [NSMutableArray array];
    self.searchListArry = [NSMutableArray array];
    
    
    //列出全部数据
    [[DBObject sharedInstance]selectAllMethod];
    self.dataListArry = [[NSUserDefaults standardUserDefaults]objectForKey:@"Arry"];
    

    self.skTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen  mainScreen].bounds.size.width ,[UIScreen  mainScreen].bounds.size.height)];
    
    self.skTableView.delegate = self;
    self.skTableView.dataSource = self;
    self.skTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    //创建UISearchController
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    //设置代理
    self.searchController.delegate= self;
    self.searchController.searchResultsUpdater = self;
    
    //包着搜索框外层的颜色
    self.searchController.searchBar.barTintColor = [UIColor yellowColor];
    
    //提醒字眼
    self.searchController.searchBar.placeholder= @"请输入关键字搜索";
    
   
    
    //提前在搜索框内加入搜索词
    self.searchController.searchBar.text = @"我是周杰伦";
    
    //设置UISearchController的显示属性，以下3个属性默认为YES
    
    //搜索时，背景变暗色
    self.searchController.dimsBackgroundDuringPresentation = NO;
    //搜索时，背景变模糊
//    self.searchController.obscuresBackgroundDuringPresentation = NO;
    
    //点击搜索的时候,是否隐藏导航栏
//    self.searchController.hidesNavigationBarDuringPresentation = NO;
    
    //位置
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    // 添加 searchbar 到 headerview
    self.skTableView.tableHeaderView = self.searchController.searchBar;
    
    
    
    [self.view addSubview: self.skTableView];
}




//设置区域的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (self.searchController.active) {
        
        return [self.searchListArry count];
    }
    else{
    
        return [self.dataListArry count];
    }
}

//返回单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *flag=@"cell";
    WBTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[WBTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    if (self.searchController.active) {

        cell.titleLab.text = [self.searchListArry[indexPath.row] objectForKey:@"dictTitle"];
        cell.nameLab.text = [self.searchListArry[indexPath.row] objectForKey:@"dictName"];
        cell.pwdLab.text = [self.searchListArry[indexPath.row] objectForKey:@"dictPwd"];

    }
    else{

        cell.titleLab.text = [self.dataListArry[indexPath.row] objectForKey:@"dictTitle"];
        cell.nameLab.text = [self.dataListArry[indexPath.row] objectForKey:@"dictName"];
        cell.pwdLab.text = [self.dataListArry[indexPath.row] objectForKey:@"dictPwd"];
    }
    return cell;
}




//谓词搜索过滤
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
//    //修改"Cancle"退出字眼,这样修改,按钮一开始就直接出现,而不是搜索的时候再出现
//    searchController.searchBar.showsCancelButton = YES;
//    for(id sousuo in [searchController.searchBar subviews])
//    {
//        
//        for (id zz in [sousuo subviews])
//        {
//            
//            if([zz isKindOfClass:[UIButton class]]){
//                UIButton *btn = (UIButton *)zz;
//                [btn setTitle:@"搜索" forState:UIControlStateNormal];
//                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            }
//            
//            
//        }
//    }
    
    
    NSLog(@"谓词搜索过滤");
    NSString *searchString = [self.searchController.searchBar text];
    //CONTAINS:表示包含该字符
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (self.searchListArry!= nil) {
        [self.searchListArry removeAllObjects];
    }
    //过滤数据
    self.searchListArry= [NSMutableArray arrayWithArray:[self.dataListArry filteredArrayUsingPredicate:preicate]];
    //刷新表格
    [self.skTableView reloadData];
}











@end
