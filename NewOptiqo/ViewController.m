//
//  ViewController.m
//  Optiqo
//
//  Created by Umapathi on 8/8/14.
//  Copyright (c) 2014 Umapathi. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"


@implementation ViewController

@synthesize startView,barView,bottomBarView,deviceWidth,deviceHeight,menuView,rightmenuView,toggleMenu,toggleRightMenu,userView,profileView,reports,customerList,commentsRoom,colorArray,cleaningType,lat,lan,customerName,userLanguageSelected,customerLanguageSelected,swedishLabels,germanLabels,englishLabels,selectedRoomName,currentTime,doneTime,isCustomer,reportSentDate,isHomeCleaningSelected,isOfficeCleaningSelected,activityView,customerStartTime,customerEndTime;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    //storing the device width and height
    self.deviceWidth = [[UIScreen mainScreen] bounds].size.width;
    self.deviceHeight = [[UIScreen mainScreen] bounds].size.height;
    
    self.toggleMenu = NO;
    
    
    
    
    UIColor *greenColor = [UIColor colorWithRed:0.0 green:1.0 blue:96.0/255.0 alpha:1.0];
    UIColor *blueColor = [UIColor colorWithRed:0.0 green:191.0/255.0 blue:1.0 alpha:1.0];
    
    self.colorArray = [[NSMutableArray alloc] initWithObjects:greenColor,blueColor,nil];
 
    self.cleaningType = 1;
    
   
    

    
    
    //language translation in swedish and english for app user and report sending
    
    //swedish words
    NSDictionary *userSwedishLabels = @{
                                        
                                        @"mainmenu":@"Huvudmeny",
                                        @"user":@"Användare",
                                        @"username":@"Användarnamn",
                                        @"companycode":@" Företagskod",
                                        @"companyname":@" Företag",
                                        @"streetname":@" Adress",
                                        @"city":@" Stad",
                                        @"boxaddress":@" Postnummer",
                                        @"country":@" Land",
                                        @"code":@" Riktnummer",								//<-- Remove
                                        @"phonenumber":@" Telefonnummer",
                                        @"taxnumber":@" Organisationsnummer",
                                        @"url":@" Hemsida",
                                        @"email":@" Mailadress",
                                        @"description":@" Beskrivning",
                                        @"emailsubject":@" Ämnesrad",								//<-- Hide - Not to be visible
                                        @"cancel":@"Avbryt",
                                        @"userfirstname":@" Förnamn",
                                        @"userlastname":@" Efternamn",
                                        @"signature":@"Signatur",
                                        @"adduser":@"Lägg till kund",
                                        @"addprofile":@"Lägg till profil",
                                        @"reports":@"Rapporter",
                                        @"profile":@"Profil",
                                        @"language":@"Språk",
                                        @"save":@"Spara",
                                        @"writesignature":@"Skriva din signatur",
                                        @"validphone":@"Ange giltigt telefonnummer",
                                        @"noreports":@"Inga rapporter",
                                        @"message":@"Optiqo Inspect",
                                        @"error_code":@"Ogiltig kod",
                                        @"companyInfoMessage":@"För er egen företagslogotyp i de kvalitetsrapporter som skapas, maila info@optiqo.com för mer information. För användarmanual besök www.optiqo360.net och välj 'Request access' nere till vänster på skärmen.",
                                        
                                        //customer info
                                        
                                        @"addcustomers":@"Lägg till kund",
                                        @"customername":@" Kundnamn",
                                        @"customeremail":@" Mailadress",
                                        @"customeraddress":@" Adress",
                                        @"customerstreet":@" Gata",								//<-- remove as it's covered by the address
                                        @"customercity":@" Stad",
                                        @"customercountry":@" Land",
                                        @"customercountrycode":@" Kod",								//<--- Remove
                                        @"customerphonenumber":@" Telefonnummer",
                                        @"customerlanguage":@"Svenska",
                                        @"customertype":@"Ange uppdragstyp",
                                        @"clear":@"Rensa",
                                        @"user_employer_information":@"För att starta en kontroll, fyll först i ditt användarnamn och din profil genom att klicka på menybaren uppe till vänster. För användarmanual besök www.optiqo.com.",
                                        @"selectcustomertype":@"Välj kundtyp",
                                        @"lat_lan_error":@"Ange giltig gata eller stad",
                                        @"customer_edit":@"Redigera",
                                        @"delete_rooms":@"Cannot change customer type. To change the customer type delete rooms",
                                        
                                        
                                        //languages
                                        @"english":@"English",
                                        @"swedish":@"Svenska",
                                        
                                        //right menu
                                        @"menu":@"Meny",
                                        @"home":@"Hem",
                                        @"customerinfo":@"Kunduppgifter",
                                        
                                        //room types
                                        
                                        @"customerrooms":@"Välj rum",
                                        @"livingroom":@"Vardagsrum",
                                        @"studyroom":@"Kontor",								//<-- Office "Kontor"
                                        @"kitchen":@"Kök",
                                        @"bedroom":@"Sovrum",
                                        @"dressingroom":@"Hall",
                                        @"toilet":@"Badrum",
                                        @"washingroom":@"Tvättstuga",
                                        @"roomname":@"Rum",
                                        @"defaultrooms":@"Standardrum",
                                        @"addroom":@"Lägg till rum",
                                        @"add":@"Lägg till",
                                        @"comments":@"Kommentar",
                                        @"max_chars":@"En kommentar får inte innehålla mer än 80 tecken",
                                        @"addcomments":@"Lägg till kommentar",
                                        @"next":@"Nästa",
                                        @"customers":@"Välj kund",
                                        @"employer":@"Arbetsgivare",
                                        @"homecleaning":@"Privatperson",
                                        @"officecleaning":@"Företag",
                                        @"new_room":@"Namnge rum",
                                        
                                        //office cleaning
                                        
                                        @"reception":@"Reception",
                                        @"hallway":@"Korridor",
                                        @"officeroom":@"Kontor",
                                        @"grouproom":@"Entré",								//<---Change to "Entrance" icon
                                        @"conferenceroom":@"Konferensrum",
                                        @"coffeeroom":@"Pentry",								//<-- Pentry
                                        @"lift":@"Hiss",
                                        @"exculator":@"Rulltrappa",
                                        @"stairs":@"Trappa",
                                        @"storeroom":@"Lager",
                                        @"wherehouse":@"Verkstad/Industri",
                                        @"washroom":@"Tvättstuga",
                                        @"shower":@"Dush",
                                        @"toilet":@"Toalett",
                                        @"wasteroom":@"Miljörum",
                                        @"parking":@"Garage",
                                        @"gym":@"Gym",
                                        @"mall":@"Galleria",
                                        
                                        //customer report info
                                        
                                        @"customername":@"Namn",
                                        @"nocomments":@"Inga kommentarer",
                                        @"time_data":@"Datum",
                                        @"description":@"Beskrivning",
                                        @"home":@"Hem",
                                        @"help":@"Hjälp",
                                        @"customerinfo":@" Uppdragstyp",
                                        @"reports":@"Översikt",
                                        @"sendcustomerreport":@"Kund",
                                        @"sendemployerreport":@"Arbetsgivare",
                                        @"addnewroom":@"Rum",
                                        @"approve":@"Godkänt",
                                        @"disapprove":@"Avvikelse",
                                        @"totalscore":@"Total Score (Max 10)",
                                        @"overview":@"Översikt",
                                        @"overviewDescription":@"Kommentar",
                                        
                                        //photo labels
                                        
                                        @"deletephoto":@"Radera bild",
                                        @"delete":@"Radera",
                                        @"takephoto":@"Ta bild",
                                        @"choosephoto":@"Välj bild",
                                        @"editphoto":@"Rita & redigera",
                                        @"retakephoto":@"Ersätt bild",
                                        
                                        //roominfo
                                        
                                        @"roominfo":@"Rumsinformation",
                                        
                                        //mail info
                                        
                                        @"mailSent":@"Skickat",
                                        @"yes":@"Ja",
                                        @"no":@"Nej",
                                        @"ok":@"Ok",
                                        @"customerMailSent":@"Skickat",
                                        @"employerMailSent":@"Skickat",
                                        @"customerMailNotSent":@"Ej skickat",
                                        @"employerMailNotSent":@"Ej skickat",
                                        @"report_sent":@"Du kan inte gå tillbaka, kontrollen har redan skickats.",
                                        @"homeview":@"Är du säker på att du vill avbryta?",
                                        @"newinspection":@"Är du säker på att du vill avbryta?",
                                        @"inspection":@"Inspektion",
                                        @"clientinformation":@"Kundinformation",
                                        @"location":@"Plats",
                                        @"companyinformation":@"Företagsinformation",
                                        @"inspectionCarried":@"Utförd av:",
                                        @"room":@"Rum",
                                        @"type":@"Typ",
                                        @"name":@"Namn",
                                        @"pictures":@"Bilder",
                                        @"time":@"Tid",
                                        @"status":@"Status",
                                        @"time_date":@"Datum",
                                        @"total_time":@"Total tid",
                                        @"hello":@"Hej",
                                        @"done":@"Klar",
                                        @"customerMailSubjectLine":@"Kvalitetsrapport har utförts",
                                        @"customerMailMessageBody":@"Kvalitetsrapport från",
                                        @"employerMailSubjectLine":@"En kontroll har utförts",
                                        @"employerMailMessageBody":@"En kontroll har utförts av",
                                        @"inspectionCarriedBy":@"Kontroll utförd av",
                                        @"name":@"Namn",
                                        @"reportAddress":@"Adress",
                                        @"reportemail":@"Email",
                                        @"reportwebsite":@"Hemsida",
                                        @"reportphonenumber":@"Tel",
                                        @"reportroom":@"Rumstyp",
                                        @"addReports":@"Du har inte några rum att rapportera.",
                                        @"quality":@"Kvalitets",
                                        @"quality_report":@"rapport",
                                        @"reportProcess":@"Skapar rapport"
                                        
                                        
                                        
                                        
                                    };
    
    //german words
    NSDictionary *userGermanLabels = @{
                                            @"companyname":@" Firmenname",
                                            @"streetname":@" Strasse",
                                            @"boxaddress":@" Postnummer",
                                            @"country":@" Land",
                                            @"code":@" Code",
                                            @"phonenumber":@" Telefonnummer",
                                            @"taxnumber":@" Organisationsnummer",
                                            @"url":@" Webseite",
                                            @"email":@" Mailadresse",
                                            @"description":@" Beschreibung",
                                            @"emailsubject":@" Thema",
                                            @"cancel":@"Unterbrechen",
                                            @"user":@"  Anwender",
                                            @"signature":@"Signatur",
                                            @"adduser":@"Neuer Kunde",
                                            @"addprofile":@"Neuer Profil",
                                            @"reports":@"Rapport",
                                            @"profile":@"Profil",
                                            @"language":@"Sprache",
                                            @"save":@"Speichern"
                                        
                                        };

    
    
    //english words
    NSDictionary *userEnglishLabels = @{
                                            @"mainmenu":@"Main menu",
                                            @"user":@"User",
                                            @"username":@"Username",
                                            @"companycode":@" Company code",
                                            @"companyname":@" Company name",
                                            @"streetname":@" Street name",
                                            @"city":@" City",
                                            @"boxaddress":@" Postal code",
                                            @"country":@" Country",
                                            @"code":@" Code",
                                            @"phonenumber":@" Phone number",
                                            @"taxnumber":@" Vat number",
                                            @"url":@" Homepage",
                                            @"email":@" Email",
                                            @"description":@" Message body",
                                            @"emailsubject":@" Mail subject line",
                                            @"cancel":@"Cancel",
                                            @"userfirstname":@" First name",
                                            @"userlastname":@" Last name",
                                            @"signature":@"Signature",
                                            @"adduser":@"Add User",
                                            @"addprofile":@"Add profile",
                                            @"reports":@"Reports",
                                            @"profile":@"Profile",
                                            @"language":@"English",
                                            @"save":@"Save",
                                            @"writesignature":@"Write your signature",
                                            @"validphone":@"Enter valid phone number",
                                            @"noreports":@"No reports",
                                            @"message":@"Optiqo Inspect",
                                            @"error_code":@"Invalid code",
                                            @"companyInfoMessage":@"To include your own company logo in the quality reports, please send a mail to info@optiqo.com for more information. For 'User manual' please visit www.optiqo360.net and 'Request access' down to the left on the screen.",
                                            
                                            //customer info
                                            
                                            @"addcustomers":@"Add customer",
                                            @"customername":@" Customer name",
                                            @"customeremail":@" Email",
                                            @"customeraddress":@" Address",
                                            @"customerstreet":@" Postal code",
                                            @"customercity":@" City",
                                            @"customercountry":@" Country",
                                            @"customercountrycode":@" Code",
                                            @"customerphonenumber":@" Phone",
                                            @"customerlanguage":@"English",
                                            @"customertype":@"Customer type",
                                            @"clear":@"Clear",
                                            @"user_employer_information":@"To start an inspection please fill in your username and profile. For user guide visit wwww.optiqo.com.",
                                            @"selectcustomertype":@"Select customer type",
                                            @"lat_lan_error":@"Enter valid adress or city",
                                            @"customer_edit":@"Edit",
                                            @"delete_rooms":@"Cannot change customer type. To change the customer type delete rooms",
                                            
                                            //languages
                                            @"english":@"English",
                                            @"swedish":@"Svenska",
                                           
                                            
                                            //right menu
                                            @"menu":@"Menu",
                                            @"home":@"Home",
                                            @"customerinfo":@"Customer info",
                                            
                                            //room types
                                            
                                            @"customerrooms":@"Select room",
                                            @"livingroom":@"Living room",
                                            @"studyroom":@"Study room",
                                            @"kitchen":@"Kitchen/Pentry",
                                            @"bedroom":@"Bedroom",
                                            @"dressingroom":@"Dressing room",
                                            @"toilet":@"Bathroom",
                                            @"washingroom":@"Washing room",
                                            @"roomname":@"Room name",
                                            @"defaultrooms":@"Standard room",
                                            @"addroom":@"Add room",
                                            @"add":@"Add",
                                            @"comments":@"Comment",
                                            @"max_chars":@"A comment cant be more than 80 characters long",
                                            @"addcomments":@"Add comment",
                                            @"next":@"Next",
                                            @"customers":@"Select customer",
                                            @"employer":@"Employer",
                                            @"homecleaning":@"Private",
                                            @"officecleaning":@"Business",
                                            @"new_room":@"Room name",
                                            
                                            //office cleaning
                                            
                                            @"reception":@"Reception",
                                            @"hallway":@"Hallway",
                                            @"officeroom":@"Office room",
                                            @"grouproom":@"Entrance",
                                            @"conferenceroom":@"Conference room",
                                            @"coffeeroom":@"Coffee room",
                                            @"lift":@"Elevator",
                                            @"exculator":@"Escalator",
                                            @"stairs":@"Stairs",
                                            @"storeroom":@"Store room",
                                            @"wherehouse":@"Warehouse",
                                            @"washroom":@"Washroom",
                                            @"shower":@"Shower",
                                            @"toilet":@"toilet",
                                            @"wasteroom":@"Waste room",
                                            @"parking":@"Parking",
                                            @"gym":@"Gym",
                                            @"mall":@"Mall",
                                            
                                            //customer report info
                                            
                                            @"customername":@"Customer name",
                                            @"nocomments":@"No comments",
                                            @"time_data":@"Time&Date",
                                            @"description":@"Description",
                                            @"home":@"Home",
                                            @"help":@"Help",
                                            @"customerinfo":@"Customer type",
                                            @"reports":@"Overview",
                                            @"sendcustomerreport":@"Customer",
                                            @"sendemployerreport":@"Employer",
                                            @"addnewroom":@"Room",
                                            @"approve":@"Approved",
                                            @"disapprove":@"Failed inspection",
                                            @"totalscore":@"Total Score (Max 10)",
                                            @"overview":@"Overview",
                                            @"overviewDescription":@"Comments",
                                            
                                            //photo labels
                                            
                                            @"deletephoto":@"Delete photo",
                                            @"delete":@"Delete",
                                            @"takephoto":@"Take photo",
                                            @"choosephoto":@"Choose photo",
                                            @"editphoto":@"Edit photo",
                                            @"retakephoto":@"Replace photo",
                                            
                                            //roominfo
                                            
                                            @"roominfo":@"Room info",
                                            
                                            //mail info
                                            
                                            @"mailSent":@"Mail allready sent",
                                            @"yes":@"Yes",
                                            @"no":@"No",
                                            @"ok":@"Ok",
                                            @"customerMailSent":@"Mail has been sent to customer",
                                            @"employerMailSent":@"Mail has been sent to employer",
                                            @"customerMailNotSent":@"Customer mail not sent",
                                            @"employerMailNotSent":@"Customer mail not sent",
                                            @"report_sent":@"You can not go back, the inspection has already been sent.",
                                            @"homeview":@"Do you really quit the current view and go to main view?",
                                            @"newinspection":@"Are you sure to start a new inspection?",
                                            @"inspection":@"Inspection",
                                            @"clientinformation":@"CLIENT INFORMATION",
                                            @"location":@"LOCATION",
                                            @"companyinformation":@"COMPANY INFORMATION",
                                            @"inspectioncarried":@"INSPECTION CARRIED OUT BY:",
                                            @"room":@"Room",
                                            @"type":@"Type",
                                            @"name":@"Name",
                                            @"pictures":@"Pictures",
                                            @"time":@"Time",
                                            @"status":@"Status",
                                            @"time_date":@"Date",
                                            @"total_time":@"Total time",
                                            @"hello":@"Hello",
                                            @"done":@"Done",
                                            @"customerMailSubjectLine":@"Quality report from",
                                            @"customerMailMessageBody":@"Quality report from",
                                            @"employerMailSubjectLine":@"Inspection has been carried out",
                                            @"employerMailMessageBody":@"Inspection has been carried out by",
                                            @"inspectionCarried":@"Inspection carried out by",
                                            @"name":@"Name",
                                            @"reportAddress":@"Address",
                                            @"reportemail":@"Email",
                                            @"reportwebsite":@"Website",
                                            @"reportphonenumber":@"Phone",
                                            @"reportroom":@"Room type",
                                            @"addReports":@"No rooms to report.",
                                            @"quality":@"Quality",
                                            @"quality_report":@"report",
                                            @"reportProcess":@"Creating report"
                                            
                                            
                                            
                                        };
    
    
   // NSDictionary *customerSwedishLabels = @{};
    
    /*NSDictionary *customerEnglsihLabels = @{
                                                @"addcustomers":@"Add Customers",
                                                @"customerName":@"   Name",
                                                @"email":@" Email",
                                                @"address":@"   Address",
                                                @"street":@"   Street",
                                                @"city":@"   City",
                                                @"languages":@"Languages",
                                                @"types":@"Types",
                                                @"save":@"Save",
                                                @"rooms":@"Rooms",
                                                @"livingroom":@"Living Room",
                                                @"studyroom":@"Study Room",
                                                @"bedroom":@"Bed Room",
                                                @"dressing room":@"Dressing Room",
                                                @"toilet":@"Toilet",
                                                @"washingroom":@"Washing room",
                                                @"roomname":@"Room Name",
                                                @"defaultrooms":@"Default Rooms",
                                                @"addroom":@"Add Room",
                                                @"comments":@"Comments",
                                                @"next":@"Next",
                                                @"customers":@"Customers",
                                                @"employer":@"Employer",
                                                @"homecleaning":@"Home Cleaning",
                                                @"industrialcleaning":@"Industrial Cleaning",
                                                @"customername":@"Customer Name",
                                                @"nocomments":@"No Comments",
                                                @"time_data":@"Time&Date",
                                                @"description":@"Description",
                                                @"home":@"Home",
                                                @"help":@"Help",
                                                @"customerinfo":@"Customer Info",
                                                @"reports":@"Reports",
                                                
                                                
                                                
                                            };*/
    
    //storing dictionaries in dictionary
    //dictionary containg all languages used in app
    self.englishLabels = @{
                                @"userswedishlabels":userSwedishLabels,
                                @"usergermanlabels":userGermanLabels,
                                @"userenglishlabels":userEnglishLabels,
                                @"englishlabels":userEnglishLabels
                          };
    
    //fetches language stored by user from database
    [self getData];
    
    //gets the report status. To whom the reports allready sent
    [self getReportData];
    
    //get bar views
    [self drawBarView];
    
    //gets user language from database
    [self getUserSelectedLanguage];
    
    //if(!isReportSent)
    //draws the main view
    [self drawStartView];
    
    
    //sets the dictionary according to user selected language
    
    if([self.userLanguageSelected isEqualToString:@"Swedish"]) {
        
        labels = [self.englishLabels valueForKey:@"userswedishlabels"];
    }
    
    if([self.userLanguageSelected isEqualToString:@"German"]) {
        
        labels = [self.englishLabels valueForKey:@"usergermanlabels"];
    }
    
    if([self.userLanguageSelected isEqualToString:@"English"]) {
        
        labels = [self.englishLabels valueForKey:@"userenglishlabels"];
    }
    
    
    
    
}



