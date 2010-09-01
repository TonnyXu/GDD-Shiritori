//
//  AllData.h
//  GDD-Shiritori
//
//  Created by Tonny on 10/08/20.
//  Copyright 2010 genesix Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface WordObject : NSObject
{
    NSString *word;
    BOOL used;
    
    WordObject *headCharSibling;
    WordObject *tailCharSibling;
}

@property (nonatomic, retain) NSString * word;
@property (nonatomic, assign) BOOL  used;
@property (nonatomic, retain) WordObject *headCharSibling;
@property (nonatomic, retain) WordObject *tailCharSibling;

- (NSString *) headChar;
- (NSString *) tailChar;


@end


@interface AllData : NSObject {
    NSMutableArray *shiritori;
    NSCountedSet *headCharSet;
    NSCountedSet *tailCharSet;
    NSMutableDictionary *headCharDict;
    NSMutableDictionary *tailCharDict;
    NSMutableArray *tailWords;
    
    NSString *startWord;
    
    NSMutableArray *allRoutes;
    
    NSMutableArray *history;
}

+ (AllData *)sharedAllData;

@property (nonatomic, retain) NSMutableArray* shiritori;
@property (nonatomic, retain) NSCountedSet* headCharSet;
@property (nonatomic, retain) NSCountedSet* tailCharSet;
@property (nonatomic, retain) NSMutableDictionary* headCharDict;
@property (nonatomic, retain) NSMutableDictionary* tailCharDict;
@property (nonatomic, retain) NSMutableArray *tailWords;
@property (nonatomic, retain) NSString *startWord;
@property (nonatomic, retain) NSMutableArray *allRoutes;
@property (nonatomic, retain) NSMutableArray *history;

- (void) generateRoutesFrom:(WordObject*)aWord inStorage:(NSMutableArray *)storage;
- (void) clearUsedMarkExceptTailWord:(WordObject*)tailWord andLastSecondTailWord:(WordObject*)lastSecondTailWord;

@end
