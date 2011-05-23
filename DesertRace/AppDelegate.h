//
//  AppDelegate.h
//  DesertRace
//
//  Created by Mohammad Azam on 5/10/11.
//  Copyright HighOnCoding 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
