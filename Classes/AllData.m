//
//  AllData.m
//  GDD-Shiritori
//
//  Created by Tonny on 10/08/20.
//  Copyright 2010 genesix Inc. All rights reserved.
//

#import "AllData.h"
#import "SynthesizeSingleton.h"

@implementation WordObject

@synthesize word;
@synthesize used;
@synthesize headCharSibling;
@synthesize tailCharSibling;

- (void) dealloc{
    [word release];
    [headCharSibling release];
    [tailCharSibling release];
    [super dealloc];
}

- (NSString *) headChar{
    if (nil == word) return nil;
    
    return [word substringToIndex:1];
}

- (NSString *) tailChar{
    if (nil == word) return nil;
    
    return [word substringFromIndex:[word length]-1];
}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@, %@>", word, used?@"used":@"UNused"];
}
@end



@implementation AllData


@synthesize shiritori;
@synthesize headCharSet;
@synthesize tailCharSet;
@synthesize headCharDict;
@synthesize tailCharDict;
@synthesize tailWords;
@synthesize startWord;
@synthesize allRoutes;
@synthesize history;

SYNTHESIZE_SINGLETON_FOR_CLASS(AllData);

- (id)init {
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.shiritori = [NSMutableArray arrayWithObjects:
                      /* Level 1 for Tonny
                      @"nihekjdooa",
                      @"adwpvhpd",
                      @"ayhumuqh",
                      @"azvwilmtq",
                      @"auwcx",
                      @"dgsjtwnh",
                      @"dghpgq",
                      @"hmunp",
                      @"htmktkuwl",
                      @"hkadhnx",
                      @"hhktevrstpi",
                      @"psvlgmdgl",
                      @"pyfoliqwokg",
                      @"papvog",
                      @"liobcypsv",
                      @"lpxzjjrre",
                      @"liuohu",
                      @"vggensdande",
                      @"vokgvnodetk",
                      @"evhwiflxnw",
                      @"efntkt",
                      @"ediplzjo",
                      @"wrygt",
                      @"wbwwrxy",
                      @"wcysnxooby",
                      @"wbmjuvtbgc",
                      @"tqkkxj",
                      @"txejnc",
                      @"jsugdn",
                      @"qhpgwf",
                      @"fgupvrubqg",
                      @"gedztagz",
                      @"zwiorgjegfk",
                      @"kxuesedtjs",
                      @"kzqqju",
                      @"sxysbljw",
                      @"sjbejhgy",
                      @"ynfbvqhrprm",
                      @"mhstnvglfpb",
                      @"bhkejqtr",
                      @"xbkniei",
                      @"imxcnfekjg",
                      @"unylctghgmc",
                      @"cdewko",
                      @"ohiymovepjn",
                      @"nppkscoxr",
                       */
                      /* Level 2 For Tonny
                       */
                      @"taffuxl",
                      @"lllmhlqpasi",
                      @"jzdyixl",
                      @"trurj",
                      @"nhklpfyijt",
                      @"xwcxn",
                      @"zkjyhtx",
                      @"ixzqpoegz",
                      @"lllqesakn",
                      @"jfvcbtsmljx",
                      @"tyblbqljz",
                      @"naeci",
                      @"xrilelnnwl",
                      @"zqkmedpydj",
                      @"iuphtt",
                      @"lavstcieltx",
                      @"jnbhihz",
                      @"tlzzsi",
                      @"ndxkl",
                      @"xitnpzubqoj",
                      @"zoixwft",
                      @"ialvgupn",
                      nil];
    
    self.startWord = @"taffuxl";
    
    self.headCharSet = [NSCountedSet setWithCapacity:[shiritori count]];
    self.tailCharSet = [NSCountedSet setWithCapacity:[shiritori count]];
    self.headCharDict = [NSMutableDictionary dictionary];
    self.tailCharDict = [NSMutableDictionary dictionary];
    
    self.allRoutes = [NSMutableArray array];
    self.tailWords = [NSMutableArray array];
    self.history = [NSMutableArray array];
    
    for (NSString *aStr in shiritori) {
        WordObject *aWord = [[WordObject alloc] init];
        aWord.word = aStr;
        aWord.used = NO;
        
        NSString *head = [aWord headChar];
        [headCharSet addObject:head];
        
        NSString *tail = [aWord tailChar];
        [tailCharSet addObject:tail];
        
        if (nil == [headCharDict valueForKey:head]) {
            [headCharDict setValue:[NSMutableArray array] forKey:head];
        }
        [[headCharDict objectForKey:head] addObject:aWord];
        
        if (nil == [tailCharDict valueForKey:tail]) {
            [tailCharDict setValue:[NSMutableArray array] forKey:tail];
        }
        [[tailCharDict objectForKey:tail] addObject:aWord];
        
        [aWord release];
    }
    
    //    NSLog(@"Before Sort: \n%@", shiritori);
    //    [shiritori sortUsingComparator:^(id obj1, id obj2){
    //        return [obj1 caseInsensitiveCompare:obj2];
    //    }];
    //    NSLog(@"Sorted: \n%@", shiritori);
    
    //    NSArray *allValue = [headCharDict allValues];
    //    for (NSArray *anArray in allValue) {
    //        if ([anArray count] > 0) {
    //            NSUInteger i, count = [anArray count];
    //            for (i = 0; i < count; i++) {
    //                WordObject *aWord = [anArray objectAtIndex:i];
    //                if ((i+1) < count) {
    //                    aWord.headCharSibling = [anArray objectAtIndex:i+1];
    //                }
    //                
    //                int count = [headCharSet countForObject:[aWord tailChar]];
    //                if (count == 0) {
    //                    [tailWords addObject:aWord];
    //                }
    //            }
    //        }
    //    }
    //    
    //    NSArray *allTailValues = [tailCharDict allValues];
    //    for (NSArray *anArray in allTailValues) {
    //        if ([anArray count] > 0) {
    //            NSUInteger i, count = [anArray count];
    //            for (i = 0; i < count; i++) {
    //                WordObject *aWord = [anArray objectAtIndex:i];
    //                if ((i+1)<count) {
    //                    aWord.tailCharSibling = [anArray objectAtIndex:i+1];
    //                }
    //            }
    //        }
    //    }
    //    
    //    for (WordObject *aWord in tailWords) {
    //        aWord.used = YES;
    //        NSArray *headWords = [tailCharDict objectForKey:[aWord headChar]];
    //        NSUInteger i, count = [headWords count];
    //        for (i = 0; i < count; i++) {
    //            NSMutableArray *aRoute = [NSMutableArray array];
    //            // the tail element.
    //            [aRoute addObject:aWord];
    //            WordObject *nextHeadWord = [headWords objectAtIndex:i];
    //            [self generateRoutesFrom:nextHeadWord inStorage:aRoute];
    //            
    //            // Got a route! output it.
    //            NSLog(@"Got a route[%d]: \n%@\n-----------------------------------------", [aRoute count], aRoute);
    //            [self clearUsedMarkExceptTailWord:aWord andLastSecondTailWord:nextHeadWord];
    //        }
    //            
    //    }
    return self;
}

