//
//  DBModule.m
//  fmdb
//
//  Created by Wmy on 16/3/16.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "DBModule.h"
#import "DBUsers.h"

@interface DBModule ()
@property (nonatomic, strong) DBUsers *dbUsers;
@end

@implementation DBModule

- (instancetype)init {
    self = [super init];
    if (self) {
        _dbUsers = [[DBUsers alloc] init];
    }
    return self;
}

+ (DBModule *)sharedInstance {
    static DBModule *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
    });
    return _instance;
}

#pragma mark - protocol

- (id <DBUsersProtocol>)getUsersDB {
    return _dbUsers;
}

@end
