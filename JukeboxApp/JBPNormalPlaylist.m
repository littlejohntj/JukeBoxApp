//
//  JBPNormalPlaylist.m
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/3/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import "JBPNormalPlaylist.h"

@implementation JBPNormalPlaylist

- (id)initMutablePlaylistWithName:(NSString*) name
{
    self = [super initWithName:name];
    if (self) {
        self.canAddSongs = YES;
    }
    return self;
}

- (id)initImmutablePlaylistWithName:(NSString*) name
{
    self = [super initWithName:name];
    if (self) {
        self.canAddSongs = NO;
    }
    return self;
}

- (NSInteger)getSize
{
    return [self.songIdentifers count];
}

- (NSString*)getSongIdeniferAtIndex:(NSInteger)index
{
    return self.songIdentifers[index];
}

@end
