//
//  RootViewController.h
//  GDD-Shiritori
//
//  Created by Tonny on 10/08/17.
//  Copyright genesix Inc. 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    Player_GDD,
    Player_You,
}Player;

//------------------------------------------------------------------------
@interface RootViewController : UITableViewController {
    NSMutableArray *dataArray;
    Player          thePlayer;
    NSUInteger      round;
}

@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, assign) NSUInteger      round;

- (void) showHistory:(id)sender;
- (void) goBack:(id)sender;
- (IBAction) popToRoot:(id)sender;
@end
