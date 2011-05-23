//
//  HelloWorldLayer.m
//  DesertRace
//
//  Created by Mohammad Azam on 5/10/11.
//  Copyright HighOnCoding 2011. All rights reserved.
//



#import "HelloWorldLayer.h"


@implementation HelloWorldLayer

@synthesize tiledMap,car,meta,turboFire,y;

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

-(id) init
{
	if( (self=[super init])) {
		
        isTouchEnabled_  = YES; 
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        self.tiledMap = [CCTMXTiledMap tiledMapWithTMXFile:@"desert_race_map.tmx"];
        
        self.car = [CCSprite spriteWithFile:@"car.png"];
        self.car.position = ccp(screenSize.width/2,screenSize.height/4); 
        [self addChild:self.car];
        
        // load the meta layer
        self.meta = [self.tiledMap layerNamed:@"Meta"];
        
        self.meta.visible = NO;
    
        
        [self.tiledMap runAction:[CCRepeatForever actionWithAction:[CCMoveBy actionWithDuration:0.6 position:ccp(0,-32)]]];
        
        [self addChild:self.tiledMap z:-1];	
        
       [self schedule: @selector(step:)];
        
    }
    
	return self;
}

-(void) step:(ccTime) dt
{
    
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
            
            
            [self.car runAction:[CCMoveTo actionWithDuration:0.6 position:ccp(location.x,self.car.position.y)]];
            
        }
    }
    
}


- (void) dealloc
{
    [super dealloc];
}
@end
