//
//  JBPJukeBoxController.m
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/4/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import "JBPJukeBoxController.h"

@implementation JBPJukeBoxController

- (id)init
{
    self = [super init];
    if (self) {
        self.queuePlaylist = [[JBPQueuePlaylist alloc] init];
    }
    return self;
}

- (void)getNextSongAndPlayIt
{
    if (_currentSong) {
        [_currentSong stopPlayingSong];
    }
    
    NSString* nextSongIdentifer;
    
    if ([_queuePlaylist notEmpty]) {
        nextSongIdentifer = [_queuePlaylist getNextSongIdentifier];
        _currentSong = [_musicStore getSongFromIdentifier:nextSongIdentifer];
    } else {
        if (_currentPlaylist) {
            _currentSongIndex = (_currentSongIndex + 1) % [_currentPlaylist.songIdentifers count];
            nextSongIdentifer = [_currentPlaylist getSongIdeniferAtIndex:_currentSongIndex];
            _currentSong = [_musicStore getSongFromIdentifier:nextSongIdentifer];
        }
    }
    
    if (_currentSong) {
        [_currentSong play];
    }
}

@end
