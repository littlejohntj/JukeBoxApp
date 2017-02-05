//
//  JBPPlaylist.h
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/3/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JBPPlaylist : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSMutableArray* songIdentifers;
@property (nonatomic) BOOL canAddSongs;


- (id)initWithName:(NSString*) name;
- (NSString *) getName;
- (void)addSongIdentifier:(NSString*)newSongIdentifier;

@end
