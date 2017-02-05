//
//  JBPTrie.h
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/3/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JBPNode.h"

@interface JBPTrie : NSObject

@property (nonatomic, strong) JBPNode* root;

- (id)init;
- (void)addSong:(NSString*)songName withIdentifier:(NSString*)identifer;
- (NSMutableArray*)getSongIdentifiersWithPrefix:(NSString*)prefix;

@end
