//
//  JBPQueuePlaylist.m
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/3/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import "JBPQueuePlaylist.h"

@implementation JBPQueuePlaylist

- (id)initWithName:(NSString*) name {
    self = [super initWithName:name];
    if (self) {
        self.canAddSongs = YES;
    }
    return self;
}

- (BOOL)isEmpty
{
    return [self.songIdentifers count] == 0;
}

- (BOOL)notEmpty
{
    return ![self isEmpty];
}

- (NSString*)getNextSongIdentifier
{
    if (self.isEmpty) {
        return nil;
    }
    
    NSString* nextSongIdenifer = [self.songIdentifers objectAtIndex:0];
    [self.songIdentifers removeObjectAtIndex:0];
    return nextSongIdenifer;
}



@end
