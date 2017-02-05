//
//  JBPMusicStore.h
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/4/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JBPTrie.h"
#import "JBPSong.h"


@interface JBPMusicStore : NSObject

@property (strong, nonatomic) JBPTrie* songNameTrie;
@property (strong, nonatomic) NSMutableDictionary* songDictionary;

+ (JBPMusicStore*)sharedInstance;
- (id)init;
- (void)addSongsToMusicStore:(NSMutableArray*)songArray;
- (JBPSong*)getSongFromIdentifier:(NSString*)identifier;
@end
