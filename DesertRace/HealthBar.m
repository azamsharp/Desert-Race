//
//  HealthBar.m
//  MathCar
//
//  Created by Mohammad Azam on 5/24/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import "HealthBar.h"


@implementation HealthBar

@synthesize sprite,progressTimer; 

-(id) initWithProgressTimerSprite:(NSString *)img
{
    self = [super init]; 

    self.progressTimer = [CCProgressTimer progressWithFile:img];
    self.progressTimer.type = kCCProgressTimerTypeHorizontalBarLR;
    self.progressTimer.percentage = 100;
    
    
    return self; 
}

-(void) update
{
    
}

@end
