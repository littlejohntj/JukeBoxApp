//
//  JBPQueuePlaylist.h
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/3/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import "JBPPlaylist.h"

@interface JBPQueuePlaylist : JBPPlaylist

- (id)initWithName:(NSString*) name;
- (BOOL)isEmpty;
- (BOOL)notEmpty;
- (NSString*)getNextSongIdentifier;

@end