//acts as a singletone class
+(id) sharedInstance {
    
    return [(AppDelegate*)[[UIApplication sharedApplication] delegate] viewController];
}

#pragma --mark gets the userlanguage from the database
//gets user selected language
-(void) getUserSelectedLanguage {
    
    
     NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    NSError *error;
    
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    if(fetchObjects) {
        
        if([fetchObjects count]!=0)
        {
            for(int i=0;i<[fetchObjects count];i++) {
            
                userData = [fetchObjects objectAtIndex:i];
            
                self.userLanguageSelected = [userData valueForKey:@"language"];
            
                if([self.userLanguageSelected isEqualToString:@"English"] || [self.userLanguageSelected isEqualToString:@"Engelska"])
                    self.userLanguageSelected = @"English";
                else
                    self.userLanguageSelected = @"Swedish";
            
            }
        }
        else
        {

            if([language isEqualToString:@"sv"])
            {
                
                self.userLanguageSelected = @"Swedish";
            }
            else
                self.userLanguageSelected = @"English";
            
        }
        
    }
    
    
    //NSLog(@"user selected language %@",self.userLanguageSelected);
}


#pragma mark --bar views
//draws two bars one at top of the and other at the bottom of the room
-(void) drawBarView {
    
    self.barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, deviceWidth, 70)];
    
    [self.barView setBackgroundColor:[UIColor colorWithRed:41.0/255.0 green:41.0/255.0 blue:42.0/255.0 alpha:1.0]];

    self.bottomBarView = [[UIView alloc] initWithFrame:CGRectMake(0, self.deviceHeight-70, self.deviceWidth, 70)];
    
    [self.bottomBarView setBackgroundColor:[UIColor colorWithRed:41.0/255.0 green:41.0/255.0 blue:42.0/255.0 alpha:1.0]];
    
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(85, 10, 150, 50)];
    
    logoView.image = [UIImage imageNamed:@"logo_icon.png"];
    
    [logoView setContentMode:UIViewContentModeScaleAspectFit];
    
    [self.bottomBarView addSubview:logoView];

    //[self.view addSubview:self.bottomBarView];
    
    //[self.view addSubview:self.barView];
    
}

