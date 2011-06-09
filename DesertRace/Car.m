//
//  Car.m
//  MathCar
//
//  Created by Mohammad Azam on 5/16/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import "Car.h"


@implementation Car

#define _100_PERCENT 100

@synthesize sprite,currentHealth,maxHealth,layer,speed,drainAmount; 

-(id) initWithSpriteAndLayer:(NSString *) img currentLayer:(CCLayer *)l 
{
    self = [super init]; 
    
    self.sprite = [CCSprite spriteWithFile:img];
    self.layer = l;
    self.maxHealth = 100; 
    self.currentHealth = self.maxHealth; // start with max health 
    self.drainAmount = 0; 
    // attach the health bar 
    healthBar = [[HealthBar alloc] initWithProgressTimerSprite:@"green_health_bar.png"];
    healthBar.progressTimer.position = ccp(self.sprite.contentSize.width/2,-5);
    [self.sprite addChild:healthBar.progressTimer z:1];
    
    return self; 
}

-(void) drainFuel
{
    self.currentHealth -= drainAmount; 
    
    if(self.currentHealth < 25) 
    {
        [healthBar.progressTimer setSprite:[CCSprite spriteWithFile:@"red_health_bar.png"]];
    }
    else 
    {
        [healthBar.progressTimer setSprite:[CCSprite spriteWithFile:@"green_health_bar.png"]];
    }
    
    [healthBar.progressTimer setPercentage:_100_PERCENT * (self.currentHealth/self.maxHealth)];
}

-(void) hit
{

    self.currentHealth -= 25; 
    
    
    if(self.currentHealth <= 25) 
    {
        [healthBar.progressTimer setSprite:[CCSprite spriteWithFile:@"red_health_bar.png"]];
        
        [self enableSmoke];
        
    }
    
    [healthBar.progressTimer setPercentage:_100_PERCENT * (self.currentHealth/self.maxHealth)];
}

-(void) destroy 
{
    CCParticleFire *fire = [[CCParticleFire alloc] init];
    [fire setAutoRemoveOnFinish:YES];
    [fire setTotalParticles:70];
    fire.position = self.sprite.position; 
    [self.layer addChild:fire z:1];
    
    }

-(void) enableSmoke 
{
    CCParticleSmoke *smoke = [[CCParticleSmoke alloc] init];
    [smoke setAutoRemoveOnFinish:YES]; 
    [smoke setScaleX:0.8];
    [smoke setStartSize:10];
    [smoke setEndSize:10];
    [smoke setGravity:ccp(0,-90)];
    [smoke setTotalParticles:50];
    smoke.position = ccp(self.sprite.contentSize.width/2,0);
    [self.sprite addChild:smoke];
}

-(void) applyEnergizeEffect 
{
    CCParticleExplosion *meteor = [[CCParticleExplosion alloc] init];
    [meteor setAutoRemoveOnFinish:YES];
    [meteor setTotalParticles:200];
    
    [meteor setStartSize:2];
    [meteor setEndSize:2];
    
    [meteor setDuration:3];
    meteor.position = self.sprite.position;
    
    [self.layer addChild:meteor];
    
}

-(void) energize 
{
    if(self.currentHealth < _100_PERCENT) 
    {
        [self applyEnergizeEffect];
        
        self.currentHealth += 25; 
        
        if(self.currentHealth > 25) 
        {
            [healthBar.progressTimer setSprite:[CCSprite spriteWithFile:@"green_health_bar.png"]];
        }
        
        [healthBar.progressTimer setPercentage:_100_PERCENT * (self.currentHealth/self.maxHealth)];
    }
}




@end
