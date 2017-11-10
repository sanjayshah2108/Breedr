//
//  DocumentContainerView.m
//  Breeder
//
//  Created by Sanjay Shah on 2017-10-23.
//  Copyright © 2017 Sanjay Shah. All rights reserved.
//

#import "DocumentContainerViewController.h"
#import "Pet.h"
#import "DocumentCollectionViewCell.h"

@implementation DocumentContainerViewController

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)viewDidLoad{
        [super viewDidLoad];
    
    NSMutableArray *documentArray = [[NSMutableArray alloc] init];
    self.documentArray = documentArray;
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DocumentCollectionViewCell *cell = [self.documentCollectionView dequeueReusableCellWithReuseIdentifier:@"documentCollectionCellID" forIndexPath:indexPath];
    
    NSLog(@"index path : %ld", (long)(indexPath.item));
    
    if(self.documentArray.count == 0){
        cell.documentImage.image = [UIImage imageNamed:@"documentPlaceholderImage"];
    }
    else if (indexPath.item < self.documentArray.count){
        cell.documentImage.image = [self.documentArray objectAtIndex:(indexPath.item)];
    }
    
    
    return cell;
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.documentArray.count+1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//method for setting up and managaing the image picker
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //if we choose camera, save the image
    if(self.documentImagePicker.sourceType == UIImagePickerControllerSourceTypeCamera){
        UIImageWriteToSavedPhotosAlbum(pickedImage, nil, nil, nil);
    }
    
    //give our image view the picked image, and dismiss picker
    [self.documentArray addObject:pickedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.documentCollectionView reloadData];
    
}


-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Tapped Cell");

    //if we click on the plus picture
    if ((indexPath.item) + 1 > self.documentArray.count){
        //init a picker
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        

        //use photo library as our source
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //self.documentImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

        //present this picker
        [self presentViewController:picker animated:YES completion:nil];
        //[self presentViewController:self.documentImagePicker animated:YES completion:nil];
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

        self.documentArray[indexPath.item] = [UIImage imageNamed:@"documentPlaceholderImage"];
    }
}

@end
