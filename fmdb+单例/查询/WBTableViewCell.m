//
//  WBTableViewCell.m
//  fmdb+单例
//
//  Created by owen on 16/8/4.
//  Copyright © 2016年 owen. All rights reserved.
//

#import "WBTableViewCell.h"
#import "Masonry.h"
#import "DBObject.h"

@implementation WBTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self initCellMethod];
    return self;
}

//-(void)setTitleLab:(UILabel *)titleLab{
//
////    _titleLab.text = [DBObject sharedInstance].title;
//}
//
//-(void)setNameLab:(UILabel *)nameLab{
//
//    _nameLab = nameLab;
//}
//
//-(void)setPwdLab:(UILabel *)pwdLab{
//
//    _pwdLab = pwdLab;
//}

-(void)initCellMethod{

    //平台
    self.titleLab = [[UILabel alloc]init];
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(0);
        make.left.offset(0);
        make.width.offset([UIScreen mainScreen].bounds.size.width/3);
        make.height.offset(40);
    }];
    self.titleLab.text = @"腾讯QQ";
    self.titleLab.textColor = [UIColor blackColor];
    self.titleLab.textAlignment= NSTextAlignmentCenter;
    
    //用户名
    self.nameLab = [[UILabel alloc]init];
    [self addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(0);
        make.left.mas_equalTo(self.titleLab.mas_right);
        make.width.offset([UIScreen mainScreen].bounds.size.width/3);
        make.height.offset(40);
    }];
    self.nameLab.text = @"麦兜";
    self.nameLab.textColor = [UIColor blackColor];
    self.nameLab.textAlignment= NSTextAlignmentCenter;
    
    //密码
    self.pwdLab = [[UILabel alloc]init];
    [self addSubview:self.pwdLab];
    [self.pwdLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.mas_equalTo(self.nameLab.mas_right);
        make.width.offset([UIScreen mainScreen].bounds.size.width/3);
        make.height.offset(40);
    }];
    self.pwdLab.text = @"123456";
    self.pwdLab.textColor = [UIColor blackColor];
    self.pwdLab.textAlignment= NSTextAlignmentCenter;
 
}
@end
