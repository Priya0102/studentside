

#import "CircularDetailsViewController.h"
#import "Constant.h"
#import "CircularDetails.h"
#import "WebViewController.h"
#import "FileDownloader.h"
#import "WebViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BaseViewController.h"
#import "Base.h"
@interface CircularDetailsViewController ()
- (void)downloadingStarted;
- (void)downloadingFinishedFor:(NSURL *)url andData:(NSData *)data;
- (void)downloadingFailed:(NSURL *)url;

@end

@implementation CircularDetailsViewController
@synthesize attachmentTxt;

- (void)viewDidLoad {
    [super viewDidLoad];
    _attachmentBtn.layer.masksToBounds=YES;
    _attachmentBtn.layer.cornerRadius=8.0;
    
    self.titleCircular.text=self.titleStr;
    self.circularId.text=self.circularIdStr;
    
    NSLog(@"circular id==%@ title circular==%@",_circularIdStr,_titleStr);
    
    [self getCircularDetails];
}
-(void)getCircularDetails{
    
    NSString *groupname = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"groupName"];
    NSLog(@"group name in circular details==%@",groupname);
    
    NSString *username = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"username"];
    NSLog(@"circular details username ==%@",username);
    
    NSString *branchid = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"branchid"];
    NSLog(@"circular details branchid ==%@",branchid);

    
    //NSString *urlstr=[NSString stringWithFormat:@"http://shop.eshiksa.com/appAPI_v2_edemo/newcircular.php"];
    
      NSString *urlstr=[NSString stringWithFormat:@"%@",[mainUrl stringByAppendingString:newcircular]];
    
    NSDictionary *parameterDict =
    @{ @"groupname":groupname,
       @"username": username,
       @"dbname":dbname,
       @"Branch_id":branchid,
       @"instUrl":instUrl,
       @"tag": @"circulardetail",
       @"circularId":self.circularId.text,
    };
    
    NSLog(@"parameter dict%@",parameterDict);
    
    [Constant executequery:urlstr strpremeter:parameterDict withblock:^(NSData * dbdata, NSError *error) {
        NSLog(@"data:%@",dbdata);
        if (dbdata!=nil) {
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:dbdata options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"response circular details data:%@",maindic);
            
            NSDictionary *dic=[maindic objectForKey:@"circulardetail"];
            CircularDetails *c=[[CircularDetails alloc]init];
            c.circularDetailStr=[dic objectForKey:@"discription"];
            c.circularIdStr=[dic objectForKey:@"title"];
            c.circularTitleStr=[dic objectForKey:@"id"];
            c.cirFlieStr=[dic objectForKey:@"cir_file"];
    
             _descriptionCircular.text=c.circularDetailStr;
            _cir_file.text=c.cirFlieStr;
            
            NSLog(@"circular details ==%@ circular file path ==%@",c.circularDetailStr,c.cirFlieStr);
            
        }
    }];
    
}
- (IBAction)attachmentBtnClicked:(id)sender {
    
   NSLog(@"attachment Btn clicked");
   // [self downloadingStarted];
    
    
    UIImage *myImage = [UIImage imageNamed:@"dot1.png"];
    
    UIImageWriteToSavedPhotosAlbum(myImage, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    //UIImageWriteToSavedPhotosAlbum([UIImage imageNamed:@"dot1.png"], nil, nil, nil);
 
//    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageUrl] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
//        
//        if (image && finished) {
//            // Cache image to disk or memory
//            [[SDImageCache sharedImageCache] storeImage:image forKey:CUSTOM_KEY toDisk:YES];
//        }
//    }];
//    
    
    
   /*  NSString *path;
//    path = [@"/var/mobile/Documents/" stringByAppendingPathComponent:@"myFolder"];
    
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [dir stringByAppendingPathComponent:@"Eshiksa_app"];

        [self getCircularDetails];
    
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])    //Does directory already exist?
        NSLog(@"path%@",path);
    {
        if (![[NSFileManager defaultManager] createDirectoryAtPath:path
                                       withIntermediateDirectories:NO
                                                        attributes:nil
                                                             error:&error])
        {
            NSLog(@"Create directory error: %@", error);
        }
    }
    
   */
    
  /* NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://a3.twimg.com/profile_images/414797877/05052008321_bigger.jpg"]];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *localFilePath = [documentsDirectory stringByAppendingPathComponent:@"pkm.jpg"];
    NSData *thedata = NULL;
    [thedata writeToFile:localFilePath atomically:YES];
    
    UIImage *img = [[UIImage alloc] initWithData:thedata];
    */
    
}
-(void) downloadImageFromURL :(NSString *)imageUrl{
    
//    NSString *stringURL = @"http://www.somewhere.com/thefile.png";
//    NSURL  *url = [NSURL URLWithString:stringURL];
//   

    NSURL  *url = [NSURL URLWithString:imageUrl];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    if ( urlData )
    {
        NSLog(@"Downloading started...");
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"dwnld_image.png"];
        NSLog(@"FILE : %@",filePath);
        [urlData writeToFile:filePath atomically:YES];
        UIImage *image1=[UIImage imageWithContentsOfFile:filePath];
        //imageView.image=image1;
        NSLog(@"Completed...");
    }
    
}
-(IBAction) downloadButtonPressed:(id)sender;{
    //download the file in a seperate thread.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"Downloading Started");
        NSString *urlToDownload = @"http://www.somewhere.com/thefile.png";
        NSURL  *url = [NSURL URLWithString:urlToDownload];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        if ( urlData )
        {
            NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString  *documentsDirectory = [paths objectAtIndex:0];
            
            NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"filename.png"];
            
            //saving is done on main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                [urlData writeToFile:filePath atomically:YES];
                NSLog(@"File Saved !");
            });
        }
        
    });
    
}
// And if you wish add this selector method in code;

