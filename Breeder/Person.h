//
//  Person.h
//  Breeder
//
//  Created by Sanjay Shah on 2017-10-17.
//  Copyright © 2017 Sanjay Shah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pet.h"

@interface Person : NSObject

@property NSString* name;
@property NSString* address;

@property NSMutableArray<Pet*> *petsArray;



@end
