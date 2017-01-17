//
//  AppDelegate.h
//  XFActionSheet
//
//  Created by xinfeng on 2017/1/17.
//  Copyright © 2017年 XFActionSheet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

