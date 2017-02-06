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
        _name = name;
        _songIdentifers = [NSMutableArray array];
    }
    return self;
}

- (NSString*) getName
{
    return _name;
}

- (void)addSongIdentifier:(NSString*)newSongIdentifier
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    if (_canAddSongs && ![_songIdentifers containsObject:newSongIdentifier]) {
        [_songIdentifers addObject:newSongIdentifier];
    }
    
    [defaults setObject:_songIdentifers forKey:_name];
    [defaults synchronize];
    
}

@end
