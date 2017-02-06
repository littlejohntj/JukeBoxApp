//
//  JBPPlaylistController.m
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/3/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import "JBPPlaylistController.h"
#import "JBPNormalPlaylist.h"

/*
 Also need to figure out the ALL playlist
 */

@implementation JBPPlaylistController


// MARK: Initilizers

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
        
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray* playlistIdentifiers;
        _defaultsPlaylistString = @"allPlaylists";
        _immutablePlaylists = [NSMutableArray array];
        _mutablePlaylists = [NSMutableArray array];
        
        NSMutableArray* playlistStrings = [defaults objectForKey:_defaultsPlaylistString];
        NSLog(@"%@", playlistStrings);
        
        for (NSString* name in playlistStrings) {
            JBPNormalPlaylist* playlist = [[JBPNormalPlaylist alloc] initMutablePlaylistWithName:name];
            playlistIdentifiers = [defaults objectForKey:name];
            if (!(playlistIdentifiers == nil)) {
                [playlist.songIdentifers addObjectsFromArray:playlistIdentifiers];
            }
            [_mutablePlaylists addObject:playlist];
        }
    }
    
    return self;
}

// MARK: Create Playlist Functions

- (void)createNewMutablePlaylistWithName:(NSString*)name
{
    BOOL foundName = NO;
    
    if ([name  isEqualToString: _defaultsPlaylistString]) {
        foundName = YES;
    }
    
    for (JBPPlaylist*playlist in _mutablePlaylists) {
        if ([[playlist getName] isEqualToString:name]) {
            foundName = YES;
        }
    }
    
    if (!foundName) {
        JBPNormalPlaylist* newMutablePlaylist = [[JBPNormalPlaylist alloc] initMutablePlaylistWithName:name];
        [_mutablePlaylists addObject:newMutablePlaylist];
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        NSArray* playlists = [defaults objectForKey:_defaultsPlaylistString];
        NSMutableArray* newPlaylists = [NSMutableArray arrayWithArray:playlists];
        [newPlaylists addObject:name];
        [defaults setObject:newPlaylists forKey:_defaultsPlaylistString];
        [defaults synchronize];
    }
    
}

- (void)createNewImmutablePlaylistWithName:(NSString*)name andIdentifiers:(NSMutableArray*)identifiers
{
    JBPNormalPlaylist* newImmutablePlaylist = [[JBPNormalPlaylist alloc] initImmutablePlaylistWithName:name];
    newImmutablePlaylist.songIdentifers = identifiers;
    [_immutablePlaylists addObject:newImmutablePlaylist];
    NSLog(@"Created New Playlist");
}

// MARK: Playlist Accessers

- (JBPNormalPlaylist*)getMutablePlaylistAtIndex:(NSInteger)index
{
    return [_mutablePlaylists objectAtIndex:index];
}

- (JBPNormalPlaylist*)getImmutablePlaylistAtIndex:(NSInteger)index
{
    return [_immutablePlaylists objectAtIndex:index];
}

// MARK: Playlist Deletes

- (void)deletePlaylistAtIndex:(NSUInteger)index
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    JBPPlaylist* playlist = [_mutablePlaylists objectAtIndex:index];
    NSMutableArray* playlists = [NSMutableArray arrayWithArray:[defaults objectForKey:_defaultsPlaylistString]];
    
    [defaults removeObjectForKey:[playlist getName]];
    [playlists removeObjectAtIndex:index];
    
    [_mutablePlaylists removeObjectAtIndex:index];
    
    [defaults setObject:playlists forKey:_defaultsPlaylistString];
    [defaults synchronize];
}

@end
