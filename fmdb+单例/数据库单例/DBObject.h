//
//  DBObject.h
//  单例+FMDB
//
//  Created by imac on 16/7/1.
//  Copyright © 2016年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
@interface DBObject : NSObject

@property (nonatomic,strong) FMDatabaseQueue *queue;

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *password;

@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic,strong) NSMutableArray *Array;


/**
 *  单例
 */
+(instancetype)sharedInstance;
/**
 *  新建数据库+新建表
 */
-(void)addDatabaseAndTableMethod;
/**
 *  新增
 */
-(void)insetTitle:(NSString *)title WithName:(NSString *)name  WithPassWord:(NSString *)password;
/**
 *  删除
 */
-(void)deleteWithTitle:(NSString *)title;
/**
 *  更新数据
 */
-(void)updateWithNewName:(NSString *)newName WithTitle:(NSString *)title;
/**
 *  条件查询数据
 */
-(void)selectWithTitle:(NSString *)title;

/**
 *  查询所有数据
 *
 */
-(void)selectAllMethod;
@end
