//
//  ViewController.m
//  FMDataBaseTest
//
//  Created by Wmy on 16/3/13.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "ViewController.h"
#import "ModulesUtil.h"
#import "User.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [GetFile removeAppDBFolder];
}

- (IBAction)action_1:(id)sender {
    
    User *user = [[User alloc] init];
    user.userID = @"1314002";
    user.name = @"balabaladf";
    user.height = 17.8;
    [[GetDataBase getUsersDB] update:user];
}

- (IBAction)action_2:(id)sender {
    User *user = [[User alloc] init];
    user.userID = @"1314002";
    user.name = @"balabalasdfsf";
    user.height = 17;
    [[GetDataBase getUsersDB] delete:user];
}

- (IBAction)action_3:(id)sender {
    NSArray *arr = [[GetDataBase getUsersDB] selectForUserName:@"balabala"];
    [arr enumerateObjectsUsingBlock:^(User *user, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"id:%@, name:%@, height:%f", user.userID, user.name, user.height);
    }];
}

- (IBAction)action_4:(id)sender {
    User *user = [[User alloc] init];
    user.userID = @"1314001";
    user.name = @"balabala";
    user.height = 16.8;
    User *user1 = [[User alloc] init];
    user1.userID = @"1314002";
    user1.name = @"dkfsf";
    user1.height = 16.2;
    [[GetDataBase getUsersDB] insert:@[user]];

}

- (IBAction)action_5:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@"131401234" forKey:kUD_UserID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[GetDataBase getUsersDB] createUsersTable];
}

@end
