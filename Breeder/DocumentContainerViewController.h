#import <UIKit/UIKit.h>

@interface DocumentContainerViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate>



@property (weak, nonatomic) IBOutlet UICollectionView *documentCollectionView;

@property NSMutableArray<UIImage*> *documentArray;

@property UIImagePickerController *documentImagePicker;


@end
