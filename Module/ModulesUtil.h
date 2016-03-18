//
//  ModulesUtil.h
//  fmdb
//
//  Created by Wmy on 16/3/16.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#ifndef ModulesUtil_h
#define ModulesUtil_h

    #import "ModuleManager.h"

    // 模块管理中心
    #define GetInterfaceManager() [ModuleManager sharedInstance]

    // 文件管理
    #define GetFile         [GetInterfaceManager() getFile]
    // 数据库管理
    #define GetDataBase     [GetInterfaceManager() getDB]

#endif /* ModulesUtil_h */
