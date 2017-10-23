//
//  Litter.h
//  Breeder
//
//  Created by Sanjay Shah on 2017-10-19.
//  Copyright © 2017 Sanjay Shah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Baby.h"
#import "Pet.h"

@interface Litter : NSObject

@property NSMutableArray <Baby*> *babiesArray;
@property NSDate *dateBorn;

//@property (weak) Pet *father;
//@property (weak) Pet *mother;

@end
