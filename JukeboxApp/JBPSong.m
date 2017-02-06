//
//  JBPSong.m
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/4/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import "JBPSong.h"

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

- (void)stopPlayingSong
{
    self.isBeingPlayed = NO;
}

- (void)play
{
    NSLog(@"this might run");
}

- (void)pause
{
    NSLog(@"this shouldnt run");
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
