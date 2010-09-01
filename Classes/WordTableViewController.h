//
//  WordTableViewController.h
//  GDD-Shiritori
//
//  Created by Tonny on 10/08/20.
//  Copyright 2010 genesix Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WordTableViewController : UITableViewController {
    NSMutableArray          *dataArray;
    NSUInteger               round;
}

@property (nonatomic, retain) NSMutableArray    *dataArray;
@property (nonatomic, assign) NSUInteger         round;

- (void) close:(id)sender;
@end
