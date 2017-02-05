//
//  JBPPlaylistController.h
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/3/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JBPNormalPlaylist.h"

@interface JBPPlaylistController : NSObject

@property (strong, nonatomic) NSMutableArray* mutablePlaylists;
@property (strong, nonatomic) NSMutableArray* immutablePlaylists;

+ (JBPPlaylistController*)sharedInstance;

- (id)init;

- (JBPNormalPlaylist*)getNewMutablePlaylistWithName:(NSString*) name;
- (void)createNewImmutablePlaylistWithName:(NSString*)name andIdentifiers:(NSMutableArray*)identifiers;

- (void)deletePlaylistAtIndex:(NSUInteger)index;
- (JBPNormalPlaylist*)getImmutablePlaylistAtIndex:(NSInteger)index;
- (JBPNormalPlaylist*)getMutablePlaylistAtIndex:(NSInteger)index;

@end
