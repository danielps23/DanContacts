//
//  EMBAppDelegate.h
//  DanContacts
//
//  Created by ios3345 on 05/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(strong) NSMutableArray *contatos;

@property(strong) NSString *arquivoContatos;

@property(readonly,strong) NSManagedObjectContext *contexto;

- (NSURL*) applicationDocumentsDirectory;
- (NSManagedObjectModel *) managedObjectModel;
- (NSPersistentStoreCoordinator *) coordinator;
- (void) salvaContexto;
- (void) inserirDados;
- (void) buscarContatos;

@end
