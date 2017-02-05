//
//  JBPJukeBoxController.h
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/4/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JBPSong.h"
#import "JBPQueuePlaylist.h"
#import "JBPNormalPlaylist.h"
#import "JBPMusicStore.h"

@interface JBPJukeBoxController : NSObject

@property (nonatomic, strong) JBPSong* currentSong;
@property (nonatomic) NSUInteger currentSongIndex;
@property (nonatomic, strong) NSArray* currentOrder;
@property (nonatomic, strong) JBPQueuePlaylist* queuePlaylist;
@property (nonatomic, strong) JBPNormalPlaylist* currentPlaylist;
@property (nonatomic, strong) JBPPlaylist* currentlyViewedPlaylist;
@property (nonatomic, strong) JBPMusicStore* musicStore;

- (id)init;
- (void)getNextSongAndPlay;

@end