- (void) image:(UIImage*)image didFinishSavingWithError:(NSError *)error contextInfo:(NSDictionary*)info{
    
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Success" message:@"Image is saved to photo library." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alertView dismissViewControllerAnimated:YES completion:nil];
                         }];
    [alertView addAction:ok];
    [self presentViewController:alertView animated:YES completion:nil];
    
    NSLog(@"there is a error..");
}

- (void)downloadingStarted{
     NSLog(@"downloading started...");
    
    FileDownloader *objDownloader = [[FileDownloader alloc] init];
    [objDownloader setDelegate:self];
    [objDownloader downloadFromURL:@"http://erp.eshiksa.net/edemo_fees/esh/reports/Circular/Notice/_Logo 1.jpg"];
    
    
    // Get the PDF Data from the url in a NSData Object
   NSData *pdfData = [[NSData alloc] initWithContentsOfURL:[
                                                             NSURL URLWithString:@"http://erp.eshiksa.net/edemo_fees/esh/reports/Circular/Notice/_Logo 1.jpg"]];
    
    // Store the Data locally as PDF File
    NSString *resourceDocPath = [[NSString alloc] initWithString:[
                                                                  [[[NSBundle mainBundle] resourcePath] stringByDeletingLastPathComponent]
                                                                  stringByAppendingPathComponent:@"Documents"
                                                                  ]];
    
    NSString *filePath = [resourceDocPath
                          stringByAppendingPathComponent:@"myPDF.jpg"];
    [pdfData writeToFile:filePath atomically:YES];
    
 
    
    
    // Now create Request for the file that was saved in your documents folder
  /*  NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    UIWebView *webView=[[UIWebView alloc]init];
    
    [webView setUserInteractionEnabled:YES];
    [webView setDelegate:self];
    [webView loadRequest:requestObj];
    
   NSData *dataPdf = [[NSData alloc] initWithContentsOfURL:[
                                                             NSURL URLWithString:@"http://erp.eshiksa.net/edemo_fees/esh/reports/Circular/Notice/_Logo 1.jpg"]];
   
   //Get path directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //  After you downloaded the PDF into a NSData, write it to the Documents path
    
        NSString *documentsDirectory = [paths objectAtIndex:0];// Get documents folder
  
    //Create PDF_Documents directory
   documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"yourFilename"];
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"Eshiksa_app"];
    
   [dataPdf writeToFile:filePath atomically:YES];
    
 */

}
- (void)downloadingFinishedFor:(NSURL *)url andData:(NSData *)data{
    NSLog(@"downloading finished...");
    
}
- (void)downloadingFailed:(NSURL *)url{
     NSLog(@"downloading failed...");
}
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    WebViewController *wvc=[segue destinationViewController];
//    if ([segue.identifier isEqualToString:@"showAttachment"]) {
//        wvc.myURL=_cir_file.text;
//        NSLog(@"URL PATH%@",_cir_file.text);
//    }
//}
- (void)viewWillAppear:(BOOL)animated {
    [super awakeFromNib];
    
    attachmentTxt.text = [@"ATTACHMENT" localize];


    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"notificationName" object:nil];
}

-(void)changeLanguage:(NSNotification*)notification
{
    attachmentTxt.text = [@"ATTACHMENT" localize];
    
}


@end
