//
//  Friends+CoreDataProperties.h
//  BookClub
//
//  Created by Jamar Gibbs on 1/27/16.
//  Copyright © 2016 M1ndful M3d1a. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Friends.h"

NS_ASSUME_NONNULL_BEGIN

@interface Friends (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END
