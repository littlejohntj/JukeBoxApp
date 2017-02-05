//
//  JBPMusicStore.m
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/4/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import "JBPMusicStore.h"

@implementation JBPMusicStore

+ (JBPMusicStore*)sharedInstance
{
    
    static JBPMusicStore *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[JBPMusicStore alloc] init];
    });
    
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    self.songNameTrie = [[JBPTrie alloc] init];
    self.songDictionary = [[NSMutableDictionary alloc] init];
    return self;
}

- (void)addSongsToMusicStore:(NSMutableArray*)songArray
{
    for (JBPSong* song in songArray) {
        [self.songNameTrie addSong:song.name withIdentifier:song.identifier];
        [self.songDictionary setObject:song forKey:song.identifier];
    }
    
    NSLog(@"Added songs into the music store");
}

- (JBPSong*)getSongFromIdentifier:(NSString*)identifier
{
    return [self.songDictionary objectForKey:identifier];
}

@end
