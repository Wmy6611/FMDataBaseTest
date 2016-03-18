//
//  DBProtocol.h
//  fmdb
//
//  Created by Wmy on 16/3/16.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBUsersProtocol.h"

@protocol DBProtocol <NSObject>

- (id <DBUsersProtocol>)getUsersDB;

@end
