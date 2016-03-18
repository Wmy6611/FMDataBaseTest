//
//  ModuleManager.m
//  fmdb
//
//  Created by Wmy on 16/3/16.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "ModuleManager.h"

#import "FileModule.h"
#import "DBModule.h"

#define GetClassName(_cls) \
NSStringFromClass([_cls class])

#define AddModule(_moduleClassName) \
[self.modules setObject:[_moduleClassName sharedInstance] forKey:GetClassName(_moduleClassName)]

#define ReturnModule(_moduleClassName) \
return [self.modules  objectForKey:GetClassName(_moduleClassName)]


@interface ModuleManager ()
@property (nonatomic, strong) NSMutableDictionary *modules;
@end

@implementation ModuleManager

- (NSMutableDictionary *)modules {
    if (!_modules) {
        _modules = [[NSMutableDictionary alloc] init];
    }
    return _modules;
}

- (void)dealloc {
    if (_modules) {
        [_modules removeAllObjects];
        _modules = nil;
    }
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        AddModule(FileModule);
        AddModule(DBModule);
    }
    return self;
}

+ (ModuleManager *)sharedInstance {
    
    static ModuleManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
    });
    return _instance;
}


#pragma mark - protocol

- (id <FileProtocol>)getFile {
    ReturnModule(FileModule);
}

- (id <DBProtocol>)getDB {
    ReturnModule(DBModule);
}

@end
