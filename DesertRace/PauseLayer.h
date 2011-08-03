//
//  PauseLayer.h
//  MathFuel
//
//  Created by Mohammad Azam on 8/1/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h" 
#import "SimpleAudioEngine.h" 
#import "HomeLayer.h" 


@interface PauseLayer : CCLayer 
{
    CGSize screenSize; 
    CCLayer *gameLayer; 
}

+(id) scene; 

-(id) initWithLayer:(CCLayer *) layer; 
-(void) setupMenu; 

@property (nonatomic,retain) CCLayer *gameLayer; 

@end
