//
//  JBPPlaylist.m
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/3/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import "JBPPlaylist.h"

@implementation JBPPlaylist

- (id)initWithName:(NSString*) name {
    self = [super init];
    if (self) {
        self.name = name;
        self.songIdentifers = [NSMutableArray array];
    }
    return self;
}

- (NSString*) getName
{
    return self.name;
}

- (void)addSongIdentifier:(NSString*)newSongIdentifier
{
    if (self.canAddSongs && ![self.songIdentifers containsObject:newSongIdentifier]) {
        [self.songIdentifers addObject:newSongIdentifier];
    }
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_songIdentifers forKey:_name];
    [defaults synchronize];
    
}

@end
