//
//  Pet.m
//  Breeder
//
//  Created by Sanjay Shah on 2017-10-17.
//  Copyright © 2017 Sanjay Shah. All rights reserved.
//

#import "Pet.h"

@implementation Pet

-(instancetype) initWithName:(NSString*) name Breed:(NSString*) breed Age:(NSInteger) age ImageArray:(NSMutableArray*) imageArray Gender:(NSString*) gender{
    
    self = [super init];
    
    if (self)
    {
        _petName = name;
        _petBreed = breed;
        _petAge = age;
        _petImageArray = imageArray;
        _petGender = gender;
        
    }
    return  self;
    
}

@end
