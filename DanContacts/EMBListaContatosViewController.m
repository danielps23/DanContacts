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

@synthesize contatos, sections, contatoSelecionado;

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
    form.delegate = self;
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

- (void) viewDidAppear:(BOOL)animated {
    if ( self.contatoSelecionado ) {
        NSInteger section = [self.orderedSections indexOfObject:[[self.contatoSelecionado.nome substringToIndex:1] uppercaseString]];
        NSMutableArray *contatosSecao = [self contatosBySection:section];
        NSInteger row = [contatosSecao indexOfObject:self.contatoSelecionado];
        NSIndexPath *linhaDestaque = [NSIndexPath indexPathForRow:row inSection:section];
        [self.tableView selectRowAtIndexPath:linhaDestaque animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self.tableView scrollToRowAtIndexPath:linhaDestaque atScrollPosition:UITableViewScrollPositionNone animated:YES];
        
        self.contatoSelecionado = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(exibeMaisAcoes:)];
    [self.tableView addGestureRecognizer:longPress];
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
    form.delegate = self;
    [self.navigationController pushViewController:form animated:YES];
}

- (Contato *) contatoBySection:(NSInteger)section row:(NSInteger)row {
    return [[self contatosBySection:section] objectAtIndex:row];
}

- (NSMutableArray *) contatosBySection:(NSInteger)section {
    return [self.sections valueForKey:[[self orderedSections] objectAtIndex:section]];
}

- (void) contatoAdicionado:(Contato *) contato {
    [self.contatos addObject:contato];
    self.contatoSelecionado = contato;
    [self createSections];
    [self populateSections];
    [self.tableView reloadData];
}

- (void) contatoAtualizado:(Contato *) contato {
    self.contatoSelecionado = contato;   
}

- (void) exibeMaisAcoes:(UIGestureRecognizer *) gesture {
    if ( gesture.state == UIGestureRecognizerStateBegan ) {
        CGPoint ponto = [gesture locationInView:self.tableView];
        NSIndexPath *index = [self.tableView indexPathForRowAtPoint:ponto];
        
        Contato *contato = [self contatoBySection:index.section row:index.row];
        contatoLongPress = contato;
        
        UIActionSheet *opcoes = [[UIActionSheet alloc] initWithTitle:contato.nome delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Ligar" , @"Enviar Email", @"Visualizar Site", @"Abrir Mapa", nil];
        [opcoes showInView:self.view];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self ligar];
            break;
        case 1:
            [self enviarEmail];
            break;
        case 2:
            [self abrirSite];
            break;
        case 3:
            [self mostrarMapa];
            break;
        default:
            break;
    }
    
    contatoLongPress = nil;
}

- (void) ligar {
    UIDevice *device = [UIDevice currentDevice];
    if ([device.model isEqualToString:@"iPhone"]) {
        NSString *numero = [NSString stringWithFormat:@"tel:%@", contatoLongPress.telefone];
        [self abrirAplicativoComURL:numero];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Impossivel fazer ligacao" message:@"Seu dispositivo nao é um iPhone" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
    
}

- (void) enviarEmail {
    if ( [MFMailComposeViewController canSendMail] ) {
        MFMailComposeViewController *enviadorEmail = [[MFMailComposeViewController alloc] init];
        enviadorEmail.mailComposeDelegate = self;
        
        [enviadorEmail setToRecipients:[NSArray arrayWithObject:contatoLongPress.email]];
        [enviadorEmail setSubject:@"Embrapa"];
        
        [self presentModalViewController:enviadorEmail animated:YES];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Impossivel enviar email" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}

- (void) abrirSite {
    NSString *url = contatoLongPress.site;
    [self abrirAplicativoComURL:url];
}

- (void) mostrarMapa {
    NSString *url = [[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", contatoLongPress.endereco] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self abrirAplicativoComURL:url];
}

-(void)abrirAplicativoComURL:(NSString *) url {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissModalViewControllerAnimated:YES];
}

@end
