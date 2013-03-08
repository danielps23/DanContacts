//
//  EMBAppDelegate.m
//  DanContacts
//
//  Created by ios3345 on 05/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EMBAppDelegate.h"
#import "EMBListaContatosViewController.h"
#import "EMBContatosNoMapaViewController.h"

@implementation EMBAppDelegate

@synthesize window = _window;

@synthesize contexto = _contexto;

@synthesize contatos,arquivoContatos;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self inserirDados];
    [self buscarContatos];
    
//    NSArray *userDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentDir = [userDirs objectAtIndex:0];
//    self.arquivoContatos = [NSString stringWithFormat:@"%@/ArquivoContatos", documentDir];
//    
//    self.contatos = [NSKeyedUnarchiver unarchiveObjectWithFile:self.arquivoContatos];
//    if (!self.contatos) {
//        self.contatos = [[NSMutableArray alloc] init];
//    }
    
//    EMBFormularioContatoViewController *formulario = [[EMBFormularioContatoViewController alloc] init];
//    self.window.rootViewController = formulario;
    
    EMBListaContatosViewController *lista = [[EMBListaContatosViewController alloc] init];
    lista.contatos = self.contatos;
    lista.contexto = self.contexto;
//    self.window.rootViewController = lista;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lista];
    
    EMBContatosNoMapaViewController *contatosMapa = [[EMBContatosNoMapaViewController alloc] init];
    contatosMapa.contatos = contatos;
    
    UINavigationController *mapaNavigation = [[UINavigationController alloc] initWithRootViewController:contatosMapa];
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = [NSArray arrayWithObjects:nav, mapaNavigation, nil];
    
        self.window.rootViewController = tabBarController;
        
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    
//    [NSKeyedArchiver archiveRootObject:self.contatos toFile:self.arquivoContatos];
    [self salvaContexto];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (NSURL*) applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *) managedObjectModel {
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Modelo_Contatos" withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return managedObjectModel;
}

- (NSPersistentStoreCoordinator *) coordinator {
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *pastaDocuments = [ self applicationDocumentsDirectory];
    NSURL *localBancoDeDados = [pastaDocuments URLByAppendingPathComponent:@"Contatos.sqlite"];
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:localBancoDeDados options:nil error:nil];
    
    return coordinator;
}

- (NSManagedObjectContext *) contexto {
    if (_contexto) {
        return _contexto;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self coordinator];
    _contexto = [[NSManagedObjectContext alloc] init];
    [_contexto setPersistentStoreCoordinator:coordinator];
    
    return _contexto;
}

- (void) salvaContexto {
    NSError *error;
    if (![self.contexto save:&error]) {
        NSDictionary *informacoes = [error userInfo];
        NSArray *multiplosErros = [informacoes objectForKey:NSDetailedErrorsKey];
        if (multiplosErros) {
            for (NSError *erro in multiplosErros) {
                NSLog(@"Ocorreu um problema: %@", [erro userInfo]);
            }
        } else {
            NSLog(@"Ocorreu um problema: %@", informacoes);
        }
    }
}

- (void) inserirDados {
    NSUserDefaults *configuracoes = [NSUserDefaults standardUserDefaults];
    BOOL dadosInseridos = [configuracoes boolForKey:@"dados_inseridos"];
    if (!dadosInseridos) {
        Contato *caelumSP = [NSEntityDescription insertNewObjectForEntityForName:@"Contato" inManagedObjectContext:self.contexto];
        caelumSP.nome = @"Caelum Unidade Sao Paulo";
        caelumSP.email = @"contato@caelum.com.br";
        caelumSP.endereco = @"Sao Paulo, SP, Rua Vergueiro, 3185";
        caelumSP.telefone = @"01155712751";
        caelumSP.site = @"http://www.caelum.com.br";
        caelumSP.latitude = [NSNumber numberWithDouble:-23.5883034];
        caelumSP.longitude = [NSNumber numberWithDouble:-46.632369];
        
        [self salvaContexto];
        [configuracoes setBool:TRUE forKey:@"dados_inseridos"];
        [configuracoes synchronize];
    }
}

- (void) buscarContatos {
    NSFetchRequest *buscaContatos = [NSFetchRequest fetchRequestWithEntityName:@"Contato"];
    NSSortDescriptor *ordenarPorNome = [NSSortDescriptor sortDescriptorWithKey:@"nome" ascending:YES];
    [buscaContatos setSortDescriptors:[NSArray arrayWithObject:ordenarPorNome]];
     NSArray *contatosImutaveis = [self.contexto executeFetchRequest:buscaContatos error:nil];
     self.contatos = [contatosImutaveis mutableCopy];
}


@end
