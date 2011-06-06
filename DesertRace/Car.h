//
//  Car.h
//  MathCar
//
//  Created by Mohammad Azam on 5/16/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h" 
#import "HealthBar.h"

@interface Car : NSObject {
    
    CCSprite *sprite; 
    float currentHealth; 
    float maxHealth;
    HealthBar *healthBar;
    CCLayer *layer; 
    int speed; 
    float drainAmount; 
    
}

-(id) initWithSpriteAndLayer:(NSString *) img currentLayer:(CCLayer *) l; 
-(void) hit; 
-(void) energize; 
-(void) drainFuel;
-(void) enableSmoke; 
-(void) destroy; 

@property (nonatomic,retain) CCSprite *sprite; 
@property (nonatomic,assign) float currentHealth; 
@property (nonatomic,assign) float maxHealth;
@property (nonatomic,retain) CCLayer *layer; 
@property (nonatomic,assign) int speed; 
@property (nonatomic,assign) float drainAmount;

@end
