//
//  HelloWorldLayer.h
//  DesertRace
//
//  Created by Mohammad Azam on 5/10/11.
//  Copyright HighOnCoding 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Flare.h"
#import "HealthBar.h"
#import "Car.h"
#import "PauseLayer.h" 


// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    CCTMXTiledMap *tiledMap;
    CCTMXLayer *meta; 
    Car *car; 
    CCParticleSun *turboFire; 
    HealthBar *healthBar;
    CCParticleSun *greenFlare; 
    CCParticleSun *redFlare; 
    NSMutableArray *flares; 
    int randomNumber; 
    CGSize windowSize; 
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
-(void) addFlaresToRoad:(ccTime) dt; 
-(void) addHealthBarToCar; 
-(void) populateRandomFlares; 
-(CCParticleSun *) getFlareByTextureImage:(NSString *) n; 
-(void) pauseGame; 


@property (nonatomic,retain) CCTMXTiledMap *tiledMap;
@property (nonatomic,retain) Car *car; 
@property (nonatomic,retain) CCTMXLayer *meta; 
@property (nonatomic,retain) CCParticleSun *turboFire; 
@property (nonatomic,retain) NSMutableArray *flares; 

@end