#pragma --mark draws the main view

//draws the main view
-(void) drawStartView {
    
    self.startView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, deviceWidth, deviceHeight-70)];
    
    //InitialHelpView *initialHelpView = [[InitialHelpView alloc] initWithFrame:CGRectMake(0, 0, self.startView.frame.size.width, self.deviceHeight)];
    
    
    
    //[self.startView setBackgroundColor:[UIColor whiteColor]];
    
    //NSSting *imageName =[NSString string];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, self.deviceWidth, self.startView.frame.size.height)];
    
    //UIImage *img1 = [UIImage imageNamed:@"background.png"];
    //UIImage *img2 = [UIImage imageNamed:@"view_background.png"];
    
    backImg.image = [UIImage imageNamed:@"background.png"];
    
    //backImg.animationImages = [NSArray arrayWithObjects:img1, img2, nil];
    
    [self scalefarward];
    
    //backImg.animationDuration = 1.0;
    //backImg.animationRepeatCount = 0;
    //[backImg startAnimating];
    
    [self.startView setUserInteractionEnabled:YES];
    
    [self.startView addSubview:backImg];
    
    
    [self.view addSubview:self.startView];
    [self.startView addSubview:self.barView];
    [self.startView addSubview:self.bottomBarView];
    

    //draws the transparent menu icon for left menu.
    
    /*UIImageView *transparentmenuImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 140, 60)];
    
    transparentmenuImage.image = [UIImage imageNamed:@"transparentBar.png"];
    
    [transparentmenuImage setContentMode:UIViewContentModeScaleAspectFit];
    
    [transparentmenuImage setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tapTransparentMenu =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMenu:)];
    
    [transparentmenuImage addGestureRecognizer:tapTransparentMenu];
    
    [self.barView addSubview:transparentmenuImage];*/
    
    //draws the menu icon for left menu.
    
    UIImageView *menuImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, 32, 32)];
    
    menuImage.image = [UIImage imageNamed:@"menu.png"];
    
    [menuImage setContentMode:UIViewContentModeScaleAspectFit];
    
    [menuImage setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tapMenu =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMenu:)];
    
    [menuImage addGestureRecognizer:tapMenu];
    
    [self.barView addSubview:menuImage];
    
    //[self drawRightMenuView];
    
    
    //start button to start the inspection of the rooms.
    startButton = [[UIImageView alloc] initWithFrame:CGRectMake(self.startView.frame.size.width/2.0-100, self.startView.frame.size.height/2.0-50, 200, 200)];
    
    startButton.image = [UIImage imageNamed:@"start.png"];
    [startButton.layer setCornerRadius:100.0];
    startButton.layer.masksToBounds = YES;
    [startButton setUserInteractionEnabled:YES];
    
    if(!self.toggleMenu && !self.toggleRightMenu) {
        UITapGestureRecognizer *startTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showCustomersView:)];
    
        [startButton addGestureRecognizer:startTap];
    }
    
    [self.startView addSubview:startButton];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 25, 200, 32)];
    
    [label setBackgroundColor:[UIColor clearColor]];
    
    [label setText:@""];
    [label setTextColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont fontWithName:@"Avenir-Medium" size:24]];
    
    [self.barView addSubview:label];
    
    [self setViewTitle];

    //draws the right menu.
    self.rightmenuView = [[RightMenuView alloc] initWithFrame:CGRectMake(0, -70, deviceWidth*0.75+5.0, deviceHeight+75)];

    [self.rightmenuView.view setHidden:YES];
    
    self.rightmenuView.view.transform = CGAffineTransformMakeTranslation(deviceWidth, 0);
    [self.view addSubview:self.rightmenuView.view];
    
    //[self checkReportStatus];
    
    /*if((isCustomerReportSent && !isEmployerReportSent)||(!isCustomerReportSent && isEmployerReportSent)) {
        

        reportListView = [[ReportsListView alloc] initWithFrame:CGRectMake(0, 0, self.startView.frame.size.width, self.startView.frame.size.height) withCustomerName:customerName withRoom:@"" showOtherButtons:YES];
        
        [self.startView addSubview:reportListView.view];
        
        [reportListView setViewTitle];
        
        reportListView.view.transform = CGAffineTransformMakeTranslation(320, 70);

        
        id animation = ^{
            
           reportListView.view.transform = CGAffineTransformMakeTranslation(0, 70);
            
        };
        
        
        [UIView animateWithDuration:0.5 animations:animation];
        


    }*/

    
    /*[startButton setBackgroundColor:[UIColor whiteColor]];
    
    [startButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    [startButton.layer setBorderWidth:0.5];
    
    [startButton setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *startTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showCustomersView:)];
    
    [startButton addGestureRecognizer:startTap];
    
    [self.startView addSubview:startButton];
    
    
    UILabel *startText = [[UILabel alloc] initWithFrame:CGRectMake(50, 15, 100, 50)];
    
    [startText setText:@"Start"];
    [startText setTextColor:[UIColor colorWithRed:0.0 green:(191.0/255.0) blue:1.0 alpha:1.0]];
    
    [startButton addSubview:startText];*/
    
    //[self.startView addSubview:initialHelpView];
    
    
}

