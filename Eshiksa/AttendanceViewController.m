//
//  AttendanceViewController.m
//  Eshiksa
//
//  Created by Punit on 20/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "AttendanceViewController.h"
#import "NIDropDown.h"
#import <QuartzCore/QuartzCore.h>
#define IDIOM UI_USER_INTERFACE_IDIOM()
#define IPAD UIUserInterfaceIdiomPad
@interface AttendanceViewController ()

{
    NSMutableArray *eventArray;
    
    NSUserDefaults *defaults;
    
    NSString *str;
}
@property (nonatomic, readonly) CGFloat offset;

@end

@implementation AttendanceViewController{
    
    float fadeAlpha;
    NSMutableArray *keyarr1;
}
@synthesize message;
@synthesize cityBtnSelect;
@synthesize eventBtnSelect;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _venueLbl.layer.borderWidth = 1;
    _venueLbl.layer.cornerRadius = 5;
    _venueLbl.clipsToBounds = YES;
    
       keyarr1= [[NSMutableArray alloc]init];
   // [self.venueBtn addTarget:self action:@selector(venueBtnClicked:) forControlEvents:UIControlEventTouchDown];
    
    fadeAlpha = 0.5f;
    courseBtnSelect.layer.borderWidth = 1;
    courseBtnSelect.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    courseBtnSelect.layer.cornerRadius = 5;
    
    batchBtnSelect.layer.borderWidth = 1;
    batchBtnSelect.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    batchBtnSelect.layer.cornerRadius = 5;
    
    sectionBtnSelect.layer.borderWidth = 1;
    sectionBtnSelect.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    sectionBtnSelect.layer.cornerRadius = 5;
    
    subjectBtnSelect.layer.borderWidth = 1;
    subjectBtnSelect.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    subjectBtnSelect.layer.cornerRadius = 5;
    
    
    self.navigationItem.hidesBackButton = NO;
    //  [self setupScrollView:self.scroll];
    
    self.navigationItem.backBarButtonItem.title=@"Back";
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    
}
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.currentViewController = self.childViewControllers.firstObject;
}
- (void)viewDidUnload {
    
    eventBtnSelect=nil;
    [self setEventBtnSelect:nil];
    [super viewDidUnload];
}
-(IBAction)courseselectClicked:(id)sender {
    
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"PRE SCH",@"PRE PRI",@"CLASS I",@"CLASS II",@"CLASS III",@"CLASS IV",@"CLASS V",@"CLASS VI",@"CLASS VII",@"CLASS VIII",@"CLASS IX",@"CLASS X",nil];
    NSArray * arrImage = [[NSArray alloc] init];
    
    if(dropDown1 == nil) {
        CGFloat f = 140;
        dropDown1 = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
        
        dropDown1.delegate = self;
    }
    else {
        [dropDown1 hideDropDown:sender];
        [self rel];
    }
    
}
-(IBAction)batchName:(id)sender {
    
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"2016-2017",@"2017-2018",@"2018-2019",nil];
    NSArray * arrImage = [[NSArray alloc] init];
    
    if(dropDown2 == nil) {
        CGFloat f = 80;
        dropDown2 = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
        
        dropDown2.delegate = self;
    }
    else {
        [dropDown2 hideDropDown:sender];
        [self rel];
    }
    
}
-(IBAction)sectionName:(id)sender {
    
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",nil];
    NSArray * arrImage = [[NSArray alloc] init];
    
    if(dropDown3 == nil) {
        CGFloat f = 80;
        dropDown3 = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
        
        dropDown3.delegate = self;
    }
    else {
        [dropDown3 hideDropDown:sender];
        [self rel];
    }
    
}
-(IBAction)subjectName:(id)sender {
    
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"English",@"Hindi",@"Marathi",@"Science",@"Social Science",@"History",@"Geography",@"Economics",nil];
    
    NSArray * arrImage = [[NSArray alloc] init];
    
    if(dropDown4 == nil) {
        CGFloat f = 80;
        dropDown4 = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
        
        dropDown4.delegate = self;
    }
    else {
        [dropDown4 hideDropDown:sender];
        [self rel];
    }
    
}
/*-(IBAction)eventselectClicked:(id)sender {
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:@"http://localhost/phpmyadmin/MMF/get_events.php"];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task=[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                {
                                    
                                    if(data==nil)
                                    {
                                        NSLog(@"Data is nil");
                                    }
                                    else
                                    {
                                        NSLog(@"%@",response);
                                        NSDictionary *outerdic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                        keyarr1= [[NSMutableArray alloc]init];
                                        
                                        NSArray *keyarr= (NSArray*)[outerdic objectForKey:@"events"];
                                        
                                        NSUInteger count=[keyarr count];
                                        NSUInteger i=0;
                                        
                                        for(NSDictionary *temp in keyarr)
                                        {
                                            NSString *str1=[temp objectForKey:@"event_name"];
                                            NSString *str2=[temp objectForKey:@"event_type_id"];
                                            NSString *str3=[temp objectForKey:@"other_events"];
                                            
                                            if(count>i)
                                            {
                                                [keyarr1 addObject:str1];
                                                
                                                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                                    _eventname.text=_eventNamestr;
                                                    _eventtypeid.text=_event_idstr;
                                                    _other_events.text=_other_eventsstr;
                                                    
                                                    NSLog(@"****Event name==%@  Event type id==%@ Other_events==%@",str1,str2,str3);
                                                    
                                                    
                                                }];
                                                
                                                NSString *test=[keyarr1 objectAtIndex:i];
                                                
                                                NSLog(@"Area====%@",test);
                                            }
                                            i++;
                                        }
                                        NSArray * arrImage = [[NSArray alloc] init];
                                        
                                        if(dropDown2 == nil) {
                                            CGFloat f = 20000;
                                            dropDown2 = [[NIDropDown alloc]showDropDown:sender :&f :keyarr1 :arrImage :@"down"];
                                            
                                            dropDown2.delegate = self;
                                        }
                                        else {
                                            [dropDown2 hideDropDown:sender];
                                            [self rel];
                                        }
                                    }
                                    
                                }];
    
    
    [task resume];
    
}
*/


- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
    
//    self.cityName=cityBtnSelect.titleLabel.text;
//    self.eventname=eventBtnSelect.titleLabel.text;
//    
//    NSLog(@"city==%@", cityBtnSelect.titleLabel.text);
//    
//    NSLog(@"event====%@",eventBtnSelect.titleLabel.text);
//    
//    [[NSUserDefaults standardUserDefaults]setValue:eventBtnSelect.titleLabel.text forKey:@"eventName"];
//    NSLog(@"Event-Name== %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"eventName"]);
//    
//    
//    [[NSUserDefaults standardUserDefaults]setValue:cityBtnSelect.titleLabel.text forKey:@"city"];
//    NSLog(@"City== %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"city"]);
    
}

-(void)rel{
    //[dropDown1 release];
    //    dropDown2 = nil;
    //    dropDown1=nil;
    
}

- (IBAction)fetchStudentBtnClicked:(id)sender {
    
    //NSLog(@"Venue Button Clicked==%@",_venueBtn);
    
    if (dropDown1==nil) {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Please select course fields before going further" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alertView dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alertView addAction:ok];
        [self presentViewController:alertView animated:YES completion:nil];
        
    }
    if (dropDown2==nil) {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:@"Please select batch fields before going further" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alertView dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alertView addAction:ok];
        [self presentViewController:alertView animated:YES completion:nil];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
