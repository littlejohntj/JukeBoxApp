//
//  JBPJukeBoxController.m
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/4/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import "JBPJukeBoxController.h"

@implementation JBPJukeBoxController

+ (JBPJukeBoxController*)sharedInstance
{
    
    static JBPJukeBoxController *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[JBPJukeBoxController alloc] init];
    });
    
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.queuePlaylist = [[JBPQueuePlaylist alloc] initWithName:@"Queue"];
        self.currentSongIndex = 0;
        self.isCurrentlyPlayingSong = NO;
        self.musicStore = [JBPMusicStore sharedInstance];
    }
    return self;
}

- (void)getNextSongAndPlayIt
{
    if (_currentSong) {
        [_currentSong stopPlayingSong];
        _isCurrentlyPlayingSong = NO;
    }
    
    _currentSong = nil;
    
    NSString* nextSongIdentifer;
    
    if (![_queuePlaylist isEmpty]) {
        NSLog(@"QUEUE WAS NOT EMPTY");
        nextSongIdentifer = [_queuePlaylist getNextSongIdentifier];
        _currentSong = [_musicStore getSongFromIdentifier:nextSongIdentifer];
    } else {
        NSLog(@"QUEUE WAS EMPTY");
        if (_currentPlaylist) {
            _currentSongIndex = (_currentSongIndex + 1) % [_currentPlaylist.songIdentifers count];
            nextSongIdentifer = [_currentPlaylist getSongIdeniferAtIndex:[[_currentOrder objectAtIndex:_currentSongIndex] intValue]];
            _currentSong = [_musicStore getSongFromIdentifier:nextSongIdentifer];
        }
    }
    
    if (_currentSong) {
        [_currentSong play];
        _isCurrentlyPlayingSong = YES;
    }
}

- (void)setPlaylistAndPlayAtIndex:(NSInteger)index
{
    if (_currentSong) {
        [_currentSong stopPlayingSong];
        _isCurrentlyPlayingSong = NO;
    }
    
    _currentPlaylist = _currentlyViewedPlaylist;
    [self setPlayOrder];
    _currentSongIndex = index;
    NSString* nextSongIdentifer = [_currentPlaylist getSongIdeniferAtIndex:[[_currentOrder objectAtIndex:_currentSongIndex] intValue]];
    _currentSong = [_musicStore getSongFromIdentifier:nextSongIdentifer];
    [_currentSong play];
    _isCurrentlyPlayingSong = YES;
}



- (void)setPlaylistAndPlayRandom
{
    
    if ([_currentlyViewedPlaylist.songIdentifers count] == 0) {
        return;
    }
    
    if (_currentSong) {
        [_currentSong stopPlayingSong];
        _isCurrentlyPlayingSong = NO;
    }
    
    _currentPlaylist = _currentlyViewedPlaylist;
    [self setPlayOrder];
    [self shufflePlayOrder];
    _currentSongIndex = 0;
    NSString* nextSongIdentifer = [_currentPlaylist getSongIdeniferAtIndex:[[_currentOrder objectAtIndex:_currentSongIndex] intValue]];
    _currentSong = [_musicStore getSongFromIdentifier:nextSongIdentifer];
    [_currentSong play];
    _isCurrentlyPlayingSong = YES;
    
}

- (void)setPlayOrder
{
    NSUInteger count = [_currentPlaylist.songIdentifers count];
    _currentOrder = [NSMutableArray array];
    for (NSInteger i = 0; i < count; i++) {
        [_currentOrder addObject:@(i)];
    }
}

- (void)shufflePlayOrder
{
    NSUInteger count = [self.currentOrder count];
    if (count <= 1) return;
    for (NSUInteger i = 0; i < count - 1; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [self.currentOrder exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}

- (JBPSong*)getSongFromCurrentlyViewedAtIndex:(NSInteger)index;
{
    JBPSong* song = [_musicStore getSongFromIdentifier:[_currentlyViewedPlaylist.songIdentifers objectAtIndex:index]];
    return song;
}

- (BOOL)getIsCurrentlyPlaying
{
    return _isCurrentlyPlayingSong;
}

- (BOOL)hasCurrentSong
{
    return !(_currentSong == nil);
}

- (void)playCurrentSong
{
    [_currentSong play];
    _isCurrentlyPlayingSong = YES;
}

- (void)pauseCurrentSong
{
    [_currentSong pause];
    _isCurrentlyPlayingSong = NO;
}

- (void)addSongToQueueFromIndex:(NSInteger)index
{
    [_queuePlaylist addSongIdentifier:[_currentlyViewedPlaylist getSongIdeniferAtIndex:index]];
}

- (NSString*)getCurentSongName
{
    return [_currentSong getName];
}

- (NSString*)getCurrentSongAlbum
{
    return [_currentSong getAlbumName];
}

- (NSString*)getCurrentSongArtist
{
    return [_currentSong getArtistName];
}

@end
