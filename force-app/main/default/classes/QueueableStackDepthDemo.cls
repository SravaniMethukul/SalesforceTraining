public class QueueableStackDepthDemo implements Queueable{
    public void execute(QueueableContext cxt){
        System.debug('Current Depth: '+AsyncInfo.getCurrentQueueableStackDepth());
        System.debug('Maximum stack:'+AsyncInfo.getMaximumQueueableStackDepth());
        if(AsyncInfo.hasMaxStackDepth() && 
           AsyncInfo.getCurrentQueueableStackDepth()<AsyncInfo.getMaximumQueueableStackDepth()){
        	System.enqueuejob(new QueueableStackDepthDemo());
        }
    }
}

/*AsyncOptions asy = new AsyncOptions();
asy.MaximumQueueableStackDepth = 10;
System.enqueuejob(new QueueableStackDepthDemo(), asy);*/