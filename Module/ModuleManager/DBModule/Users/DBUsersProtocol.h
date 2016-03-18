//
//  DBUsersProtocol.h
//  fmdb
//
//  Created by Wmy on 16/3/17.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@protocol DBUsersProtocol <NSObject>

- (void)createUsersTable;
- (void)insert:(NSArray <User *>*)userArr;
- (void)update:(User *)user;
- (void)delete:(User *)user;
- (NSArray <User *>*)selectForUserName:(NSString *)name;

@end