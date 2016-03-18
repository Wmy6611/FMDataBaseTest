//
//  DBUsers.m
//  fmdb
//
//  Created by Wmy on 16/3/17.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "DBUsers.h"
#import "DBConnection.h"
#import "User.h"

static NSString * const kTableUsers = @"Table_Users";
static NSString * const kUserId     = @"user_id";
static NSString * const kUserName   = @"user_name";
static NSString * const kUserHeight = @"user_height";

@implementation DBUsers

- (void)createUsersTable {
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' TEXT, '%@' DOUBLE)",
                     kTableUsers, kPrimaryKey, kUserId, kUserName, kUserHeight];
    [kFMDBSharedInstance createTableWithSqlString:sql];
    
}

#pragma mark -

- (void)insert:(NSArray <User *>*)userArr {
    
    NSMutableArray *sqlArrM = [NSMutableArray array];
    [userArr enumerateObjectsUsingBlock:^(User * _Nonnull user, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (%@, %@, %@) VALUES ('%@', '%@', '%f')",
                         kTableUsers, kUserId, kUserName, kUserHeight, user.userID, user.name, user.height];
        [sqlArrM addObject:sql];
    }];
    [kFMDBSharedInstance executeUpdateWithSqlArray:sqlArrM];
}

- (void)update:(User *)user {
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ = '%@', %@ = '%f' WHERE %@ = '%@'",
                     kTableUsers, kUserName, user.name, kUserHeight, user.height, kUserId, user.userID];
    [kFMDBSharedInstance executeUpdateWithSqlArray:@[sql]];
}

- (void)delete:(User *)user {
    
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = '%@'",
                     kTableUsers, kUserId, user.userID];
    [kFMDBSharedInstance executeUpdateWithSqlArray:@[sql]];
}


#pragma mark - 

- (NSArray <User *>*)getAllUsers {

    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@", kTableUsers];
    NSMutableArray *arrayM = [NSMutableArray array];
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[kFMDBSharedInstance pathForDB]];
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rst = [db executeQuery:sql];
        while ([rst next]) {
            User *user  = [self userWithResultSet:rst];
            [arrayM addObject:user];
        }
        [rst close];
    }];
    [queue close];
    return [arrayM copy];
}

//@"SELECT ROWID,* FROM %@ WHERE %@ = '%@'"
- (NSArray <User *>*)selectForUserName:(NSString *)name {
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@'",
                     kTableUsers, kUserName, name];
    NSMutableArray *arrayM = [NSMutableArray array];
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[kFMDBSharedInstance pathForDB]];
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rst = [db executeQuery:sql];
        while ([rst next]) {
            User *user  = [self userWithResultSet:rst];
            [arrayM addObject:user];
        }
        [rst close];
    }];
    [queue close];
    
    return [arrayM copy];
}

- (User *)userWithResultSet:(FMResultSet *)rst {
    User *user  = [[User alloc] init];
    user.userID = [rst stringForColumn:kUserId];
    user.name   = [rst stringForColumn:kUserName];
    user.height = [rst doubleForColumn:kUserHeight];
    return user;
}

@end