#pragma --mark moves the backword image forward and backward

//move the background image forward
-(void) scalefarward {
    
    
    
    isforwardScale = YES;
    
    anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    anim.delegate = self;
        
    anim.fromValue = [NSNumber numberWithFloat:1.0f];
    anim.toValue = [NSNumber numberWithFloat:2.0f];
    anim.duration = 25.0; // Speed
    
    
    anim.removedOnCompletion = NO;
    
    anim.fillMode = kCAFillModeBoth;
    
    [backImg.layer addAnimation:anim forKey:@"scale"];
}

//moves the background moves backward
-(void) scalebackward {
    
    isforwardScale = NO;
    anim1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
    anim1.fromValue = [NSNumber numberWithFloat:2.0f];
    anim1.toValue = [NSNumber numberWithFloat:1.0f];
    anim1.duration = 25.0; // Speed
    anim1.delegate = self;
    
    anim1.removedOnCompletion = NO;
    
    anim1.fillMode = kCAFillModeBoth;
    
    [backImg.layer addAnimation:anim1 forKey:@"scale"];
    
}

//resets the right menu
-(void) resetMenuView {
    
    UIImageView *menuImage = (UIImageView *)[[self.barView subviews] objectAtIndex:0];
    
    menuImage.image = [UIImage imageNamed:@"menu.png"];
    
    [menuImage setContentMode:UIViewContentModeScaleAspectFit];
    
    [menuImage setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tapMenu =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMenu:)];
    
    [menuImage addGestureRecognizer:tapMenu];

    self.toggleMenu = ! self.toggleMenu;
}

//resets the menu labels
-(void) resetMenuLabels {
    
    [self.menuView resetLabels];
    
    
}

//resets the logoview
-(void) setViewTitle {
    
    /*UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 25, 200, 32)];
    
    [label setBackgroundColor:[UIColor clearColor]];
    
    [label setText:@""];
    [label setText:@"Optiqo Inspect"];
    [label setTextColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont fontWithName:@"Avenir-Medium" size:24]];
    
    [self.barView addSubview:label];*/
    
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 20, 150, 50)];
    
    logoView.image = [UIImage imageNamed:@"optiqo_icon.png"];
    
    [logoView setContentMode:UIViewContentModeScaleAspectFit];
    
    [self.barView addSubview:logoView];

}

//draw the rightmenu
-(void) drawRightMenuView {
    
    UIImageView *rightmenuImage = [[UIImageView alloc] initWithFrame:CGRectMake(deviceWidth-50, 25, 32, 32)];
    
    rightmenuImage.image = [UIImage imageNamed:@"info.png"];
    
    [rightmenuImage setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tapRightMenu =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRightMenu:)];
    
    [rightmenuImage addGestureRecognizer:tapRightMenu];
    
    [self.barView addSubview:rightmenuImage];
    
    
}

#pragma --mark toggles left and right menu views

//toggels the left menu view
-(void) showMenu:(id) sender {
    
    //[startButton setUserInteractionEnabled:NO];
    
    
    self.toggleMenu = !self.toggleMenu;
    
    
    if(self.menuView == nil) {
        self.menuView = [[MenuView alloc] initWithFrame:CGRectMake(0, -70, deviceWidth*0.75, deviceHeight+75)];
        self.menuView.transform = CGAffineTransformMakeTranslation(-deviceWidth*0.75, 0);
        [self.view addSubview:self.menuView];
    }
    
    //NSLog(@"toggle menu in viewcontroller showview %d",self.toggleMenu);
    
    id animation;
    
    if(self.toggleMenu) {
        animation = ^{
        
            self.startView.transform = CGAffineTransformMakeTranslation(deviceWidth*0.75, 0);
            self.menuView.transform = CGAffineTransformMakeTranslation(0, 0);
            //[self.menuView setHidden:NO];
            [startButton setUserInteractionEnabled:YES];
        };
    }
    else {
        
        animation = ^{
            
            self.startView.transform = CGAffineTransformMakeTranslation(0, 0);
            self.menuView.transform = CGAffineTransformMakeTranslation(-self.menuView.frame.size.width, 0);
            //[self.menuView setHidden:YES];
        };
    }
    
    [UIView animateWithDuration:0.3 animations:animation];

    
}

