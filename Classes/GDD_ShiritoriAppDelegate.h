//
//  GDD_ShiritoriAppDelegate.h
//  GDD-Shiritori
//
//  Created by Tonny on 10/08/17.
//  Copyright genesix Inc. 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDD_ShiritoriAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

