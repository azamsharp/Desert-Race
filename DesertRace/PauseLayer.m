//
//  PauseLayer.m
//  MathFuel
//
//  Created by Mohammad Azam on 8/1/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import "PauseLayer.h"

@implementation PauseLayer

NSString *const BACKGROUND = @"bg_dirt.png";

@synthesize gameLayer; 

+(id) scene 
{
    PauseLayer *pauseLayer = [PauseLayer node];

    CCScene *scene = [CCScene node]; 
    
    [scene addChild:pauseLayer];
    return scene; 
}

-(id) initWithLayer:(CCLayer *)layer
{
    self = [super init]; 
    self.gameLayer = layer; 
    return self; 
}




- (id)init
{
    if((self=[super init]))
    {
        isTouchEnabled_ = YES; 
        screenSize = [[CCDirector sharedDirector] winSize];
        
        CCSprite *background = [CCSprite spriteWithFile:BACKGROUND];

        background.position = ccp(screenSize.width/2, screenSize.height/2); 

        [background setScaleX:0];
        [background setScaleY:0];
    
        id scaleToAction = [CCScaleTo actionWithDuration:0.6 scaleX:1 scaleY:1];
        id callback = [CCCallFuncN actionWithTarget:self selector:@selector(finishedPauseMenu:)]; 
        
        [background runAction:[CCSequence actions:scaleToAction,callback, nil]];
        [self addChild:background]; 
        
    }
 
    return self; 
}

-(void) finishedPauseMenu:(id) sender  
{
    [self setupMenu];
    [[CCDirector sharedDirector] pause];
}

-(void) resumeGame
{    
    [UIAccelerometer sharedAccelerometer].delegate = self.gameLayer; 
    
    [self runAction:[CCScaleTo actionWithDuration:0.6 scaleX:0 scaleY:0]];
    [[CCDirector sharedDirector] resume];
}

-(void) goToHome 
{
    // start the game
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.6 scene:[HomeLayer scene]] ];
    [[CCDirector sharedDirector] resume];

}

-(void) setupMenu
{
    CCMenuItemFont *resumeItem = [CCMenuItemFont itemWithLabel:[CCLabelBMFont labelWithString:@"Resume" fntFile:@"desert_race_menu_font.fnt"] target:self selector:@selector(resumeGame)]; 
    
    CCMenuItemFont *homeItem = [CCMenuItemFont itemWithLabel:[CCLabelBMFont labelWithString:@"Home" fntFile:@"desert_race_menu_font.fnt"] target:self selector:@selector(goToHome)]; 
    
    CCMenu *menu = [CCMenu menuWithItems:resumeItem,homeItem, nil];
    [menu alignItemsVerticallyWithPadding:10];
    menu.position = ccp(screenSize.width/2,screenSize.height/1.9); 
    [self addChild:menu];
}


@end