//toggles the right menu view
-(void) showRightMenu:(id) sender {
    
    
    //[startButton setUserInteractionEnabled:NO];
    
    //[self checkReportStatus];
    
    /*if(isCustomerReportSent && !isEmployerReportSent) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Send employer report to back to main view" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }
    else if(isEmployerReportSent && !isCustomerReportSent) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Send customer report to back to main view" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }*/
    
    /*if(isCustomerReportSent || isEmployerReportSent)*/ {
    
       self.toggleRightMenu = !self.toggleRightMenu;
    
        //if(self.rightmenuView == NULL) {
        //self.rightmenuView = [[RightMenuView alloc] initWithFrame:CGRectMake(0, -70, 200, deviceHeight+75)];
        if([self.rightmenuView.view isHidden])
        {
            [self.rightmenuView.view setHidden:NO];
        }
        //self.rightmenuView.transform = CGAffineTransformMakeTranslation(deviceWidth, 0);
        //[self.view addSubview:self.rightmenuView];
        
        //[self.rightmenuView setBackgroundColor:[UIColor blackColor]];
    //}
    
        id animation;
    
        
    
        if(self.toggleRightMenu) {
            
            [self.rightmenuView setUserLanguage];
            
            animation = ^{
            
            self.startView.transform = CGAffineTransformMakeTranslation(-240, 0);
            self.rightmenuView.view.transform = CGAffineTransformMakeTranslation(deviceWidth-245, 0);
            //[self.menuView setHidden:NO];

            };
        }
        else {
        
            animation = ^{
                
                self.startView.transform = CGAffineTransformMakeTranslation(0, 0);
                self.rightmenuView.view.transform = CGAffineTransformMakeTranslation(deviceWidth, 0);
                //[self.menuView setHidden:YES];
            };
        }
    
        [UIView animateWithDuration:0.5 animations:animation];
    }
    
}

#pragma mark--shows the customer list view

-(void) showCustomersView:(id) sender {
    

    if(!self.toggleRightMenu) {
        
        [startButton setUserInteractionEnabled:YES];
        
        for(unsigned long i=[[self.barView subviews] count]-2;i>=1;i--) {
        
            id viewItem = [[self.barView subviews] objectAtIndex:i];
            [viewItem setHidden:YES];
        }
    
        if([self IsUser_EmployerInfoPresent]) {
            if(![[self.startView subviews] containsObject:self.customerList.view])
            {
                self.customerList = [[CustomersList  alloc] initWithFrame:CGRectMake(0, self.barView.frame.size.height, self.startView.frame.size.width,self.startView.frame.size.height-70)];
    
                self.customerList.view.transform = CGAffineTransformMakeTranslation(320, 0);
    
                [self.startView addSubview:self.customerList.view];
            
                //self.toggleMenu = YES;
        //}
    
                id animation = ^{
        
                   self.customerList.view.transform = CGAffineTransformMakeTranslation(0, 0);
                };
    
                [UIView animateWithDuration:0.5 animations:animation];
            }
            self.toggleMenu = YES;
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[labels valueForKey:@"message"] message:[labels valueForKey:@"user_employer_information"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            
            [alert show];
            
            self.toggleMenu = !self.toggleMenu;
        }
    }
    //self.customerList = [[CustomersList alloc] init];
    

}

#pragma mark--show menu selected views

//shows the user settings view
-(void) showUserView {
    
    /*self.profileView = [[ProfileView alloc] initWithFrame:CGRectMake(0, 50, self.deviceWidth,self.deviceHeight)];
     
     [self.startView addSubview:self.profileView];*/
    
    /*for(unsigned long i=[[self.barView subviews] count]-1;i>=1;i--) {
        
        id viewItem = [[self.barView subviews] objectAtIndex:i];
        [viewItem setHidden:YES];
    }*/
    
    //removes the profile view
    if(self.profileView)
        [self.profileView removeFromParentViewController];
    
    //sets the userv iwew
    self.userView = [[UserView alloc] initWithFrame:CGRectMake(0, 70, self.startView.frame.size.width,self.startView.frame.size.height-70)];
    
    [self.startView addSubview:self.userView.view];
    
    
    //toggles the left menu.
    [self showMenu:nil];
    
    
}

#pragma mark--shows profile view of company

-(void) showPorfileView {
    
    /*self.profileView = [[ProfileView alloc] initWithFrame:CGRectMake(0, 50, self.deviceWidth,self.deviceHeight)];
 
    [self.startView addSubview:self.profileView];*/
    
    /*for(unsigned long i=[[self.barView subviews] count]-1;i>=1;i--) {
        
        id viewItem = [[self.barView subviews] objectAtIndex:i];
        [viewItem setHidden:YES];
    }*/
    
    //userview is removed
    if(self.userView)
        [self.userView removeFromParentViewController];
    
    //profile view is added
    self.profileView = [[ProfileView alloc] initWithFrame:CGRectMake(0, self.barView.frame.size.height, self.startView.frame.size.width,self.startView.frame.size.height-70)];
    
    [self.profileView.view setUserInteractionEnabled:YES];
    
    [self.startView setUserInteractionEnabled:YES];
     
    [self.startView addSubview:self.profileView.scrollView];
    
    //toggle the menu view
    [self showMenu:nil];
    
    
}

#pragma mark--shows all old reports

-(void) showOldReports {
    
    
    //shows the old report view
    self.reports = [[ShowOldReportsView alloc] initWithFrame:CGRectMake(0, self.barView.frame.size.height, self.startView.frame.size.width,self.startView.frame.size.height)];
    
    [self.startView setUserInteractionEnabled:YES];
    
    [self.startView addSubview:reports.view];
    
    //toggle the menu view
    [self showMenu:nil];
    
}


#pragma mark --imagepicker delegate functions

-(void) startCamera:(UIImage *) image {
    
    //starts the camera view for taking user photo
    UIImagePickerController *pickImage = [[UIImagePickerController alloc] init];
    pickImage.sourceType = UIImagePickerControllerSourceTypeCamera;
    if(image==nil)
        pickImage.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    pickImage.showsCameraControls = YES;
    //[pickImage setAllowsEditing:YES];
    pickImage.delegate = self;
    
    cam_image = image;
    
    [self presentViewController:pickImage animated:YES completion:nil];
    
}

//starts the camera view for taking rooms photos
-(void) startCameraCommentRoom {
    
    UIImagePickerController *pickImage = [[UIImagePickerController alloc] init];
    pickImage.sourceType = UIImagePickerControllerSourceTypeCamera;
    pickImage.delegate = self;
    pickImage.allowsEditing = YES;
    [self presentViewController:pickImage animated:YES completion:nil];
    
}

//shows the image library
-(void) showImageLibrary {
    
    UIImagePickerController *pickImage = [[UIImagePickerController alloc] init];
    pickImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickImage.delegate = self;
    //pickImage.allowsEditing = YES;
    [self presentViewController:pickImage animated:YES completion:nil];
    
}

//shows the image library for image views
-(void) showImageLibrary:(UIScrollView *)scrollView {
    
    UIImagePickerController *pickImage = [[UIImagePickerController alloc] init];
    pickImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickImage.delegate = self;
    //pickImage.allowsEditing = YES;
    [self presentViewController:pickImage animated:YES completion:nil];
    
    profileScrollView = scrollView;
    
}


-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    UIImage *choosenImage = info[UIImagePickerControllerOriginalImage];
    
    //choosenImage = [UIImage imageWithCGImage:choosenImage.CGImage scale:choosenImage.scale orientation:UIImageOrientationLeftMirrored];
    
    //choosenImage = [UIImage imageWithCGImage:choosenImage.CGImage scale:choosenImage.scale orientation:UIImageOrientationUp];
    
    //UIImage *newImage = NULL;
    
    /*if (picker.cameraDevice == UIImagePickerControllerCameraDeviceFront) {
        CGSize imageSize = choosenImage.size;
        UIGraphicsBeginImageContextWithOptions(imageSize, YES, 1.0);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextRotateCTM(ctx, M_PI/2);
        CGContextTranslateCTM(ctx, 0, -imageSize.width);
        CGContextScaleCTM(ctx, imageSize.height/imageSize.width, imageSize.width/imageSize.height);
        CGContextDrawImage(ctx, CGRectMake(0.0, 0.0, imageSize.width, imageSize.height), choosenImage.CGImage);
        self.userView.profileImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.userView.profileImage.image = [UIImage imageWithCGImage:choosenImage.CGImage scale:choosenImage.scale orientation:UIImageOrientationLeftMirrored];
    }*/


    //takes the photo of the user and store as the image.
    if(!self.commentsRoom && !profileScrollView) {
        //self.userView.profileImage.image = newImage;
    
        NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@",@"Optiqo"]];
    
        UIGraphicsBeginImageContext(CGSizeMake(160,160));
        [choosenImage drawInRect:CGRectMake(0,0,160,160)];
    
        //if the image allready exsists remove it and write the new photo as image.
        if([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"profileImage"]]]) {
        
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"profileImage"]] error:nil];
        }
    
        [[NSFileManager defaultManager] createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:nil];
    
        NSData * fullSize = UIImageJPEGRepresentation(choosenImage, 1.0);
        [fullSize writeToFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"profileImage"]] atomically:YES];
    
        //set the current photo taken as profile image
        self.menuView.profileImage.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"profileImage"]]];
        [self.menuView.profileImage.layer setBorderWidth:0.5];
        
        [self.menuView.profileImage.layer setCornerRadius:50.0];

        self.menuView.profileImage.image = [UIImage imageWithCGImage:self.menuView.profileImage.image.CGImage scale:self.menuView.profileImage.image.scale orientation:UIImageOrientationLeftMirrored];
        [self.menuView.profileImage setContentMode:UIViewContentModeScaleAspectFill];

        self.userView.profileImage.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg",[NSString stringWithFormat:@"%@/%@",imagePath,@"profileImage"]]];
        [self.userView.profileImage.layer setBorderWidth:0.5];
        
        [self.userView.profileImage.layer setCornerRadius:50.0];
        
        self.userView.profileImage.image = [UIImage imageWithCGImage:self.menuView.profileImage.image.CGImage scale:self.menuView.profileImage.image.scale orientation:UIImageOrientationLeftMirrored];
        [self.userView.profileImage setContentMode:UIViewContentModeScaleAspectFill];

        
    }
    else if(self.commentsRoom){
    
        //self.commentsRoom.imageView.image = choosenImage;
        //set the current image to the room comments image galarry.
        UIImageView *roomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 125, 125)];
        //[roomView setBackgroundColor:[UIColor clearColor]];
        
        roomView.image = choosenImage;
        
        [self.commentsRoom addRoomImages:roomView];
        
            
        //[self.commentsRoom setImagePages];
    
        //[self.commentsRoom loadCurrentImage];
    }
    else {
        
        //if not image taken set as profile image.
        [self.profileView setLogoImageView:choosenImage];
    
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma --mark toogle and hide the left and right menu views
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    CGPoint location = [touch locationInView:touch.view];
    

    
    
    if((location.x>32 && location.x<140) && (location.y>10 && location.y<60) && ![self.startView.subviews containsObject:self.customerList.view] && ![self.reports.view.subviews containsObject:self.reports.reportListView.view] && [touch view]!=startButton)
    {
        
        [self showMenu:nil];
        
    }
    else if(/*self.toggleMenu*/ [touch view]!=[[self.barView subviews] objectAtIndex:0] && [touch view]!=startButton) {
        
        id animation = ^{
            
            //NSLog(@" data menu touch");
            
            self.startView.transform = CGAffineTransformMakeTranslation(0, 0);
            //[self.menuView setHidden:YES];
            self.menuView.transform = CGAffineTransformMakeTranslation(-self.menuView.frame.size.width, 0);
            self.toggleMenu = ! self.toggleMenu;
        };
        
        [UIView animateWithDuration:0.3 animations:animation];
        
        //[self showMenu:nil];
        
        //toggleMenu = !toggleMenu;
        
    }
    
    
    //NSLog(@"start menu view %d,%d",self.toggleRightMenu,!self.toggleRightMenu);
    if(self.toggleRightMenu) {
        
        id animation = ^{
            
            self.startView.transform = CGAffineTransformMakeTranslation(0, 0);
            self.rightmenuView.view.transform = CGAffineTransformMakeTranslation(self.deviceWidth, 0);
            //self.toggleRightMenu = !self.toggleRightMenu;
        };
        
        [UIView animateWithDuration:0.5 animations:animation];

    }
    
    
    //[self showMenu:nil];
}

