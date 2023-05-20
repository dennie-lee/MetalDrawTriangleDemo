//
//  AppDelegate.m
//  HelloTriangleDemo
//
//  Created by liqinghua on 18.4.23.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@property (strong,nonatomic) UIWindow *myWindow;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.myWindow = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.myWindow.rootViewController = [[ViewController alloc] init];
    [self.myWindow makeKeyAndVisible];
    return YES;
}

@end
