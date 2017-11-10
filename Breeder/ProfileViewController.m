//
//  ProfileViewController.m
//  Breeder
//
//  Created by Sanjay Shah on 2017-10-19.
//  Copyright © 2017 Sanjay Shah. All rights reserved.
//

#import "ProfileViewController.h"
#import "AddPetViewController.h"
#import "Person.h"
#import "ProfilePetTableViewCell.h"

@interface ProfileViewController ()<AddPetViewControllerDelegate, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *petTableView;
@property (weak, nonatomic) IBOutlet UILabel *personNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *personLocationLabel;

@property (weak, nonatomic) IBOutlet UIImageView *personProfileImageView;
@property Person *currentPerson;

@property UIImagePickerController *profileImagePicker;

@property (weak, nonatomic) IBOutlet UIButton *addPetButton;


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    //only have 1 user right now
    self.currentPerson = [[Person alloc] init];
    self.currentPerson.name = [NSString stringWithFormat:@"Sanjay Shah"];
    self.currentPerson.address = [NSString stringWithFormat:@"Vancouver"];
    self.personNameLabel.text = self.currentPerson.name;
    self.personLocationLabel.text = self.currentPerson.address;
    self.currentPerson.petsArray = [[NSMutableArray alloc] init];
    
    //assign this profilViewController as a tableViewDelegate
    self.petTableView.delegate = self;
    self.petTableView.dataSource = self;
    
    
    CALayer * addPetButtonLayer =self.addPetButton.layer;
    addPetButtonLayer.cornerRadius = 5;
    
    
    
    
 
    
}

- (IBAction)addPetButton:(UIButton *)sender {
    [self performSegueWithIdentifier:@"addPetSegue" sender:sender];
}


//need an image picker here and a tap gesture recognizer.
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//
    
    //if we choose camera, save the image
    if(self.profileImagePicker.sourceType == UIImagePickerControllerSourceTypeCamera){
        UIImageWriteToSavedPhotosAlbum(pickedImage, nil, nil, nil);
    }
    
    //give our image view the picked image, and dismiss picker
    self.personProfileImageView.image = pickedImage;
    [self dismissViewControllerAnimated:YES completion:nil];
}


//tap gesture recognizer

- (IBAction)tappedProfileImage:(UITapGestureRecognizer *)sender {
     NSLog(@"Tapped ProfPic");

        NSLog(@"Change Image");
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIAlertController *alertController= [UIAlertController alertControllerWithTitle:@"Error" message:@"Device has no camera." preferredStyle:UIAlertControllerStyleAlert];
        

            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                              handler:nil]];
            
           UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                                                                handler:nil];
                                                 [alertController addAction: cancel];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else{
        
        
        UIImagePickerController *profileImagePicker = [[UIImagePickerController alloc] init];
        
        profileImagePicker.delegate = self;
        profileImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:profileImagePicker animated:YES completion:nil];
        
        
        
        //prompt to ask whether to view or to change.
        //right now just leave it null
        
    }
}




-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"addPetSegue"]){
        
        //initiate addPetViewController and assign this profileViewController as a delegate
        
        AddPetViewController *addPetVC = [segue destinationViewController];
        addPetVC.delegate = self;
        
    }
    
    if ([segue.identifier isEqualToString:@"editPetSegue"]){
        
        //initiate addPetViewController and assign this profileViewController as a delegate

        NSIndexPath *indexPath = self.petTableView.indexPathForSelectedRow;
        
        Pet *selectedPet = self.currentPerson.petsArray[indexPath.row];
        
        AddPetViewController *editPetViewController = [segue destinationViewController];
        editPetViewController.delegate = self;
        
        editPetViewController.pet = selectedPet;
        
        
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addPet:(Pet*) pet {
    [self.currentPerson.petsArray addObject:pet];
    
    NSLog(@"%@", self.currentPerson.petsArray);
    NSLog(@"Adding Pet to array");
    //return pet;
}

-(void) viewWillAppear:(BOOL)animated{
    [self.petTableView reloadData];
    NSLog(@"%@", self.currentPerson.petsArray);
}

//- (void)addPet:(NSString*) name {
//    self.petNameLabel.text = name;
//}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ProfilePetTableViewCell *cell = [self.petTableView dequeueReusableCellWithIdentifier:@"myPetID" forIndexPath:indexPath];
    cell.petNameLabel.text = [self.currentPerson.petsArray objectAtIndex:indexPath.row].petName;
    
    if([self.currentPerson.petsArray objectAtIndex:indexPath.row].petImageArray.count ==0){
        cell.petImageView.image = [UIImage imageNamed:@"placeholderPetImage"];
    }
    else {
        cell.petImageView.image = [self.currentPerson.petsArray objectAtIndex:indexPath.row].petImageArray[0];
    }
    
    cell.petImageView.layer.cornerRadius = 2;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currentPerson.petsArray.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"editPetSegue" sender:self];

    
}

@end