#pragma mark--send email to customer

//sends a mail to the customer for some informtion
-(void) sendEmail:(NSString *)email {
    
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    
    
    NSArray *recipentsArray = [[NSArray alloc]initWithObjects:email, nil];
    [controller setToRecipients:recipentsArray];
    
    
    [controller setMessageBody:@" " isHTML:YES];
    
    if (controller){
        
        [self presentViewController:controller animated:YES completion:nil];
        
    }
    
    isSendMailCustomer = YES;
}


#pragma mark--send email to customer 
//send a mail to customer and employer
-(void) sendEmail:(NSArray *) filenames withPercent:(int)percent withMailAttrs:(NSMutableArray *) attrs {
    
    //sends a mail to the customer and employer with subject and an overview pdf attachment.
    
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;

    
    NSArray *recipentsArray = [[NSArray alloc]initWithObjects:[attrs objectAtIndex:0], nil];
    [controller setToRecipients:recipentsArray];
    
    NSString *subjectLine = nil;
    
    
    NSString *date_time = [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                           dateStyle:NSDateFormatterShortStyle
                                                           timeStyle:NSDateFormatterShortStyle];

    customerName = [attrs objectAtIndex:2];
    
    NSString *message = nil;
    
    //gets the user data from the database.
    [self.userView getData];
    
    //gets the employer data from the database.
    [self.profileView getData];
    
    [self.activityView removeFromSuperview];
    
    self.activityView = nil;
    
    //gets the employer body message.
    [self getEmployerEmailBody];
    
    //enters the condition when the customer report sent
    if(isCustomer)
    {
        
        if([self.customerLanguageSelected isEqualToString:@"Svenska"]) {
            
            labels = [self.englishLabels valueForKey:@"userswedishlabels"];
        }
        
        if([self.customerLanguageSelected isEqualToString:@"German"]) {
            
            labels = [self.englishLabels valueForKey:@"usergermanlabels"];
        }
        
        if([self.customerLanguageSelected isEqualToString:@"English"]) {
            
            labels = [self.englishLabels valueForKey:@"userenglishlabels"];
        }
        
        subjectLine = [NSString stringWithFormat:@"%@ %@ - %@",[labels valueForKey:@"customerMailMessageBody"],companyName,date_time];
        
        message = [NSString stringWithFormat:@"%@ %@",[labels valueForKey:@"customerMailMessageBody"],companyName];
        
        //message = [message stringByAppendingString:[self getEmployerEmailBody]];
        
        NSString *employerMessageBoby =  [NSString  stringWithFormat:@"<i>%@</i>",[self getEmployerEmailBody]];
        
        
        message = [message stringByAppendingString:[NSString stringWithFormat:@"<br><br>%@",employerMessageBoby]];
    }
    else
    {
        //enters the condition when the employer report sent
        
        if([self.customerLanguageSelected isEqualToString:@"Svenska"] || [self.userLanguageSelected isEqualToString:@"Swedish"]) {
            
            labels = [self.englishLabels valueForKey:@"userswedishlabels"];
        }
        
        if([self.customerLanguageSelected isEqualToString:@"German"]) {
            
            labels = [self.englishLabels valueForKey:@"usergermanlabels"];
        }
        
        if([self.customerLanguageSelected isEqualToString:@"English"]) {
            
            labels = [self.englishLabels valueForKey:@"userenglishlabels"];
        }
        
        subjectLine = [NSString stringWithFormat:@"%@ - %@ - %@",[labels valueForKey:@"employerMailSubjectLine"],customerName,date_time];
        
        //message = [self getEmployerEmailBody];
        
        message = [NSString stringWithFormat:@"%@ %@",[labels valueForKey:@"employerMailMessageBody"],[self getAppUserName]];
        
        //message = [message stringByAppendingString:[self getEmployerEmailBody]];
        
        NSString *employerMessageBoby =  [NSString  stringWithFormat:@"<i>%@</i>",[self getEmployerEmailBody]];
        
        
        message = [message stringByAppendingString:[NSString stringWithFormat:@"<br><br>%@",employerMessageBoby]];

    }
    
    [controller setSubject:subjectLine];
    
    
    
    [controller setMessageBody:message isHTML:YES];
    
    //NSLog(@"file name when sent %@",[filenames objectAtIndex:0]);

    if (controller){
     
        [self presentViewController:controller animated:YES completion:nil];
        [controller addAttachmentData:[NSData dataWithContentsOfFile:[filenames objectAtIndex:0]] mimeType:@"application/pdf" fileName:[filenames objectAtIndex:1]];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        
        //upadates the cutomer and employer report sent status
        if(!isSendMailCustomer)
            [self updateReportStatus];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    isSendMailCustomer = NO;
}

#pragma --mark update the report status of customer and employer

-(void) updateReportStatus {
    
    if([self.userLanguageSelected isEqualToString:@"Swedish"]) {
        
        labels = [self.englishLabels valueForKey:@"userswedishlabels"];
    }
    
    if([self.userLanguageSelected isEqualToString:@"German"]) {
        
        labels = [self.englishLabels valueForKey:@"usergermanlabels"];
    }
    
    if([self.userLanguageSelected isEqualToString:@"English"]) {
        
        labels = [self.englishLabels valueForKey:@"userenglishlabels"];
    }
    
    UIAlertView *alert;
    
    
    
    //alert dialog when cutomer report sent
    if(isCustomer)
    {
        alert = [[UIAlertView alloc] initWithTitle:[labels valueForKey:@"message"] message:[labels valueForKey:@"customerMailSent"] delegate:nil cancelButtonTitle:[labels valueForKey:@"ok"] otherButtonTitles:nil, nil];
        
    }
    else
    {
        //alert dialog when employer report sent
        alert = [[UIAlertView alloc] initWithTitle:[labels valueForKey:@"message"] message:[labels valueForKey:@"employerMailSent"] delegate:nil cancelButtonTitle:[labels valueForKey:@"ok"] otherButtonTitles:nil, nil];
    }
    [alert show];
    
    //updates the report status of the rooms sent to customer and employer
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CustomerRooms" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    //NSLog(@"customer name %@",customerName);
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(customerName =%@)",customerName];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    
    if(fetchObjects) {
        if([fetchObjects count]!=0) {
            for(int i=0;i<[fetchObjects count];i++) {
                userData = [fetchObjects objectAtIndex:i];
                
                if(isCustomer) {
                    
                    //updates the customer report status
                    NSNumber *custReportSent = [userData valueForKey:@"customerReportSent"];
                    NSNumber *empReportSent = [userData valueForKey:@"employerReportSent"];
                    
                    
                    if(![custReportSent boolValue] && ![empReportSent boolValue]) {
                        
                        //NSLog(@"entered customer report with \n");
                        
                        NSNumber *count = [userData valueForKey:@"numReportSent"];
                        int reportCount = [count intValue];
                        
                        reportCount++;
                        
                        
                        
                        count = [[NSNumber alloc] initWithInt:reportCount];
                        
                        [userData setValue:count forKey:@"numReportSent"];
                        
                        NSNumber *reportSent = [[NSNumber alloc] initWithBool:YES];
                        NSDate *date = [NSDate date];
                        [userData setValue:reportSent forKey:@"customerReportSent"];
                        [userData setValue:date forKey:@"reportSentTime"];
                        [self setCustomerReport];
                        
                        self.reportSentDate = date;
                        
                    }
                    else if(![custReportSent boolValue] && [empReportSent boolValue]) {
                        
                        
                        //NSLog(@"entered data1 with \n");
                        
                        //updates customer report status when allready employer report sent
                        
                        NSDate  *date = [userData valueForKey:@"reportSentTime"];
                        
                        NSString *date_string = [NSDateFormatter localizedStringFromDate:date
                                                                               dateStyle:NSDateFormatterShortStyle
                                                                               timeStyle:NSDateFormatterShortStyle];
                        
                        NSString *date_time = [NSString stringWithFormat:@"%@",date_string];
                        
                        
                        NSString *sent_string = [NSDateFormatter localizedStringFromDate:self.reportSentDate
                                                                               dateStyle:NSDateFormatterShortStyle
                                                                               timeStyle:NSDateFormatterShortStyle];
                        
                        NSString *sentdate_time = [NSString stringWithFormat:@"%@",sent_string];
                        
                        if([date_time isEqualToString:sentdate_time])
                        {
                            
                            NSNumber *count = [userData valueForKey:@"numReportSent"];
                            int reportCount = [count intValue];
                            
                            reportCount++;
                            
                            
                            
                            count = [[NSNumber alloc] initWithInt:reportCount];
                            
                            [userData setValue:count forKey:@"numReportSent"];
                            
                            NSNumber *reportSent = [[NSNumber alloc] initWithBool:YES];
                            [userData setValue:reportSent forKey:@"customerReportSent"];
                            [self setCustomerReport];
                        }
                        else
                        {
                            NSNumber *count = [userData valueForKey:@"numReportSent"];
                            int reportCount = [count intValue];
                            
                            reportCount++;
                            
                            
                            
                            count = [[NSNumber alloc] initWithInt:reportCount];
                            
                            [userData setValue:count forKey:@"numReportSent"];
                            
                            NSNumber *reportSent = [[NSNumber alloc] initWithBool:YES];
                            [userData setValue:reportSent forKey:@"customerReportSent"];
                            [self setCustomerReport];
                        }
                        
                    }
                    
                    
                }
                else {
                    
                    //updates employer report status
                    NSNumber *custReportSent = [userData valueForKey:@"customerReportSent"];
                    NSNumber *empReportSent = [userData valueForKey:@"employerReportSent"];
                    
                    if(![empReportSent boolValue] && ![custReportSent boolValue]) {
                        
                        NSNumber *count = [userData valueForKey:@"numReportSent"];
                        int reportCount = [count intValue];
                        
                        reportCount++;
                        
                        count = [[NSNumber alloc] initWithInt:reportCount];
                        
                        [userData setValue:count forKey:@"numReportSent"];
                        
                        NSNumber *reportSent = [[NSNumber alloc] initWithBool:YES];
                        NSDate *date = [NSDate date];
                        [userData setValue:reportSent forKey:@"employerReportSent"];
                        [userData setValue:date forKey:@"reportSentTime"];
                        [self setEmployerReport];
                        
                        self.reportSentDate = date;
                    }
                    else if(![empReportSent boolValue] && [custReportSent boolValue])
                    {
                        
                        //NSLog(@"entered data2 with \n");
                        
                        //updates employer report status when allready customer report sent
                        
                        NSDate  *date = [userData valueForKey:@"reportSentTime"];
                        
                        NSString *date_string = [NSDateFormatter localizedStringFromDate:date
                                                                               dateStyle:NSDateFormatterShortStyle
                                                                               timeStyle:NSDateFormatterShortStyle];
                        
                        NSString *date_time = [NSString stringWithFormat:@"%@",date_string];
                        
                        
                        NSString *sent_string = [NSDateFormatter localizedStringFromDate:self.reportSentDate
                                                                               dateStyle:NSDateFormatterShortStyle
                                                                               timeStyle:NSDateFormatterShortStyle];
                        
                        NSString *sentdate_time = [NSString stringWithFormat:@"%@",sent_string];
                        
                        //NSLog(@" dates %@,%@ ",date_time,sentdate_time);
                        
                        if([date_time isEqualToString:sentdate_time])
                        {
                            
                            NSNumber *count = [userData valueForKey:@"numReportSent"];
                            int reportCount = [count intValue];
                            
                            reportCount++;
                            
                            count = [[NSNumber alloc] initWithInt:reportCount];
                            
                            [userData setValue:count forKey:@"numReportSent"];
                            
                            NSNumber *reportSent = [[NSNumber alloc] initWithBool:YES];
                            [userData setValue:reportSent forKey:@"employerReportSent"];
                            [self setEmployerReport];
                        }
                        else
                        {
                            NSNumber *count = [userData valueForKey:@"numReportSent"];
                            int reportCount = [count intValue];
                            
                            reportCount++;
                            
                            count = [[NSNumber alloc] initWithInt:reportCount];
                            
                            [userData setValue:count forKey:@"numReportSent"];
                            
                            NSNumber *reportSent = [[NSNumber alloc] initWithBool:YES];
                            [userData setValue:reportSent forKey:@"employerReportSent"];
                            [self setEmployerReport];
                        }
                    }
                    
                    
                }
                //data save to database
                [dataContext save:&error];
                
            }
        }
    }

}

//set auto rotation to no
- (BOOL)shouldAutorotate
{
    return NO;
}

//restrict the view to potrait mode
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//setting supported interface
- (NSUInteger)supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskPortrait;
}

