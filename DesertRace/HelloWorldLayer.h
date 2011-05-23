//
//  HelloWorldLayer.h
//  DesertRace
//
//  Created by Mohammad Azam on 5/10/11.
//  Copyright HighOnCoding 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    CCTMXTiledMap *tiledMap;
    CCTMXLayer *meta; 
    CCSprite *car; 
    float y; 
    CCParticleSun *turboFire; 
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@property (nonatomic,retain) CCTMXTiledMap *tiledMap;
@property (nonatomic,retain) CCSprite *car; 
@property (nonatomic,retain) CCTMXLayer *meta; 
@property (nonatomic,retain) CCParticleSun *turboFire; 
@property (nonatomic,assign) float y; 

@end
