//
//  JBPNode.m
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/3/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import "JBPNode.h"

@implementation JBPNode

- (id)init
{
    self = [super init];
    if (self) {
        self.isSong = NO;
        self.neightbors = [NSMutableDictionary dictionary];
        self.songIdentifiers = [NSMutableArray array];
    }
    return self;
}

- (void)addToNode:(NSString*)string withIdentifier:(NSString*)songIdentifier
{
    NSString* firstChar = [string substringToIndex:1];
    JBPNode* node;
    
    if (![[self.neightbors allKeys] containsObject:firstChar]) {
        node = [[JBPNode alloc] init];
        [self.neightbors setObject:node forKey:firstChar];
    } else {
        node = [self.neightbors objectForKey:firstChar];
    }
    
    if ([string length] == 1) {
        node.isSong = YES;
        [node.songIdentifiers addObject:songIdentifier];
    } else {
        [node addToNode:[string substringFromIndex:1] withIdentifier:songIdentifier];
    }
    
}

- (BOOL)nameIsASong:(NSString*)name
{
    NSString* firstChar = [name substringToIndex:1];
    JBPNode* node;
    
    if ([[self.neightbors allKeys] containsObject:firstChar]) {
        node = [self.neightbors objectForKey:firstChar];
    } else {
        return NO;
    }
    
    if ([name length] == 1) {
        return node.isSong;
    } else {
        return [node nameIsASong:[name substringFromIndex:1]];
    }
}

- (NSMutableArray*)getSongsIdentifiersWithPrefix:(NSString*)prefix
{
    NSMutableArray* retArray = [[NSMutableArray alloc] init];
    
    JBPNode* endOfPrefixNode = [self getNodeAtTheEndOfPrefix:prefix];
    
    if (endOfPrefixNode) {
        [endOfPrefixNode addAllSongsToArray:retArray];
    }
    
    return retArray;
}

- (JBPNode*)getNodeAtTheEndOfPrefix:(NSString*)prefix
{
    NSString* firstChar = [prefix substringToIndex:1];
    JBPNode* node;
    
    if ([[self.neightbors allKeys] containsObject:firstChar]) {
        node = [self.neightbors objectForKey:firstChar];
        
        if ([prefix length] == 1) {
            return node;
        } else {
            return [node getNodeAtTheEndOfPrefix:[prefix substringFromIndex:1]];
        }
    } else {
        return nil;
    }
}

- (void)addAllSongsToArray:(NSMutableArray*)array
{
    if (self.isSong) {
        [array addObjectsFromArray:self.songIdentifiers];
    }
    
    for (JBPNode* node in [self.neightbors allValues]) {
        [node addAllSongsToArray:array];
    }
}

@end