- (void)animationDidStart:(CAAnimation *)theAnimation {
    
    
}

//toggle between the forward and backward moving of bacground view
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    
    
    if(isforwardScale) {
        
        [self scalebackward];
    }
    else {
        
        [self scalefarward];
    }
}

#pragma mark--fetches data from database

//fetches language stored by user from database
-(void) getData {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    NSError *error;
    
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    if(fetchObjects) {
        
        
        
        for(int i=0;i<[fetchObjects count];i++) {
            
            userData = [fetchObjects objectAtIndex:i];
            
            self.userLanguageSelected  = [userData valueForKey:@"language"];
            
            
        }
        
        //first time when the user starts the app, the language is taken from user device language
        if([fetchObjects count]==0) {
            
            
            NSString * deviceLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
            
            if([deviceLanguage isEqualToString:@"en"]) {
                
                self.userLanguageSelected = @"English";
                
            } else if([deviceLanguage isEqualToString:@"sv"]) {
                
                self.userLanguageSelected = @"Swedish";
                
            } else {
                
                self.userLanguageSelected = @"English";
                
            }
           
            self.userLanguageSelected = @"English";

        }
    }
    else {
        
        
        NSString * deviceLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
        
        if([deviceLanguage isEqualToString:@"en"]) {
            
            self.userLanguageSelected = @"English";
            
        } else if([deviceLanguage isEqualToString:@"sv"]) {
            
            self.userLanguageSelected = @"Swedish";
            
        } else {
            
            self.userLanguageSelected = @"English";
            
        }

        self.userLanguageSelected = @"English";
    }
    
    
    
    
}

