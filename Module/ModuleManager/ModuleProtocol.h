
//
//  ModuleProtocol.h
//  fmdb
//
//  Created by Wmy on 16/3/16.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileProtocol.h"
#import "DBProtocol.h"

@protocol ModuleProtocol <NSObject>

- (id <FileProtocol>)getFile;

- (id <DBProtocol>)getDB;

@end