//
//  JBPNormalPlaylist.h
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/3/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import "JBPPlaylist.h"

@interface JBPNormalPlaylist : JBPPlaylist

- (id)initImmutablePlaylistWithName:(NSString*) name;
- (id)initMutablePlaylistWithName:(NSString*) name;

- (NSInteger)getSize;
- (NSString*)getSongIdeniferAtIndex:(NSInteger)index;

@end