#pragma mark--get report data from customer 

//gets the report status. To whom the reports allready sent
-(void) getReportData {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    NSError *error;
    
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    
    
    if(fetchObjects) {
        
        for(int i=0;i<[fetchObjects count];i++) {
            userData = [fetchObjects objectAtIndex:i];
            
            //reads the current report status of customer and employer.
            NSNumber *custReport = [userData valueForKeyPath:@"customerReportSent"];
            NSNumber *empReport = [userData valueForKeyPath:@"employerReportSent"];
            
            if([custReport boolValue] && [empReport boolValue]) {
            
                continue;
            }
            
            
            if(![custReport boolValue]) {
            
                isCustomerReportSent = [custReport boolValue];
                isEmployerReportSent = [empReport boolValue];
                
                break;
            }
            
            if(![empReport boolValue]) {
                
                isCustomerReportSent = [custReport boolValue];
                isEmployerReportSent = [empReport boolValue];
                
                break;
            }
            
            
        }
    }
    else {
        
        isReportSent = NO;
    }
    
    if(isCustomerReportSent && isEmployerReportSent)
        isReportSent = NO;

}

#pragma mark--gets app username and employer message
//gets the user information from database.
-(NSString *) getAppUserName {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    NSError *error;
    
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    NSString *userName = nil;
    
    if(fetchObjects) {
        
        if([fetchObjects count]!=0)
        {
            for(int i=0;i<[fetchObjects count];i++) {
                
                userData = [fetchObjects objectAtIndex:i];
                userName = [NSString stringWithFormat:@"%@ %@",[userData valueForKey:@"userFirstName"],[userData valueForKey:@"userLastName"]];
                return userName;
                
            }
        }
        
        
    }

    return userName;
}
//gets employer email body message from databse
-(NSString *) getEmployerEmailBody {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    NSError *error;
    
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    if(fetchObjects) {
        
        for(int i=0;i<[fetchObjects count];i++) {
            
            userData = [fetchObjects objectAtIndex:i];
            companyName = [userData valueForKey:@"companyName"];
            
            return [userData valueForKey:@"descriptionText"];
            
            
        }
    }
    
    return nil;
    
}

#pragma mark--set report true for customer and employer

-(void) setCustomerReport {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    //NSLog(@"customer name %@",customerName);
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(name =%@)",customerName];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    
    if(fetchObjects) {
        if([fetchObjects count]!=0) {
            for(int i=0;i<[fetchObjects count];i++) {
                userData = [fetchObjects objectAtIndex:i];
                
                NSNumber *reportSent = [[NSNumber alloc] initWithBool:YES];
                
                [userData setValue:reportSent forKey:@"customerReportSent"];

                [dataContext save:&error];
                
            }
        }
    }
}

//set report status for employer
-(void) setEmployerReport {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    //NSLog(@"customer name %@",customerName);
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(name =%@)",customerName];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    
    if(fetchObjects) {
        if([fetchObjects count]!=0) {
            for(int i=0;i<[fetchObjects count];i++) {
                userData = [fetchObjects objectAtIndex:i];
                
                NSNumber *reportSent = [[NSNumber alloc] initWithBool:YES];
                [userData setValue:reportSent forKey:@"employerReportSent"];
                [dataContext save:&error];
                
            }
        }
    }
}


//check the report status that is what reports are sent to customer and employer.
-(void) checkReportStatus {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    //NSPredicate *pred =[NSPredicate predicateWithFormat:@"(name = %@)",customerName];
    
    //[fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    
    if(fetchObjects) {
        
        for(int i=0;i<[fetchObjects count];i++) {
            userData = [fetchObjects objectAtIndex:i];
             //NSLog(@"entered customer data ");
            NSNumber *custNum = [userData valueForKey:@"customerReportSent"];
            NSNumber *empNum = [userData valueForKey:@"employerReportSent"];
            
            isCustomerReportSent = [custNum boolValue];
            isEmployerReportSent = [empNum boolValue];
            
            //NSLog(@"entered customer data %d,%d",isCustomerReportSent,isEmployerReportSent);
            
            if(isCustomerReportSent && !isEmployerReportSent) {
                //NSLog(@"entered customer data ");
                customerName = [userData valueForKey:@"name"];
                break;
            }
            
            if(!isCustomerReportSent && isEmployerReportSent) {
                //NSLog(@"entered customer data ");
                customerName = [userData valueForKey:@"name"];
                break;
            }
            
            if(isCustomerReportSent && isEmployerReportSent) {
                
                customerName = [userData valueForKey:@"name"];
                [self resetReportsStatus];
            }
            
        }
    }
}

//resets the report status in Customer table. 
-(void) resetReportsStatus {
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *dataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Customer" inManagedObjectContext:dataContext];
    
    [fetchData setEntity:entity];
    
    
    //NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData error:&error];
    
    NSManagedObject *userData = nil;
    
    //NSLog(@"customer name %@",customerName);
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(name =%@)",customerName];
    
    [fetchData setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *fetchObjects = [dataContext executeFetchRequest:fetchData
                                                       error:&error];
    
    if(fetchObjects) {
        if([fetchObjects count]!=0) {
            for(int i=0;i<[fetchObjects count];i++) {
                userData = [fetchObjects objectAtIndex:i];
                NSNumber *custReport = [userData valueForKey:@"customerReportSent"];
                NSNumber *empReport = [userData valueForKey:@"employerReportSent"];
                //NSLog(@"cutomer report bool value and employer report %d,%d",[custReport boolValue],[empReport boolValue]);
                if([custReport boolValue] && [empReport boolValue]) {
                    
                    custReport = [[NSNumber alloc] initWithBool:NO];
                    empReport = [[NSNumber alloc] initWithBool:NO];
                    
                    [userData setValue:custReport forKey:@"customerReportSent"];
                    [userData setValue:empReport forKey:@"employerReportSent"];
                    
                    [dataContext save:&error];
                }
                
                
                
            }
        }
    }
}

//check user or employer information present if not a alert is shown to add them
-(BOOL) IsUser_EmployerInfoPresent {
    
    
    BOOL isInfoPresent = NO;
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *userDataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *userFetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:userDataContext];
    
    [userFetchData setEntity:entity];
    
    NSError *error;
    
    NSArray *userFetchObjects = [userDataContext executeFetchRequest:userFetchData error:&error];
    
    
    
    if(userFetchObjects) {
        
        if([userFetchObjects count]!=0) {
            
            isInfoPresent = YES;
        }
        else
            return NO;
        
    }
    
    
    NSManagedObjectContext *employerDataContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *employerFetchData = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *employerEntity = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:employerDataContext];
    
    [employerFetchData setEntity:employerEntity];
    
    
    NSArray *employerFetchObjects = [employerDataContext executeFetchRequest:employerFetchData error:&error];
    
    
    if(employerFetchObjects) {
        
        if([employerFetchObjects count]!=0) {
            
            isInfoPresent = YES;
        }
        else
            return NO;
    }
    
    return isInfoPresent;
}

-(void) updatReportStatus {
    
}

#pragma mark--statusbar content color
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc {
    
    self.customerList = nil;
}

@end
