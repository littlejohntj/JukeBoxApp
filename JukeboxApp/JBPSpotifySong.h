//
//  JBPSpotifySong.h
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/4/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import "JBPSong.h"
#import "JBPSpotifyServiceManager.h"

@interface JBPSpotifySong : JBPSong

@property (nonatomic, weak) JBPSpotifyServiceManager* manager;

- (id)initWithName:(NSString *)name andIdentifier:(NSString *)identifier;
- (void)play;
- (void)pause;
- (void)stopPlayingSong;

@end
