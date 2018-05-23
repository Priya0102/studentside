//
//  TeacherViewController.m
//  Eshiksa
//
//  Created by Punit on 19/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "TeacherViewController.h"

@interface TeacherViewController ()

@end

@implementation TeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.profileImg.layer.cornerRadius = self.profileImg.frame.size.width / 2;
    self.profileImg.clipsToBounds = YES;
    //    self.profileImg.layer.borderWidth = 1.0f;
    //    self.profileImg.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.profileBtn.layer.cornerRadius=6.0f;
    
    self.galleryImg.layer.cornerRadius = self.galleryImg.frame.size.width / 2;
    self.galleryImg.clipsToBounds = YES;
    self.galleryBtn.layer.cornerRadius=6.0f;
    
    
    self.timetableImg.layer.cornerRadius = self.timetableImg.frame.size.width / 2;
    self.timetableImg.clipsToBounds = YES;
    self.timetableBtn.layer.cornerRadius=6.0f;
    
    
    self.circularImg.layer.cornerRadius = self.circularImg.frame.size.width / 2;
    self.circularImg.clipsToBounds = YES;
    self.circularBtn.layer.cornerRadius=6.0f;
    
    
    self.attendanceImg.layer.cornerRadius = self.attendanceImg.frame.size.width / 2;
    self.attendanceImg.clipsToBounds = YES;
    self.attendanceBtn.layer.cornerRadius=6.0f;
    
    
    self.settingImg.layer.cornerRadius = self.settingImg.frame.size.width / 2;
    self.settingImg.clipsToBounds = YES;
    self.settingBtn.layer.cornerRadius=6.0f;
    
    
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
