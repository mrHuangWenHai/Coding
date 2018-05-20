//
//  HWCodingTabBarController.m
//  Coding
//
//  Created by 黄文海 on 2018/3/13.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWCodingTabBarController.h"
#import "HWCodingProjectViewController.h"
#import "HWCodingTaskViewController.h"
#import "HWCodingPopViewController.h"
#import "HWCodingMessageViewController.h"
#import "HWCodingMeViewController.h"
#import "HWCodingNavigationController.h"
#import "HWSwipeBetweenViewControllers.h"
#import "CodingNetAPIManager.h"

@interface HWCodingTabBarController ()

@end

@implementation HWCodingTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.barTintColor = [UIColor whiteColor];
   // CGRect tabBarFrame = self.tabBar.frame;
  //  CALayer* shadowLayer = [CALayer layer];
  //  shadowLayer.frame = CGRectMake(0, tabBarFrame.origin.y - 1, tabBarFrame.size.width, 1);
  //  shadowLayer.backgroundColor = [UIColor colorWithRed:232/255.0 green:235/255.0 blue:239/255.0 alpha:1].CGColor;
  //  [self.view.layer addSublayer:shadowLayer];
    [self setupViewControllers];
}

- (void)setupViewControllers {
    
    NSArray *tabBarItemImages = @[@"project", @"task", @"tweet", @"privatemessage", @"me"];
    NSArray *tabBarItemTitles = @[@"项目", @"任务", @"冒泡", @"消息", @"我"];

    HWCodingProjectViewController* project = [[HWCodingProjectViewController alloc] init];
    UIImage* projectSelectImage = [[UIImage imageNamed:
                            [NSString stringWithFormat:@"%@_selected",tabBarItemImages[0]]]           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* projectUnselectImage = [[UIImage imageNamed:
                            [NSString stringWithFormat:@"%@_normal",tabBarItemImages[0]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem* projectItem = [[UITabBarItem alloc] initWithTitle:tabBarItemTitles[0]
                                                              image:projectUnselectImage
                                                      selectedImage:projectSelectImage];
    project.tabBarItem = projectItem;
    HWCodingNavigationController* projectNav = [[HWCodingNavigationController alloc] initWithRootViewController:project];
    
    HWCodingTaskViewController* task = [[HWCodingTaskViewController alloc] init];
    UIImage* taskSelectImage = [[UIImage imageNamed:
                         [NSString stringWithFormat:@"%@_selected",tabBarItemImages[1]]]           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* taskUnselectImage = [[UIImage imageNamed:
                           [NSString stringWithFormat:@"%@_normal",tabBarItemImages[1]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem* taskItem = [[UITabBarItem alloc] initWithTitle:tabBarItemTitles[1]
                                                           image:taskUnselectImage
                                                   selectedImage:taskSelectImage];
    task.tabBarItem = taskItem;
    HWCodingNavigationController* taskNav = [[HWCodingNavigationController alloc] initWithRootViewController:task];
    
    HWCodingPopViewController* pop = [[HWCodingPopViewController alloc] init];
    UIImage* popSelectImage = [[UIImage imageNamed:
                        [NSString stringWithFormat:@"%@_selected",tabBarItemImages[2]]]           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* popUnselectImage = [[UIImage imageNamed:
                          [NSString stringWithFormat:@"%@_normal",tabBarItemImages[2]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem* popItem = [[UITabBarItem alloc] initWithTitle:tabBarItemTitles[2]
                                                          image:popUnselectImage
                                                  selectedImage:popSelectImage];
    
    HWSwipeBetweenViewControllers* popNav = [HWSwipeBetweenViewControllers newHWSwipeBetweenViewControllers];
    popNav.tabBarItem = popItem;
    popNav.viewControllerArray = @[pop];
    popNav.buttonTitleArray = @[@"冒泡广场",@"朋友圈",@"热门冒泡"];
    
    HWCodingMessageViewController* message = [[HWCodingMessageViewController alloc] init];
    UIImage* messageSelectImage = [[UIImage imageNamed:
                            [NSString stringWithFormat:@"%@_selected",tabBarItemImages[3]]]           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* messageUnselectImage = [[UIImage imageNamed:
                              [NSString stringWithFormat:@"%@_normal",tabBarItemImages[3]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem* messageItem = [[UITabBarItem alloc] initWithTitle:tabBarItemTitles[3]
                                                              image:messageUnselectImage
                                                      selectedImage:messageSelectImage];
    message.tabBarItem = messageItem;
    HWCodingNavigationController* messageNav = [[HWCodingNavigationController alloc] initWithRootViewController:message];
    
    message.tabBarItem.badgeColor = [UIColor redColor];
    [[CodingNetAPIManager sharedManager] requestUnReadTotalNotificationWithBlock:^(id data, NSError *error) {
        message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%@",[(NSDictionary*)data valueForKey:@"data"]];
    }];
    
    
    HWCodingMeViewController* me = [[HWCodingMeViewController alloc] init];
    UIImage* meSelectImage = [[UIImage imageNamed:
                       [NSString stringWithFormat:@"%@_selected",tabBarItemImages[4]]]           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* meUnselectImage = [[UIImage imageNamed:
                         [NSString stringWithFormat:@"%@_normal",tabBarItemImages[4]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem* meItem = [[UITabBarItem alloc] initWithTitle:tabBarItemTitles[4]
                                                              image:meUnselectImage
                                                      selectedImage:meSelectImage];
    me.tabBarItem = meItem;
    HWCodingNavigationController* meNav = [[HWCodingNavigationController alloc] initWithRootViewController:me];
    
    NSArray* viewControllers = @[projectNav, taskNav, popNav, messageNav, meNav];
    self.viewControllers = viewControllers;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
