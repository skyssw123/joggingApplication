//
//  AppDelegate.h
//  Jogger
//
//  Created by Thomas Sin on 2015-11-28.
//  Copyright © 2015 sin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property CLLocationManager* locationManager;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

