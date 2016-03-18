//
//  DBConnection.h
//  fmdb
//
//  Created by Wmy on 16/3/17.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

#define kFMDBSharedInstance     [DBConnection sharedInstance]
#define kFMDB                   [kFMDBSharedInstance getDB]

/**
 *  table主键
 */
extern NSString * const kPrimaryKey;

@interface DBConnection : NSObject
@property (nonatomic, strong) FMDatabase *fmdb;

+ (DBConnection *)sharedInstance;

- (FMDatabase *)getDB;

- (NSString *)pathForDB;

//- (void)createDB;
//
//- (void)resetDB;

- (void)setConnectWithNull;

#pragma mark - create table
- (void)createTableWithSqlString:(NSString *)sql;
#pragma mark - update ~ insert update delete
- (void)executeUpdateWithSqlArray:(NSArray <NSString *>*)sqlArr;
#pragma mark - select
//- (void)executeQueryWithSqlString:(NSString *)sql;

@end



/**
 
 # 创建
    @"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' TEXT, '%@' DOUBLE)"
 
 # 插入
    @"INSERT INTO %@ (%@, %@, %@) VALUES ('%@', '%@', '%f')"
 
 # 更新
    @"UPDATE %@ SET %@ = '%@', %@ = '%f' WHERE %@ = '%@'"
 
 # 删除
    @"DELETE FROM %@ WHERE %@ = '%@'"
 
 # 查询
    @"SELECT * FROM %@"
    
    @"SELECT * FROM %@ WHERE %@ = '%@'"
  
     最常见的用法，当然是倒出所有数据库的内容：
     select * from film;
     如果资料太多了，我们或许会想限制笔数：
     select * from film limit 10;
     或是照着电影年份来排列：
     select * from film order by year limit 10;
     或是年份比较近的电影先列出来：
     select * from film order by year desc limit 10;
     或是我们只想看电影名称跟年份：
     select title, year from film order by year desc limit 10;
     查所有茱蒂佛斯特演过的电影：
     select * from film where starring='Jodie Foster';
     查所有演员名字开头叫茱蒂的电影('%' 符号便是 SQL 的万用字符）：
     select * from film where starring like 'Jodie%';
     查所有演员名字以茱蒂开头、年份晚于1985年、年份晚的优先列出、最多十笔，只列出电影名称和年份：
     select title, year from film where starring like 'Jodie%' and year >= 1985 order by year desc limit 10;
     有时候我们只想知道数据库一共有多少笔资料：
     select count(*) from film;
     有时候我们只想知道1985年以后的电影有几部：
     select count(*) from film where year >= 1985;
 
 */
