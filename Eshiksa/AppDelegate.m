//
//  AppDelegate.m
//  Eshiksa
//
//  Created by Punit on 18/04/18.
//  Copyright © 2018 Akhilesh. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#import "LoginViewController.h"
//@import GoogleMaps;
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"selectedLanguage"]==nil)
    {
        NSBundle *langBundle = [[NSBundle alloc]init];
        [langBundle setLanguage:@"en"];
    }
    else
    {
        NSBundle *langBundle = [[NSBundle alloc]init];
        [langBundle setLanguage:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedLanguage"]];
    }


   
   // [GMSServices provideAPIKey:@"AIzaSyDVrSY5_9yKSWkjfy1Wt2pD721oqhbRY5o"];
    //[GMSPlacesClient provideAPIKey:@"AIzaSyDVrSY5_9yKSWkjfy1Wt2pD721oqhbRY5o"];
    
    
    // Override point for customization after application launch.
    
   // LanguageManger.shared.defaultLanguage = .en
    
   /* NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    LanguageManager *languageManager = [LanguageManager sharedLanguageManager];
    
    // Check whether the language code has already been set.
    if (![userDefaults stringForKey:DEFAULTS_KEY_LANGUAGE_CODE]) {
        
        NSLog(@"No language set - trying to find the right setting for the device locale.");
        NSLocale *currentLocale = [NSLocale currentLocale];
        
        // Iterate through available localisations to find the matching one for the device locale.
        for (Locale *localisation in languageManager.availableLocales) {
            if ([localisation.languageCode caseInsensitiveCompare:[currentLocale objectForKey:NSLocaleLanguageCode]] == NSOrderedSame) {
                [languageManager setLanguageWithLocale:localisation];
                break;
            }
        }
        
        // If the device locale doesn't match any of the available ones, just pick the first one.
        if (![userDefaults stringForKey:DEFAULTS_KEY_LANGUAGE_CODE]) {
            NSLog(@"Couldn't find the right localisation - using default.");
            [languageManager setLanguageWithLocale:languageManager.availableLocales[0]];
        }
    }
    else {
        NSLog(@"The language has already been set :)");
    }
    */
    UIStoryboard *storyboard = [self grabStoryboard];
    
    // display storyboard
    self.window.rootViewController = [storyboard instantiateInitialViewController];
    [self.window makeKeyAndVisible];
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    
    
    if(savedValue!=NULL)
    {
        int screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        
        switch (screenHeight) {
                // iPhone 4s
            case 480:
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                LoginViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                self.window.rootViewController = navController;
                
                
                break;
            }
                //iPhone 5 & iPhone SE
            case 548:
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                LoginViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                self.window.rootViewController = navController;
                
                
                break;
            } // iPhone 5s
            case 568:
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                LoginViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                self.window.rootViewController = navController;
                
                
                break;
            }
                // iPhone 6 & 6s & iPhone 7
            case 647:
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                LoginViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                self.window.rootViewController = navController;
                
                
                break;
            }
            default:
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
                LoginViewController *loginController=[[UIStoryboard storyboardWithName:@"Main2" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                self.window.rootViewController = navController;
                
                
                break;
            }
                // iPhone 6 Plus & 6s Plus & iPhone 7 Plus
          /*  case 716:
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
                LoginViewController *loginController=[[UIStoryboard storyboardWithName:@"Main2" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                self.window.rootViewController = navController;
                
                
                break;
            }
            case 667:
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
                LoginViewController *loginController=[[UIStoryboard storyboardWithName:@"Main2" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                self.window.rootViewController = navController;
                
                
                break;
            }
            case 736:
            {
                storyboard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
                LoginViewController *loginController=[[UIStoryboard storyboardWithName:@"Main2" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                self.window.rootViewController = navController;
                
                
                break;
            }
            case 1366:
            {
                storyboard = [UIStoryboard storyboardWithName:@"ipad2" bundle:nil];
                LoginViewController *loginController=[[UIStoryboard storyboardWithName:@"ipad2" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                self.window.rootViewController = navController;
                
                
                break;
            }
                
            default:
            {
                storyboard = [UIStoryboard storyboardWithName:@"ipad" bundle:nil];
                LoginViewController *loginController=[[UIStoryboard storyboardWithName:@"ipad" bundle:nil]instantiateViewControllerWithIdentifier:@"identifier"];
                UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
                self.window.rootViewController = navController;
                
                
                break;
            }*/
        }
    }

    return YES;
}

- (UIStoryboard *)grabStoryboard {
    
    // determine screen size
    int screenHeight = [UIScreen mainScreen].bounds.size.height;
    NSLog(@"screenheight==== %d",screenHeight);
    UIStoryboard *storyboard;
    
    switch (screenHeight) {
            // iPhone 4s
        case 480:
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            break;
            
            //iPhone 5 & iPhone SE
        case 548:
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            break;
            
            // iPhone 5s
        case 568:
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            break;
            
            // iPhone 6 & 6s & iPhone 7
        case 647:
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            break;
            
            
        default:
            
        storyboard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
        break;
            // iPhone 6 Plus & 6s Plus & iPhone 7 Plus
//        case 716:
//            storyboard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
//            break;
//            
//        case 667:
//            storyboard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
//            break;
//        case 736:
//            storyboard = [UIStoryboard storyboardWithName:@"Main2" bundle:nil];
//            break;
            
//        case 1366:
//            storyboard = [UIStoryboard storyboardWithName:@"ipad2" bundle:nil];
//            break;
//            
//            
//        default:
//            // it's an iPad
//            storyboard = [UIStoryboard storyboardWithName:@"ipad" bundle:nil];
//            break;
    }
    
    return storyboard;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
