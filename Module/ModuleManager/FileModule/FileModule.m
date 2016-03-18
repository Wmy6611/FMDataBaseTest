//
//  FileModule.m
//  fmdb
//
//  Created by Wmy on 16/3/16.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "FileModule.h"

static NSString * const kAppDBPath = @"com.app.database";

@interface FileModule ()
@property (nonatomic, strong) NSString *dbFolderName;
@end

@implementation FileModule

+ (FileModule *)sharedInstance {
    static FileModule *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
    });
    return _instance;
}

#pragma mark - configure

- (void)setDBFolderName:(nonnull NSString *)folderName {
    if (folderName.length == 0) {
        NSAssert(false, @"folderName不可用\n%s", __func__);
        return;
    }
    self.dbFolderName = folderName;
    [self createDBFolder];
}

#pragma mark - 当前用户数据存放路径

- (NSString *)getDBPath {
    return [[self getAppDBPath] stringByAppendingPathComponent:self.dbFolderName];
}

- (void)createDBFolder {
    [self createFolderAtPath:[self getDBPath]];
}

- (void)removeDBFolder {
    [self removeFolderAtPath:[self getDBPath]];
}

#pragma mark - app数据存放根路径

- (NSString *)getAppDBPath {
    return [[self getCachesPath] stringByAppendingPathComponent:kAppDBPath];
}

- (void)createAppDBFolder {
    [self createFolderAtPath:[self getAppDBPath]];
}

- (void)removeAppDBFolder {
    [self removeFolderAtPath:[self getAppDBPath]];
}

#pragma mark - 通过路径创建文件夹

- (void)createFolderAtPath:(NSString *)path {
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        BOOL res = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if (!res) {
            NSLog(@"%s\n文件夹创建失败 - path:%@", __func__, [self getAppDBPath]);
        }
    }
}

- (void)removeFolderAtPath:(NSString *)path {
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

#pragma mark -

- (NSString *)getCachesPath {
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
}

- (NSString *)getLibarayPath {
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
}

- (NSString *)getDocumentPath {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
}

- (NSString *)getTmpPath {
    return NSTemporaryDirectory();
}

- (NSString *)getHomePath {
    return NSHomeDirectory();
}

@end
