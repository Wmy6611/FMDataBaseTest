//
//  DBConnection.m
//  fmdb
//
//  Created by Wmy on 16/3/17.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "DBConnection.h"
#import "ModulesUtil.h"


/** 数据库名称 */
NSString * const kDatabaseFileName = @"Resource.db";
/** table主键 */
NSString * const kPrimaryKey       = @"KeyId";

@implementation DBConnection

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createDB];
    }
    return self;
}

+ (DBConnection *)sharedInstance {
    
    static DBConnection *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
    });
    return _instance;
}

- (void)createDB {
    [GetFile setDBFolderName:[self getUserId]];
    _fmdb = [FMDatabase databaseWithPath:[self pathForDB]];
}

- (FMDatabase *)fmdb {
    if (!_fmdb) {
        [self createDB];
    }
    return _fmdb;
}

- (FMDatabase *)getDB {
    return self.fmdb;
}

- (void)resetDB {
    if (_fmdb) {
        _fmdb = nil;
        [self createDB];
    }
}

- (void)setConnectWithNull {
    if (_fmdb) {
        _fmdb = nil;
    }
}

#pragma mark - path

// 获取当前用户ID
- (NSString *)getUserId {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUD_UserID];
}

// 获取当前用户数据库
- (NSString *)pathForDB {
    return [[GetFile getDBPath] stringByAppendingPathComponent:kDatabaseFileName];
}

#pragma mark - create table

- (void)createTableWithSqlString:(NSString *)sql {

    [self resetDB];
    
    if (![_fmdb open]) {
        NSLog(@"%s,\n%@", __func__, _fmdb.lastErrorMessage);
        return;
    }
    
    BOOL res = [_fmdb executeUpdate:sql];
    if (!res) {
        NSLog(@"%s,\n%@", __func__, _fmdb.lastErrorMessage);
    }
    [_fmdb close];
}

#pragma mark - update ~ insert update delete

- (void)executeUpdateWithSqlArray:(NSArray <NSString *>*)sqlArr {
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self pathForDB]];
    [queue inDatabase:^(FMDatabase *db) {
        [sqlArr enumerateObjectsUsingBlock:^(NSString * _Nonnull sql, NSUInteger idx, BOOL * _Nonnull stop) {
            BOOL res = [db executeUpdate:sql];
            if (!res) {
                NSLog(@"%s,\n%@", __func__, db.lastErrorMessage);
            }
        }];
    }];
    [queue close];
}


#pragma mark - select

//- (void)executeQueryWithSqlString:(NSString *)sql {
//    if (![_fmdb open]) {
//        NSLog(@"open failed.\n %@", _fmdb.lastErrorMessage);
//        return;
//    }
//    
//    FMResultSet *rs = [_fmdb executeQuery:sql];
//    while ([rs next]) {
//        
//    }
//    [_fmdb close];
//}

@end
