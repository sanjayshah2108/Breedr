//
//  AddPetViewController.h
//  Breeder
//
//  Created by Sanjay Shah on 2017-10-19.
//  Copyright © 2017 Sanjay Shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pet.h"


@class AddPetViewController;

@protocol AddPetViewControllerDelegate<NSObject>


-(void)addPet:(Pet*) pet;

@end




@interface AddPetViewController : UIViewController

@property (nonatomic, weak) id <AddPetViewControllerDelegate> delegate;

@end
