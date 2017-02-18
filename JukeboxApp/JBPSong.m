//
//  JBPSong.m
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/4/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import "JBPSong.h"
#import "JBPJukeBoxController.h"

@implementation JBPSong

- (id)initWithName:(NSString*)name andIdentifier:(NSString*)identifier
{
    self = [super init];
    if (self) {
        self.name = name;
        self.identifier = identifier;
        self.isBeingPlayed = NO;
        self.hasAlbum = NO;
        self.hasArtist = NO;
        self.duration = 0;
        self.timer = nil;
        self.currentTimePlayed = 0;
    }
    return self;
}

- (void)addArtist:(NSString*)artist
{
    self.artistName = artist;
    self.hasArtist = YES;
}

- (void)addAlbum:(NSString*)album
{
    self.albumnName = album;
    self.hasAlbum = YES;
}

- (void)addSongDuration:(double)seconds
{
    self.duration = [NSNumber numberWithDouble:seconds];
}

- (void)stopPlayingSong
{
    if (self.timer) {
        [self.timer invalidate];
    }
    self.isBeingPlayed = NO;
    self.currentTimePlayed = 0;
}

- (void)play
{
    NSLog(@"this might run");
}

- (void)pause
{
    NSLog(@"this shouldnt run");
}

- (void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(incrementTimePlayed:) userInfo:nil repeats:YES];
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)incrementTimePlayed:(NSTimer*)timer;
{
    self.currentTimePlayed += 0.1;
    if (self.currentTimePlayed > self.duration.doubleValue) {
        [self stopTimer];
        [self.delegate songDidFinishPlaying];
    }
}

- (NSString*)getIdentifier
{
    return self.identifier;
}

- (NSString*)getName
{
    return self.name;
}

- (NSString*)getArtistName
{
    return self.artistName;
}

- (NSString*)getAlbumName
{
    return self.albumnName;
}

@end
