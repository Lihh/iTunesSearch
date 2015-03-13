//
//  ViewController.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Musica.h"
#import "Ebook.h"
#import "Podcast.h"

@interface TableViewController () {
    NSArray *filmes;
    NSArray *musicas;
    NSArray *ebooks;
    NSArray *podcasts;
    NSUserDefaults *userDefaults;
}

@end

@implementation TableViewController

@synthesize searchButton, searchField;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    self.tableview.contentInset = UIEdgeInsetsMake(20.0f, 0.0f, 0.0f, 0.0);
    
    [searchButton setTitle:NSLocalizedString(@"Search", nil)];
    
    iTunesManager *itunes = [iTunesManager sharedInstance];
    userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *lastSearch = [userDefaults objectForKey:@"lastSearch"];
    
    filmes = [itunes buscarFilmes:lastSearch];
    musicas = [itunes buscarMusicas:lastSearch];
    ebooks = [itunes buscarEbooks:lastSearch];
    podcasts = [itunes buscarPodcasts:lastSearch];
    
    
#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
   // self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 15.f)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 ){
        return [filmes count];
    } else if (section == 1){
        return [musicas count];
    } else if (section == 2){
        return [ebooks count];
    } else {
        return [podcasts count];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return [NSString stringWithFormat:NSLocalizedString(@"Movies", nil)];
    } else if (section == 1){
        return [NSString stringWithFormat:NSLocalizedString(@"Musics", nil)];
    } else if (section == 2){
        return [NSString stringWithFormat:NSLocalizedString(@"Ebooks", nil)];
    } else{
        return [NSString stringWithFormat:NSLocalizedString(@"Podcasts", nil)];
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    if (indexPath.section == 0) {
        Filme *filme = [filmes objectAtIndex:indexPath.row];
        
        [celula.nome setText:filme.nome];
        [celula.tipo setText:[NSString stringWithFormat:NSLocalizedString(@"Movie", nil)]];
        [celula.pais setText:filme.pais];
        [celula.genero setText:filme.genero];
        
        NSTimeInterval timeInterval = [filme.duracao intValue]/1000;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *date1 = [[NSDate alloc] init];
        NSDate *date2 = [[NSDate alloc] initWithTimeInterval:timeInterval sinceDate:date1];
        NSCalendarUnit calendarUnit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *conversion = [calendar components:calendarUnit fromDate:date1 toDate:date2 options:0];
        [celula.duracao setText:[NSString stringWithFormat:@"%ld:%ld:%ld", (long)conversion.hour, (long)conversion.minute, (long)conversion.second]];
        
    } else if (indexPath.section == 1){
        Musica *musica = [musicas objectAtIndex:indexPath.row];
        
        [celula.nome setText:musica.nome];
        [celula.tipo setText:[NSString stringWithFormat:NSLocalizedString(@"Song", nil)]];
        [celula.pais setText:musica.pais];
        [celula.genero setText:musica.genero];
        
        NSTimeInterval timeInterval = [musica.duracao intValue]/1000;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *date1 = [[NSDate alloc] init];
        NSDate *date2 = [[NSDate alloc] initWithTimeInterval:timeInterval sinceDate:date1];
        NSCalendarUnit calendarUnit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *conversion = [calendar components:calendarUnit fromDate:date1 toDate:date2 options:0];
        [celula.duracao setText:[NSString stringWithFormat:@"%ld:%ld:%ld", (long)conversion.hour, (long)conversion.minute, (long)conversion.second]];
        
    } else if (indexPath.section == 2){
        Ebook *ebook = [ebooks objectAtIndex:indexPath.row];
        
        [celula.nome setText:ebook.nome];
        [celula.tipo setText:[NSString stringWithFormat:NSLocalizedString(@"Ebook", nil)]];
        [celula.pais setText:ebook.preco];
        [celula.genero setText:ebook.artista];
        [celula.duracao setText:@""];
        
    } else if (indexPath.section == 3){
        Podcast *podcast = [podcasts objectAtIndex:indexPath.row];
        
        [celula.nome setText:podcast.nome];
        [celula.tipo setText:[NSString stringWithFormat:NSLocalizedString(@"Podcast", nil)]];
        [celula.pais setText:podcast.pais];
        [celula.genero setText:podcast.genero];
        [celula.duracao setText:@""];
        
    }
    
    
    
    return celula;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}


- (IBAction)search:(id)sender {
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    iTunesManager *itunes = [iTunesManager sharedInstance];
    filmes = [itunes buscarFilmes:(searchField.text)];
    musicas = [itunes buscarMusicas:(searchField.text)];
    ebooks = [itunes buscarEbooks:(searchField.text)];
    podcasts = [itunes buscarPodcasts:(searchField.text)];
    
    [userDefaults setObject:searchField.text forKey:@"lastSearch"];
    
    
    [searchField resignFirstResponder];
    [self.tableview reloadData];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [searchField resignFirstResponder];
}



@end
