//
//  GalleryDetailViewController.m
//  Eshiksa
//
//  Created by Punit on 05/05/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "GalleryDetailViewController.h"
#import "GalleryDetailsCollectionViewCell.h"
#import "GalleryDetails.h"
#import "Constant.h"
#import "Base.h"
@interface GalleryDetailViewController ()

@end

@implementation GalleryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _galleryArr=[[NSMutableArray alloc]init];
    _imgArr=[[NSMutableArray alloc]init];
    _videoArr=[[NSMutableArray alloc]init];
    
    
    _myCollectionView.delegate=self;
    _myCollectionView.dataSource=self;
    
    [self parsingGallery];
}

-(void)parsingGallery
{
    
    queue=dispatch_queue_create("images", DISPATCH_QUEUE_CONCURRENT);
    queue=dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
    
    [_galleryArr removeAllObjects];
    [_imgArr removeAllObjects];
    [_videoArr removeAllObjects];
    
    //  NSURL * urlstr = [NSURL URLWithString:[mainUrl stringByAppendingString:abc]];
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSLog(@"group name in circular==%@",groupname);
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"circular username ==%@",username);
    
    NSString *password = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"password"];
    NSLog(@"circular password ==%@",password);
    
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    NSLog(@"circular branchid ==%@",branchid);
    
    NSString *cyear = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"cyear"];
    NSLog(@"circular cyear ==%@",cyear);
    
    NSString *orgid = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"orgid"];
    NSLog(@"circular orgid ==%@",orgid);
    
   // NSString *urlstr=@"http://shop.eshiksa.com/appAPI_v2_edemo/gallery.php";
     NSString *urlstr=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:gallery]];
    
 
    NSDictionary *parameterDict = @{
                                    @"groupname":groupname,
                                    @"username":username,
                                    @"password":password,
                                    @"folder_id":_folderIdStr,
                                    @"instUrl":instUrl,
                                    @"dbname":dbname,
                                    @"Branch_id":branchid,
                                    @"org_id":orgid,
                                    @"cyear":cyear,
                                    @"url":urlstr,
                                    @"tag":@"gallery_images"
                                    };
    
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            

            NSArray *ciculararr=[maindic objectForKey:@"gallery"];
            NSLog(@"gallery data:%@",ciculararr);
            
            
            
//            for (imageDic in ciculararr) {
//                
//                images = [imageDic objectForKey:@"images"];
//                
//                NSLog(@"Code Above: %@", images);
//                
//            }
            
            
            /*
             
          
             The problem is you have a NSArray not an NSDictionary. The NSArray has a count of 1 and contains an NSDictionary.
             
             NSArray *wrapper= [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
             NSDictionary *avatars = [wrapper objectAtIndex:0];
             To loop through all items in the array, enumerate the array.
             
             NSArray *avatars= [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
             
             for (NSDictionary *avatar in avatars) {
             NSDictionary *avatarimage = avatar[@"image"];
             NSString *name = avatar[@"name"];
             
             // THE REST OF YOUR CODE
             }
             
             */
            
            NSString *imagesString = [[ciculararr valueForKey:@"images"] componentsJoinedByString:@","];
              NSLog(@"result data:%@",imagesString);
            
            [_imgArr addObject:imagesString];
            
            NSString *videosString = [[ciculararr valueForKey:@"videos"] componentsJoinedByString:@","];
              NSLog(@"videos data:%@",videosString);
            
             [_videoArr addObject:videosString];
            
            
            GalleryDetails *k1=[[GalleryDetails alloc]init];
            k1.imgStr=imagesString;
            k1.videoStr=videosString;
            
            NSLog(@"img str----%@",k1.imgStr);
            
            [_galleryArr addObject:k1];
            
            [_myCollectionView reloadData];
        }
        [_myCollectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
       // [_myCollectionView performSelectorInBackground:@selector(reloadData)  withObject:nil];
    }];
}

     
  /*
    {
        images =     (
                      "http://erp.eshiksa.net/eps/esh/upload/images/gallery/1692.png",
                      "http://erp.eshiksa.net/eps/esh/upload/images/gallery/1693.png",
                      "http://erp.eshiksa.net/eps/esh/upload/images/gallery/1695.png",
                      "http://erp.eshiksa.net/eps/esh/upload/images/gallery/1696.png",
                      "http://erp.eshiksa.net/eps/esh/upload/images/gallery/1697.png",
                      "http://erp.eshiksa.net/eps/esh/upload/images/gallery/1698.png"
                      );
        videos =     (
                      "http://erp.eshiksa.net/eps/esh/upload/videos/VID-20180425-WA0003.mp4"
                      );
    }
   
*/
    

//
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
      NSLog(@"gallery count%lu",(unsigned long)_galleryArr.count);
    return _galleryArr.count;
  
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
   GalleryDetailsCollectionViewCell *cell=[_myCollectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
   GalleryDetails *ktemp=[_galleryArr objectAtIndex:indexPath.row];

    cell.folderid.text=ktemp.folderidStr;
    cell.images.image=[UIImage imageNamed:@"default.png"];
    
    NSString *kImgLink=[_imgArr objectAtIndex:indexPath.row];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:     [NSURL URLWithString:kImgLink]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
        
            cell.images.image = img1;
        });
    });
    cell.video.image=[UIImage imageNamed:@"default.png"];
    
    NSString *kImgLink2=[_videoArr objectAtIndex:indexPath.row];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        UIImage * img2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:kImgLink2]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            cell.video.image = img2;
        });
    });
    
    cell.contentView.layer.cornerRadius = 8.0;
    cell.contentView.layer.borderWidth = 1.0;
    cell.contentView.layer.borderColor =(__bridge CGColorRef _Nullable)([UIColor grayColor]);
    cell.contentView.layer.masksToBounds = true;
    
    
    return  cell;
}




@end