- (void) generateRoutesFrom:(WordObject*)aWord inStorage:(NSMutableArray *)storage{
    /*
     This is a recursive algorithm, the end condition is:
     A. the element is the start element.
     B. the word ended with '?' is all used.
     */
    
    // Step 1: check the word, see if the word is already been used.
    if (!aWord.used) {
        // Step 2: not used, use it!
        [storage insertObject:aWord atIndex:0];
        aWord.used = YES;
    }else {
        // it is used. If it has sibling, do with sibling.
        if (aWord.tailCharSibling) {
            [self generateRoutesFrom:aWord.tailCharSibling inStorage:storage];
        }else {
            // it does not have sibling, means, it's over.
            return;
        }
        
    }
    
    // Step 3: see if the word is the start word, if it is, then finish it.
    if ([aWord.word isEqualToString:startWord]){
        return;
    } 
    
    // Step 4: the word is not the start word, keep going.
    NSArray *headWords = [tailCharDict objectForKey:[aWord headChar]];
    NSUInteger i, count = [headWords count];
    for (i = 0; i < count; i++) {
        WordObject *nextHeadWord = [headWords objectAtIndex:i];
        [self generateRoutesFrom:nextHeadWord inStorage:storage];
        /* Step 5: We have a route which is reached some level, and ready to switch to another root.
         If the head element is start element, then we got a real route, ready to fall back.
         If the head element is not the start element, we need to remove it, and keep working on 
         another possible route.
         */
        WordObject *topWord = [storage objectAtIndex:0];
        if (topWord) {
            if ([topWord.word isEqualToString:startWord]) {
                return;
            }else {
                [storage removeObjectAtIndex:0];
            }
        }
        
    }
}


- (void) clearUsedMarkExceptTailWord:(WordObject*)tailWord andLastSecondTailWord:(WordObject*)lastSecondTailWord{
    NSArray *allValues = [headCharDict allValues];
    for (NSArray *anArray in allValues) {
        for (WordObject *aWord in anArray) {
            if (![aWord.word isEqualToString:tailWord.word] && ![aWord.word isEqualToString:lastSecondTailWord.word]) {
                aWord.used = NO;
            }
        }
    }
}



- (void)dealloc {
    [shiritori release];
    [headCharSet release];
    [tailCharSet release];
    [headCharDict release];
    [tailCharDict release];
    [tailWords release];
    [startWord release];
    [allRoutes release];
    [history release];
    [super dealloc];
}
@end
