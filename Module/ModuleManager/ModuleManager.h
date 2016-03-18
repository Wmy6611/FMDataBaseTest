//
//  ModuleManager.h
//  fmdb
//
//  Created by Wmy on 16/3/16.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModuleProtocol.h"

@interface ModuleManager : NSObject <ModuleProtocol>

+ (ModuleManager *)sharedInstance;


@end
