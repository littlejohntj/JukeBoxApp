//
//  JBPPlaylistController.m
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/3/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import "JBPPlaylistController.h"

/*
 The biggest thing left to do here is deal with persistance, will be a big job
 Also need to figure out the ALL playlist
 */

@implementation JBPPlaylistController

+ (JBPPlaylistController*)sharedInstance
{
    
    static JBPPlaylistController *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[JBPPlaylistController alloc] init];
    });
    
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        self.mutablePlaylists = [NSMutableArray array];
        self.immutablePlaylists = [NSMutableArray array];
    }
    
    return self;
}

- (JBPNormalPlaylist*)getNewMutablePlaylistWithName:(NSString*) name
{
    JBPNormalPlaylist* newMutablePlaylist = [[JBPNormalPlaylist alloc] initMutablePlaylistWithName:name];
    [self.mutablePlaylists addObject:newMutablePlaylist];
    return newMutablePlaylist;
}

- (void)createNewImmutablePlaylistWithName:(NSString*)name andIdentifiers:(NSMutableArray*)identifiers
{
    JBPNormalPlaylist* newImmutablePlaylist = [[JBPNormalPlaylist alloc] initImmutablePlaylistWithName:name];
    newImmutablePlaylist.songIdentifers = identifiers;
    [self.immutablePlaylists addObject:newImmutablePlaylist];
    NSLog(@"Created New Playlist");
}

- (JBPNormalPlaylist*)getMutablePlaylistAtIndex:(NSInteger)index
{
    return [self.mutablePlaylists objectAtIndex:index];
}

- (JBPNormalPlaylist*)getImmutablePlaylistAtIndex:(NSInteger)index
{
    return [self.immutablePlaylists objectAtIndex:index];
}

- (void)deletePlaylistAtIndex:(NSUInteger)index
{
    [self.mutablePlaylists removeObjectAtIndex:index];
}

@end
