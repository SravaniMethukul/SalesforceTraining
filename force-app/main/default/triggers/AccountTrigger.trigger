trigger AccountTrigger on Account (before insert, after insert,before update,after update, before delete, after delete, after undelete) {
    Switch On Trigger.OperationType{
        When Before_Insert{
            //AccountTriggerHandler.beforeInsert(Trigger.new);
        }
        When After_Insert{
            //AccountTriggerHandler.createContactOnNumberOfLocations(Trigger.new);
            
        }
        When Before_Update{
            //AccountTriggerHandler.beforeUpdate(Trigger.new);
        }
        When After_Update{
       		//AccountTriggerHandler.createContactOnNumberOfLocations(Trigger.new);
       		//AccountTriggerHandler.updatePhoneNumberOnContact(Trigger.new, Trigger.OldMap);
        }
        
        When Before_Delete{
      		//AccountTriggerHandler.preventUserFromDeletingAccount(Trigger.old);
            AccountTriggerHandler.updateAccountRecordOnopenOpporOpenCase(Trigger.Old);
        }
        
        When After_Undelete{
         
        }
    }
}