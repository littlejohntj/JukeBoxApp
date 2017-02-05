//
//  JBPTrie.m
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/3/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import "JBPTrie.h"

@implementation JBPTrie

- (id)init
{
    self = [super init];
    self.root = [[JBPNode alloc] init];
    return self;
}

- (void)addSong:(NSString*)songName withIdentifier:(NSString*)identifer {
    [self.root addToNode:songName withIdentifier:identifer];
}

- (NSMutableArray*)getSongIdentifiersWithPrefix:(NSString*)prefix
{
    return [self.root getSongsIdentifiersWithPrefix:prefix];
}

@end
