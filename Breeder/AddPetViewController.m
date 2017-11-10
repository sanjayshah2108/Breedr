//
//  AddPetViewController.m
//  Breeder
//
//  Created by Sanjay Shah on 2017-10-19.
//  Copyright © 2017 Sanjay Shah. All rights reserved.
//

#import "AddPetViewController.h"
#import "Pet.h"
#import "Person.h"
#import "PetImagesCollectionViewLayout.h"
#import "PetImageCollectionViewCell.h"



@interface AddPetViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *petNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *petDOBTextField;
@property (weak, nonatomic) IBOutlet UITextField *petBreedTextField;
@property (weak, nonatomic) IBOutlet UICollectionView *petImagesCollectionView;
@property NSMutableArray<UIImage*> *petImagesArray;
@property (weak, nonatomic) IBOutlet UITextField *petGenderTextField;
@property (weak, nonatomic) IBOutlet UIView *documentsContainerView;
@property NSMutableArray<UIImage*> *petDocumentArray;

@property UIImagePickerController *petImagePicker;



@end

@implementation AddPetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.petNameTextField.delegate = self;
    self.petDOBTextField.delegate = self;
    self.petBreedTextField.delegate = self;
    self.petGenderTextField.delegate = self;
    
    
    if(self.pet){
        self.petImagesArray = self.pet.petImageArray;
        self.petNameTextField.text = self.pet.petName;
        self.petBreedTextField.text = self.pet.petBreed;
        self.petDOBTextField.text = [NSString stringWithFormat:@"%ld", (long)self.pet.petAge];
        self.petGenderTextField.text = self.pet.petGender;
        self.petDocumentArray = self.pet.petDocumentArray;
        
        self.navigationItem.title = self.pet.petName;
        
    }
    else {
        
    }
    
    NSMutableArray *petImagesArray = [[NSMutableArray alloc] init];
    
    self.petImagesArray = petImagesArray;
    
    //create a custom layout object , alloc and init
    //PetImagesCollectionViewLayout *customLayout = [[PetImagesCollectionViewLayout alloc] init];
    //UICollectionViewLayout *defaultLayout = [[UICollectionViewLayout alloc] init];
   // [defaultLayout se setItemSize:CGSizeMake(320, 548)];
    
    
//    UICollectionView *petImagesColelctionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 10, 200, 200) collectionViewLayout:defaultLayout];
    
   // self.petImagesCollectionView = petImagesColelctionView;
    
    
    //assign it to out collection property
   //self.petImagesCollectionView.collectionViewLayout = defaultLayout;

    self.petImagesCollectionView.delegate = self;
    self.petImagesCollectionView.dataSource = self;
    
    
    
    [self.petImagesCollectionView reloadData];

}



//method for setting up and managaing the image picker
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //if we choose camera, save the image
    if(self.petImagePicker.sourceType == UIImagePickerControllerSourceTypeCamera){
        UIImageWriteToSavedPhotosAlbum(pickedImage, nil, nil, nil);
    }
    
    //give our image view the picked image, and dismiss picker
    [self.petImagesArray addObject:pickedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.petImagesCollectionView reloadData];
    
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


//
//RFQuiltLayout* layout = (id)[self.collectionView collectionViewLayout];
//layout.direction = UICollectionViewScrollDirectionVertical;
//layout.blockPixels = CGSizeMake(100, 100);
//}
//
//- (CGSize) blockSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row % 2 == 0)
//        return CGSizeMake(2, 1);
//
//    return CGSizeMake(1, 2);
//}


- (IBAction)addNewPet:(UIBarButtonItem *)sender {
    
    if(!self.pet){

    self.pet = [[Pet alloc] initWithName:self.petNameTextField.text Breed:self.petBreedTextField.text Age:[self.petDOBTextField.text integerValue] ImageArray:self.petImagesArray Gender:self.petGenderTextField.text DocumentArray:self.petDocumentArray];
        
         [self.delegate addPet:self.pet];
    }
    
    else {
    
    self.pet.petName = self.petNameTextField.text;
    self.pet.petBreed = self.petBreedTextField.text;
    self.pet.petAge = [self.petDOBTextField.text integerValue];
    self.pet.petDocumentArray = self.petDocumentArray;
    self.pet.petImageArray = self.petImagesArray;
    self.pet.petGender = self.petGenderTextField.text;
        
    }
    
    
    
    NSLog(@"Passing back the pet With the data");
   
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Collection View

//collection view methods

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PetImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"petImageCollectionCellID" forIndexPath:indexPath];
    
    NSLog(@"index path : %ld", (long)(indexPath.item));
    
    if(self.petImagesArray.count == 0){
        cell.petImageCelllImageView.image = [UIImage imageNamed:@"plusPlaceholder"];
    }
    else if (indexPath.item < self.petImagesArray.count){
         cell.petImageCelllImageView.image = [self.petImagesArray objectAtIndex:(indexPath.item)];
    }
    
   
    return cell;
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    NSInteger petImagesCount = (self.petImagesArray.count+1);
    NSLog(@"Returning %lu cells", petImagesCount );
    return petImagesCount;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Tapped Cell");
    
  //if we click on the plus picture
    if ((indexPath.item) + 1 > self.petImagesArray.count){
        //init a picker
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:nil
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction* cameraButton = [UIAlertAction
                                    actionWithTitle:@"Camera"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //use Camera as our source
                                        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                        //present this picker
                                        [self presentViewController:picker animated:YES completion:nil];
                                    }];
        
        UIAlertAction* photoLibraryButton = [UIAlertAction
                                   actionWithTitle:@"Photo Library"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       
                                       //use photo library as our source
                                       picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                       //present this picker
                                       [self presentViewController:picker animated:YES completion:nil];
                                      
                                   }];
        UIAlertAction* cancelButton = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction * action) {
                                           //Handle your yes please button action here
                                       }];
        
        [alert addAction:cameraButton];
        [alert addAction:photoLibraryButton];
        [alert addAction:cancelButton];

        [self presentViewController:alert animated:true completion:nil];
    }
    
    //else if we click on an image
    else {
    
        //we can prompt here if user wants to view or to change
        NSLog(@"Change Image or View?");
        
        //init a picker
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        
        //use camera as our source
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        //present this picker
        [self presentViewController:picker animated:YES completion:nil];
        
        //////this shouldnt run everytime we move the view
        
        self.petImagesArray[indexPath.item] = [UIImage imageNamed:@"plusPlaceholder"];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
