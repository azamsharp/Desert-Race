//
//  HelloWorldLayer.m
//  DesertRace
//
//  Created by Mohammad Azam on 5/10/11.
//  Copyright HighOnCoding 2011. All rights reserved.
//



#import "HelloWorldLayer.h"


@implementation HelloWorldLayer

@synthesize tiledMap,car,meta,turboFire,flares;

+(CCScene *) scene
{
    
	CCScene *scene = [CCScene node];
	
	HelloWorldLayer *layer = [HelloWorldLayer node];
    
	[scene addChild: layer];
	
    
	return scene;
}

- (CGPoint)tileCoordForPosition:(CGPoint)position {
    
    int x = position.x / self.tiledMap.tileSize.width;
    
    int y1 = ((self.tiledMap.mapSize.height * self.tiledMap.tileSize.height) - position.y) / self.tiledMap.tileSize.height;
    
    return ccp(x, y1);
}


-(float) randomFloatBetween:(int) smallNumber secondParam:(float) bigNumber
{
    float diff = bigNumber - smallNumber;
    return (((float) rand() / RAND_MAX) * diff)
    + smallNumber;
}

-(void) addFlaresToRoad
{
    [self populateRandomFlares];
    int y = 200; 
    int x = 0; 
    
    for(int i=0;i<[self.flares count]; i++) 
    {
        x  = [self randomFloatBetween:windowSize.width/2 secondParam:windowSize.width/2 + 25];
        
        Flare *flare = [self.flares objectAtIndex:i];
        flare.flareParticle.position = ccp(x, y); 
         [flare.flareParticle runAction:[CCRepeatForever actionWithAction:[CCMoveBy actionWithDuration:0.6 position:ccp(0,-32)]]];
        
        [self addChild:flare.flareParticle z:0];
        
        y += 200;
    }
    
}

-(CCParticleSun *) getFlareByTextureImage:(NSString *)n
{
    CCParticleSun *flare = [[CCParticleSun alloc] init];
    [flare setStartSize:0.3];
    [flare setEndSize:0.3];
    flare.texture = [[CCTextureCache sharedTextureCache] addImage:n];
    [flare runAction:[CCRepeatForever actionWithAction:[CCMoveBy actionWithDuration:0.6 position:ccp(0,-32)]]];

    return flare; 
}



-(void) populateRandomFlares 
{
    for(int i=1;i<=4;i++) 
    {
        randomNumber = arc4random() % 2; 
        if(randomNumber == 0) 
        {
            Flare *flare = [[Flare alloc] init];
            flare.isRed = YES; 
            flare.flareParticle = [self getFlareByTextureImage:@"red.png"];
            [self.flares addObject:flare];
        }
        else 
        {
            Flare *flare = [[Flare alloc] init];
            flare.flareParticle = [self getFlareByTextureImage:@"green.png"];
            [self.flares addObject:flare];
        }
    }

}



-(id) init
{
	if( (self=[super init])) {
		
        isTouchEnabled_  = YES; 
        
        windowSize = [[CCDirector sharedDirector] winSize];
        
        flares = [[NSMutableArray alloc] init];
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        self.tiledMap = [CCTMXTiledMap tiledMapWithTMXFile:@"desert_race_map.tmx"];
        
        self.car = [[Car alloc] initWithSpriteAndLayer:@"car.png" currentLayer:self];
        self.car.sprite.position = ccp(screenSize.width/2,screenSize.height/4); 
        [self addChild:self.car.sprite z:1];
        
        // load the meta layer
        self.meta = [self.tiledMap layerNamed:@"Meta"];
        
        self.meta.visible = NO;
    
        [self addFlaresToRoad];
       // [self addHealthBarToCar];
        
        [self.tiledMap runAction:[CCRepeatForever actionWithAction:[CCMoveBy actionWithDuration:0.6 position:ccp(0,-32)]]];
        
        [self addChild:self.tiledMap z:-1];	
        
       [self schedule: @selector(step:)];
        
        [self schedule:@selector(checkCarCollisionWithFlare:)];
        
    }
    
	return self;
}



-(void) checkCarCollisionWithFlare:(ccTime) dt 
{
    float distance = 0; 
    
    for(int i=0;i<[self.flares count];i++) 
    {
        Flare *flare = [self.flares objectAtIndex:i];
        
        distance = hypotf(self.car.sprite.position.x - flare.flareParticle.position.x , self.car.sprite.position.y - flare.flareParticle.position.y);
        
        if(distance < 25 && flare.isCollided == NO) 
        {
            // now check the kind of flare 
            
            if(flare.isRed) 
            {
                [self.car hit];
                
            }
            else 
            {
                [self.car energize];
            }
            
            flare.isCollided = YES; 
        }
    }
}

-(void) step:(ccTime) dt
{
    
    // add flares to the road 
   // [self addFlaresToRoad];
    
    if(self.tiledMap.position.y < -800) 
    {
        [self.tiledMap setPosition:ccp(0,-32)];
        
        [self.tiledMap runAction:[CCRepeatForever actionWithAction:[CCMoveBy actionWithDuration:0.6 position:ccp(0,-32)]]];
        
    }
    
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    
    CGPoint tileCoord = [self tileCoordForPosition:location];
    
    int tileGid = [self.meta tileGIDAt:tileCoord];
    
    
    NSDictionary *properties = [self.tiledMap propertiesForGID:tileGid];
    
    
    if (properties) {
        NSString *collision = [properties valueForKey:@"Collidable"];
        if (collision && [collision compare:@"False"] == NSOrderedSame) {
        
            
            [self.tiledMap runAction:[CCRepeatForever actionWithAction:[CCMoveBy actionWithDuration:0.6 position:ccp(0,-32)]]];
            
            
            [self.car.sprite runAction:[CCMoveTo actionWithDuration:0.6 position:ccp(location.x,self.car.sprite.position.y)]];
            
        }
    }
    
}


- (void) dealloc
{
    [super dealloc];
}
@end
