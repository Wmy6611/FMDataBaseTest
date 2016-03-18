//
//  FileProtocol.h
//  fmdb
//
//  Created by Wmy on 16/3/16.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FileProtocol <NSObject>

/** 用uid初始化当前用户数据保存路径 */
- (void)setDBFolderName:(NSString *)folderName;

#pragma mark - 当前用户数据存放路径
- (NSString *)getDBPath;
//- (void)createDBFolder;
- (void)removeDBFolder;

#pragma mark - app数据存放根路径
- (NSString *)getAppDBPath;
- (void)createAppDBFolder;
- (void)removeAppDBFolder;

#pragma mark - 通过路径创建/删除文件夹
- (void)createFolderAtPath:(NSString *)path;
- (void)removeFolderAtPath:(NSString *)path;

#pragma mark - 沙盒根目录
- (NSString *)getHomePath;
- (NSString *)getTmpPath;
- (NSString *)getDocumentPath;
- (NSString *)getLibarayPath;
- (NSString *)getCachesPath;

@end