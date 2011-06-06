//
//  Flare.h
//  DesertRace
//
//  Created by Mohammad Azam on 6/4/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Flare : NSObject {
   
    CCParticleSun *flareParticle; 
    BOOL isCollided; 
    BOOL isRed; 
}

-(id) initWithSpriteImage:(NSString *) img; 


@property (nonatomic,retain) CCParticleSun *flareParticle; 
@property (nonatomic,assign) BOOL isCollided; 
@property (nonatomic,assign) BOOL isRed; 


@end
