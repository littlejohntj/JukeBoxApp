//
//  JBPJukeBoxController.h
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/4/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JBPQueuePlaylist.h"
#import "JBPNormalPlaylist.h"
#import "JBPMusicStore.h"
#import "JBPSong.h"

@interface JBPJukeBoxController : NSObject <JBPSongDelegate>

@property (nonatomic, strong) JBPSong* currentSong;
@property (nonatomic) NSInteger currentSongIndex;
@property (nonatomic, strong) NSMutableArray* currentOrder;
@property (nonatomic, strong) JBPQueuePlaylist* queuePlaylist;
@property (nonatomic, strong) JBPNormalPlaylist* currentPlaylist;
@property (nonatomic, strong) JBPNormalPlaylist* currentlyViewedPlaylist;
@property (nonatomic, strong) JBPMusicStore* musicStore;
@property (nonatomic) BOOL isCurrentlyPlayingSong;

+ (JBPJukeBoxController*)sharedInstance;
- (id)init;
- (void)getNextSongAndPlayIt;
- (void)setPlaylistAndPlayRandom;
- (void)setPlaylistAndPlayAtIndex:(NSInteger)index;
- (NSString*)getCurentSongName;
- (NSString*)getCurrentSongAlbum;
- (NSString*)getCurrentSongArtist;
- (void)playCurrentSong;
- (void)pauseCurrentSong;
- (BOOL)getIsCurrentlyPlaying;
- (JBPSong*)getSongFromCurrentlyViewedAtIndex:(NSInteger)index;
- (NSString*)getSongIdentifierFromCurrentlyViewedAtIndex:(NSInteger)index;
- (BOOL)hasCurrentSong;
- (void)addSongToQueueFromIndex:(NSInteger)index;
- (NSString*)getCurrentSongIdentifier;
- (void) songDidFinishPlaying;

@end
