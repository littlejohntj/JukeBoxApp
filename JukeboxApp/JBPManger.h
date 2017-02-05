//
//  JBPManger.h
//  JukeboxApp
//
//  Created by Todd Littlejohn on 2/3/17.
//  Copyright © 2017 TKC. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "JBPSpotifyServiceManager.h"

@interface JBPManger : NSObject

@property (nonatomic, strong) JBPSpotifyServiceManager* spotifyManager;

+ (JBPManger*)sharedInstance;
- (id)init;
- (void)setUpServices;

@end
