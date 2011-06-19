//
//  HomeScene.m
//  DesertRace
//
//  Created by Mohammad Azam on 6/9/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import "HomeLayer.h"


@implementation HomeLayer

+(CCScene *) scene
{
    
	CCScene *scene = [CCScene node];
	
	HomeLayer *layer = [HomeLayer node];
    
	[scene addChild: layer];
	
	return scene;
}


-(void) preloadAndPlayMusic
{
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"DesertRace_22050Hz_Loop.wav"];
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"DesertRace_22050Hz_Loop.wav"];
    
}

-(id) init 
{
    if((self=[super init])) {
    
        // preload and play music 
        [self preloadAndPlayMusic];
        
        isTouchEnabled_ = YES; 
        windowSize = [[CCDirector sharedDirector] winSize];
        
        [self schedule:@selector(step:)];
        
        // load the main title 
        
        CCLabelBMFont *title = [CCLabelBMFont labelWithString:@"Desert Race" fntFile:@"desert_race_main_title_font.fnt"];
        title.position = ccp(windowSize.width/2,windowSize.height/1.2);
        [self addChild:title];
        
        
        [self loadMap];
        [self loadMenu];
        [self loadSandStorm];
    
    }
    
    return self; 
}

-(void) step:(ccTime) dt 
{
    if(map.position.y < -800) 
    {
        [map setPosition:ccp(0,-32)];
        
        [map runAction:[CCRepeatForever actionWithAction:[CCMoveBy actionWithDuration:0.6 position:ccp(0,-32)]]];
        
    }
}

-(void) loadMenu 
{
    CCMenuItemFont *playItem = [CCMenuItemFont itemWithLabel:[CCLabelBMFont labelWithString:@"Play" fntFile:@"desert_race_menu_font.fnt"] target:self selector:@selector(play)];
    
    CCMenu *menu = [CCMenu menuWithItems:playItem, nil];
    menu.position = ccp(windowSize.width/2,windowSize.height/2); 
    [menu alignItemsVerticallyWithPadding:10];
    [self addChild:menu];
}

-(void) loadSandStorm
{
    CCParticleFireworks *sandStorm = [[CCParticleFireworks alloc] init];
    sandStorm.position = ccp(windowSize.width/2,windowSize.height); 
    [sandStorm setBlendAdditive:YES];
    [self addChild:sandStorm];
}


-(void) play 
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:2.0 scene:[HelloWorldLayer scene]]];
}


-(void) loadMap 
{
    map = [CCTMXTiledMap tiledMapWithTMXFile:@"desert_race_home_menu_map.tmx"];
    
    [map runAction:[CCRepeatForever actionWithAction:[CCMoveBy actionWithDuration:0.6 position:ccp(0,-32)]]];
    
    [self addChild:map z:-1];
}

@end
