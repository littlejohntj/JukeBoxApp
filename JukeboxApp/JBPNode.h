//
//  JBPNode.h
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/3/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JBPNode : NSObject

@property (nonatomic, strong) NSMutableDictionary* neightbors;
@property (nonatomic, strong) NSMutableArray* songIdentifiers;
@property (nonatomic) BOOL isSong;


- (id)init;
- (void)addToNode:(NSString*)string withIdentifier:(NSString*)songIdentifier;
- (BOOL)nameIsASong:(NSString*)name;
- (NSMutableArray*)getSongsIdentifiersWithPrefix:(NSString*)prefix;
- (void)addAllSongsToArray:(NSMutableArray*)array;
- (JBPNode*)getNodeAtTheEndOfPrefix:(NSString*)prefix;


@end
