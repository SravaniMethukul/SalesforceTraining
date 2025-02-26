public class Demo {
    public static void demo1(){
        List<Opportunity> oppList = [Select Id,Name,AccountId From Opportunity
                                where AccountId!=null];
        List<String> strAccId = new List<String>();
        for(Opportunity opp:oppList){
            strAccId.add(opp.AccountId);
        }
        System.debug(strAccId);
        List<String> accNames = new List<String>();
        List<Account> accList1 = [Select Name From Account where Id In: strAccId];
       	for(Account acc:accList1)
        	System.debug(acc.Name);
    }
    
    public static void demo2(){
		//List<Account> accList = [Select Name from Account Where Id In:
         //                       (Select AccountId From Opportunity
         //                       where AccountId!=null)];
        
        List<Account> accList = [SELECT Name 
    							FROM Account 
    						    WHERE Id IN (
        						SELECT AccountId 
        						FROM Opportunity 
        						WHERE AccountId != null)];
        for(Account acc:accList)
        	System.debug(acc.Name);
    }
    
    public static void demo3(){
        List<Account> accList = [Select Id, Name, Industry, (Select Name, Amount From Opportunities Where ExpectedRevenue>2000) 
                                 From Account
                                 Where Id IN (Select AccountId 
                                              From Opportunity 
                                              Where Amount>2000)];
        for(Account acc:accList){
            System.debug(acc);
        }
    }
    
    public static void getAccountWithRelatedOpportunity(){
		List<Account> accList = [Select Name From Account where Id In 
                                (Select AccountId From Opportunity 
                                Where AccountId!=:null)];
        for(Account acc:accList)
            System.debug(acc.Name);
    }
    
    public static void demo4(){
        List<Opportunity> oppList = [Select Id, Name, Amount, StageName, closeDate
                                    From Opportunity
                                    Where (StageName='Closed Won' Or StageName='Closed Lost')
                                    And CloseDate = Last_90_Days];
        for(Opportunity o:oppList){
            System.debug(o.Id+' '+o.Name+' '+o.Amount+' '+o.StageName);
        }
    }
    
    public static void demo5(){
		List<Contact> conList = [Select FirstName,LastName,Email,Account.Name 
                                 From Contact
                                 Where Account.Industry = 'Banking'];
        for(Contact con:conList){
            System.debug(con.FirstName+' '+con.LastName+' '+con.Email+' '+con.Account.Name);
        }
    }
    //leads having duplicate emails
    public static void demo6(){
        List<AggregateResult> leadlist = [Select Count(Id) Total_Count, Email From Lead where email!=null Group By email Having Count(Id)>1];
        List<String> leademail = new List<String>();
        for(AggregateResult l:leadlist){
        	System.debug('Lead Email: '+l.get('Email')+' Lead Count: '+l.get('Total_Count'));
        	String str = (String)l.get('Email');
            leademail.add(str);
        }
        System.debug('Lead duplicate emails: '+leademail);
        List<Lead> leadnames = [Select Name From Lead Where email IN:leademail];
        for(Lead l:leadnames){
            System.debug('Lead Name: '+l.name);
        }
    }
    // Accounts having no Opportunity
    public static void demo7(){
		List<Opportunity> oppList = [Select Id, AccountId from Opportunity
                                    Where AccountId!=null];
        Set<String> accId = new Set<String>();
        for(Opportunity opp:oppList){
            accId.add(opp.AccountId);
        }
        List<Account> accList = [Select Id, Name From Account Where Id Not IN: accId];
        for(Account a:accList){
			System.debug('Id: '+a.Id+' Account Name: '+a.Name);
        }
    }
    //Demo: 8-Find Account records that have at least one Opportunity with an Amount over $50,000. 
    //Display Account Name and details of the related Opportunity (like Opportunity Id, Name, Amount).
    public static void demo8(){
        List<Account> acclist = [Select Id, Name, (Select Id, Name, Amount From Opportunities Where Amount>50000)
                                From Account
                                Where Id In (Select AccountId From Opportunity
                                                   Where Amount>50000 AND AccountId!=null)];
        for(Account acc:accList){
            	System.debug('Account Id: '+acc.Id+
                        ' Account Name: '+acc.Name);
            for(Opportunity opp:acc.Opportunities){
            	System.debug(' Opportunity: '+opp.Id+
                        ' Opp Name: '+opp.Name+
                        ' Opp Amount: '+opp.Amount);
            }
        }
    }
	//7. New Leads by Source
	//Get the count of new Leads created in the last 30 days for each lead source (LeadSource). 
	//Group the results by LeadSource.
    public static void demo9(){
        // Calculate the date 30 days ago from today
    	Date startDate = Date.today().addDays(-30);
		List<AggregateResult> leadlist = [Select Count(Id) Total_lead, LeadSource
                                         From Lead
                                         Where CreatedDate >: startDate AND LeadSource!=null
                                         Group By LeadSource];
        for(AggregateResult agg:leadlist){
            System.debug('Total Leads: '+agg.get('Total_Lead')
                        +' Lead Source: '+agg.get('LeadSource'));
        }
    }
    //8. Opportunities Closing Soon
	//List all Opportunities with a CloseDate in the next 15 days. 
	//Display Id, Name, Amount, CloseDate, and StageName.
    public static void demo10(){
        Date start_date = Date.today();
        Date end_date = Date.today().addDays(15);
        List<Opportunity> oppList = [Select Id, Name, Amount, CloseDate 
                                    From Opportunity
                                    Where CloseDate >:start_date AND CloseDate <: end_date];
        for(Opportunity o:oppList){
            System.debug('Opp Id: '+o.Id+' Name: '+o.Name+' Amount: '+o.Amount+' CloseDate: '+o.CloseDate);
        }
    }
    //10. Top 5 Opportunities by Amount
	//List the top 5 Opportunity records with the highest Amount. 
	//Display Opportunity Name, Amount, and CloseDate.
    public static void demo11(){
        List<Opportunity> oppList = [Select Id, Name, Amount, CloseDate 
                                    From Opportunity
                                    Where Amount!=null
                                    Order By Amount Desc
                                    Limit 5];
        for(Opportunity o:oppList){
            System.debug('Opp Id: '+o.Id+' Name: '+o.Name+' Amount: '+o.Amount+' CloseDate: '+o.CloseDate);
        }
    }
    //11. Active Subscriptions for Accounts
	//Retrieve Account records that have related active subscriptions 
	//(assume a custom object Subscription__c with fields AccountId, Status__c, and 
	//EndDate__c). Display Account Name and details of active subscriptions.
    public static void demo12(){
        List<Account> accList = [Select Id, Name, (Select Status__c, End_Date__c From
                                                  Subscriptions__r)
                                From Account
                                Where Id In (Select Account__c From Subscription__c
                                            Where Status__c='Active' and Account__c!=null)];
        for(Account a:accList){
			System.debug('Account Id: '+a.Id+' Name: '+a.Name);
            for(Subscription__c s:a.Subscriptions__r){
				System.debug('Subscription Status: '+s.Status__c+' End date '+s.End_Date__c);
            }
        }
    }
    //12. Campaign Performance
    //For each active campaign, retrieve the count of leads that were generated by that campaign in the past 60 days. 
    //Group the results by CampaignId.
    public static void demo13(){
		List<AggregateResult> campaignlist=[SELECT CampaignId, COUNT(LeadId) Total_Leads
                                       	   FROM CampaignMember 
                                       	   WHERE Campaign.Status = 'Active' AND CreatedDate >= LAST_N_DAYS:60 AND LeadId!=null
                                       	   GROUP BY CampaignId];
        for(AggregateResult c:campaignlist){
			System.debug('CampaignId: '+c.get('CampaignId')+' '+'Count of leads: '+c.get('Total_Leads'));
        }
    }
    //13. Open High-Priority Cases
	//Find all Cases marked as "High" priority that are still open (not "Closed").
	// Display the CaseNumber, Subject, Priority, Status, and Account.Name.
    public static void demo14(){
        List<Case> caselist = [Select CaseNumber, Subject, Priority, Status
                              From Case
                              Where Priority='High' AND Status!='Resolved'];
        for(Case c:caselist){
            System.debug('Case Number: '+c.CaseNumber+' Subject: '+c.Subject+
                         ' Priority: '+c.Priority+' Status: '+c.status);
		}
    }
    //14. Accounts and Contacts with Specific Titles.
    //Retrieve Accounts along with their Contacts where the contact's title is "Manager" or "Director". 
    //Display Account Name and Contact FirstName, LastName, and Title.
    public static void demo15(){
        List<Account> accList = [Select Id, Name, (Select FirstName, LastName, Title From Contacts 
                                                   Where (title Like '%Manager%' OR title Like '%Director%'))
                                From Account
                                WHERE Id IN (
            					SELECT AccountId 
            					FROM Contact 
            					WHERE (AccountId!=null AND title!=null) AND (Title LIKE '%Manager%' OR Title LIKE '%Director%')
        						)];
        //System.debug(accList);
        for(Account acc:accList){
            System.Debug('Account Name: '+acc.Name);
            if(!acc.Contacts.isEmpty()){
            	for(Contact con:acc.Contacts){
            		System.debug('First Name: '+con.FirstName);
            		System.debug('Last Name: '+con.LastName);
            		System.debug('Title: '+con.Title);
            	}
            }
        }
    }
    //15. Recently Updated Accounts
	//Retrieve all Accounts that were updated in the last 7 days. 
	//Display Account Id, Name, and LastModifiedDate.
    public static void demo16(){
        List<Account> accList = [Select Id,Name,LastModifiedDate
                                From Account
                                Where LastModifiedDate=LAST_MONTH];
        for(Account acc:accList){
            System.debug('Name: '+acc.Name+'LastModifiedDate: '+acc.LastModifiedDate);
        }
    }
    //16. Leads from Specific Campaigns
    //Get a list of Leads generated by campaigns named "Winter Sale" or 
    //"Spring Promotion." Display the Lead Name, Company, LeadSource, and CampaignId.
    public static void demo17(){
		List<CampaignMember> clist = [SELECT LeadId, Lead.FirstName, Lead.LastName, Lead.Company, Lead.LeadSource, CampaignId, Campaign.name
								FROM CampaignMember
								WHERE Campaign.IsActive = true
								AND LeadId != null AND (Campaign.Name Like '%Summer%' OR 
                                Campaign.Name Like '%Auto Fair%')];
        for(CampaignMember c:clist){
            System.debug('Lead Id: '+c.Campaign.name);
            System.debug('Lead Id: '+c.leadId);
            System.debug('Lead First Name: '+c.Lead.FirstName);
            System.debug('Lead Last Name: '+c.Lead.LastName);
            System.debug('Lead Company: '+c.Lead.Company);
            System.debug('Lead Source: '+c.Lead.LeadSource);
            System.debug('Campaign Id: '+c.CampaignId);
        }
    }
    
    //17. Closed-Won Opportunities for Each Account
	//For each Account, list only the Opportunities that were marked as "Closed Won".
	//Display Account Name, and related Opportunity Name, Amount, and CloseDate.
    public static void demo18(){
        List<Account> accList = [Select Name, (Select Name, Amount, CloseDate, StageName From Opportunities where StageName='Closed Won')
                                From Account
                                Where Id in (Select AccountId From Opportunity
                                            Where StageName='Closed Won' And AccountId!=null)];
        for(Account acc:accList){
            System.debug('Name: '+acc.Name);
            if(!acc.Opportunities.isEmpty()){
                for(Opportunity opp:acc.opportunities){
					System.debug('Opp Name: '+opp.Name);
                    System.debug('Amount: '+opp.Amount);
                    System.debug('Close Date: '+opp.CloseDate);
                    System.debug('Stage: '+opp.StageName);
                }
            }
        }
    }
    
    //18. Case Escalations
	//Retrieve a list of Cases where IsEscalated = TRUE. 
	//Display CaseNumber, Subject, Priority, and Status.
    public static void demo19(){
		List<Case> clist = [Select Id, Subject, Priority, Status
                           From Case
                           where IsEscalated=True];
        for(Case c:clist){
			System.debug('Case Number: '+c.Id);
            System.debug('Subject: '+c.subject);
            System.debug('Priority: '+c.priority);
            System.debug('Status: '+c.status);
        }
    }
    
    //19. Sales Pipeline by Stage
	//Get a count of Opportunities at each stage (e.g., "Prospecting", "Negotiation") for the current fiscal quarter. 
	//Group the results by StageName.
    
    public static void demo20(){
        List<AggregateResult> oppList = [Select Count(Id) Total_Count, StageName
                                    From Opportunity
                                    Where CreatedDate=THIS_FISCAL_QUARTER
                                    Group By StageName];
        for(AggregateResult a:oppList){
            System.debug('StageName: '+a.get('StageName'));
            System.debug('Total Opportunities count: '+a.get('Total_Count'));
        }
        
    }
    //20. Account Owners with Most Opportunities
	//Find the Account owners who have the highest number of associated Opportunities. 
	//Group the results by OwnerId and order by the count of opportunities in descending order.
    public static void demo21(){
		List<AggregateResult> aList = [Select Count(Id) Total_Opportunities, Account.OwnerId 
                                      From Opportunity
                                      where AccountId!=null
                                      Group By Account.OwnerId
                                      Order By Count(Id) Desc];
        for(AggregateResult a:aList){
            System.debug('Account Owner: '+a.get('OwnerId'));
            System.debug('Total Opportunities Count: '+a.get('Total_Opportunities'));
        }
        
    }
    
}