//
//  EMBListaContatosViewController.m
//  DanContacts
//
//  Created by ios3345 on 05/03/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EMBListaContatosViewController.h"
#import "EMBFormularioContatoViewController.h"
#import "Contato.h"

@implementation EMBListaContatosViewController

@synthesize contatos, sections;

- (id) init {
    if ( self = [super init] ) {
        self.sections = [[NSMutableDictionary alloc] init];
        self.navigationItem.title = @"Contatos";
        UIBarButtonItem *botaoExibirFormulario = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(exibeFormulario)];
        self.navigationItem.rightBarButtonItem = botaoExibirFormulario;
        self.navigationItem.leftBarButtonItem = self.editButtonItem; 
    }
    return self;
}

- (void) exibeFormulario {
//    UIAlertView *alert = [[UIAlertView alloc]
//                          initWithTitle: @"Exibir Formulario"
//                          message: @"Isso eh um UIAlertView"
//                          delegate: nil
//                          cancelButtonTitle:@"OK"
//                          otherButtonTitles:nil];
//    [alert show];
    EMBFormularioContatoViewController *form = [[EMBFormularioContatoViewController alloc] init];
    form.contatos = self.contatos;
    form.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:form];
    [self presentModalViewController:nav animated:YES];
}

- (void) viewWillAppear:(BOOL)animated {
//    NSLog(@"Total cadastrado: %d", [self.contatos count]);
    [self createSections];
    [self populateSections];
    [self.tableView reloadData];
    
}

- (void) createSections {
    self.sections = [[NSMutableDictionary alloc] init];
    BOOL found;
    
    for (Contato *contato in self.contatos)
    {
        NSString *c = [[contato.nome substringToIndex:1] uppercaseString];
        
        found = NO;
        
        for (NSString *str in [self.sections allKeys])
        {
            if ([str isEqualToString:c])
            {
                found = YES;
            }
        }
        
        if (!found)
        {
            [self.sections setValue:[[NSMutableArray alloc] init] forKey:c];
        }
    }
}

- (void) populateSections {
    for (Contato *contato in self.contatos) {
        [[self.sections objectForKey:[[contato.nome substringToIndex:1] uppercaseString]] addObject:contato];
    }
    
    // Ordenar cada array
    for (NSString *key in [self.sections allKeys]) {
        [[self.sections objectForKey:key] sortUsingComparator:^NSComparisonResult(id a, id b) {
            NSString *first = [[(Contato*)a nome] uppercaseString];
            NSString *second = [[(Contato*)b nome] uppercaseString];
            return [first compare:second];
        }];
    }
}

- (NSArray *) orderedSections {
    return [[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Contato *contato = [self contatoBySection:indexPath.section row:indexPath.row];
    cell.textLabel.text = contato.nome;
    cell.detailTextLabel.text = contato.telefone;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.sections allKeys] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self orderedSections] objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self contatosBySection:section] count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self orderedSections];
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray *contatosSecao = [self contatosBySection:indexPath.section];
        Contato *contato = [contatosSecao objectAtIndex:indexPath.row];
        [contatosSecao removeObjectIdenticalTo:contato];
        [self.contatos removeObjectIdenticalTo:contato];
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Contato *contato = [self contatoBySection:indexPath.section row:indexPath.row];
    EMBFormularioContatoViewController *form = [[EMBFormularioContatoViewController alloc] initWithContato:contato];
    form.contatos = self.contatos;
    [self.navigationController pushViewController:form animated:YES];
}

- (Contato *) contatoBySection:(NSInteger)section row:(NSInteger)row {
    return [[self contatosBySection:section] objectAtIndex:row];
}

- (NSMutableArray *) contatosBySection:(NSInteger)section {
    return [self.sections valueForKey:[[self orderedSections] objectAtIndex:section]];
}

@end
