//
//  JBPSong.h
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/4/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JBPJukeBoxController;

@protocol JBPSongDelegate <NSObject>

@required
- (void)songDidFinishPlaying;
- (void)songTimeUpdated:(double)newTime;
- (void)songPaused;
- (void)songPlayed;

@end

@interface JBPSong : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* identifier;
@property (nonatomic, strong) NSString* artistName;
@property (nonatomic, strong) NSString* albumnName;
@property (nonatomic) BOOL isBeingPlayed;
@property (nonatomic) BOOL hasArtist;
@property (nonatomic) BOOL hasAlbum;
@property (nonatomic, strong) NSNumber* duration;
@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic) double currentTimePlayed;
@property (nonatomic, strong) JBPJukeBoxController* delegate;

- (id)initWithName:(NSString*)name andIdentifier:(NSString*)identifier;
- (void)addArtist:(NSString*)artist;
- (void)addAlbum:(NSString*)album;
- (void)stopPlayingSong;
- (void)play;
- (void)pause;
- (NSString*)getName;
- (NSString*)getArtistName;
- (NSString*)getAlbumName;
- (NSString*)getIdentifier;
- (void)addSongDuration:(double)seconds;
- (void)incrementTimePlayed:(NSTimer*)timer;
- (void)startTimer;
- (void)stopTimer;

@end
