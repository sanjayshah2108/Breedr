//
//  Pet.h
//  Breeder
//
//  Created by Sanjay Shah on 2017-10-17.
//  Copyright © 2017 Sanjay Shah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Baby.h"
#import "Litter.h"

@interface Pet : NSObject

@property NSString* petName;
@property NSString* petBreed;
@property NSInteger petAge;
@property NSMutableArray *petImageArray;
@property NSString* petGender;
@property NSMutableArray *petDocumentArray;

//@property (weak) NSMutableArray<Litter*> * previousLittersArray;


-(instancetype) initWithName:(NSString*) name Breed:(NSString*) breed Age:(NSInteger) age ImageArray:(NSMutableArray*) imageArray Gender:(NSString*) gender DocumentArray:(NSMutableArray*) documentArray;


@end
