#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HealthBar : NSObject {
    
    //  CCSprite *sprite; 
    CCProgressTimer *progressTimer; 
}


-(id) initWithProgressTimerSprite:(NSString *) img;  

-(void) update;

@property (nonatomic,retain) CCSprite *sprite;
@property (nonatomic,retain) CCProgressTimer *progressTimer;

@end