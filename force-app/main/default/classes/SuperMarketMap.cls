public class SuperMarketMap {
    public Map<integer, ProductCollection> maplist = new  Map<integer, ProductCollection>();
    final integer reOrderLevel = 20;
    public List<Integer> productsToRestock = new List<Integer>();
    integer flag = 0;
    public SuperMarketMap(){
        maplist.put(101, new ProductCollection(101,'Apple',60.0,15,10.0));
        maplist.put(102, new ProductCollection(102,'Banana',50.0,22,10.0));
        maplist.put(103, new ProductCollection(103,'Guava',40.0,19,15.0));
    }
    
    public void billing(integer product_code, integer quantity){
    	ProductCollection p = maplist.get(product_code);
        if(p.product_stock>=quantity){
        	decimal bill_amount=(p.product_discount>0)?(quantity*(p.product_price-(p.product_discount/100))):(quantity*p.product_price);
        	p.product_stock-=quantity;
        	System.debug('product code: '+p.product_code);
        	System.debug('product name: '+p.product_name);
        	System.debug('product price: '+p.product_price);
        	System.debug('product discount: '+p.product_discount);
        	System.debug('Total Bill Amount: '+bill_amount);
        }
        else{
            flag = 1;
            System.debug('---- Product stock unavailable-----');
        }
    }
    
    public void reOrderProduct(){
        for(ProductCollection p:maplist.values()){
            if(p.product_stock>reOrderLevel){
            	System.debug('----Product re stock not required-----');
        	}
        	else{
                flag = 1;
                productsToRestock.add(p.product_code);
            	System.debug('----products needed to be restocked details below-----');
        	}
            displayProduct(p);
        }
    }
    
    @TestVisible
    private void displayProduct(ProductCollection p){
        system.debug('product name: '+p.product_name);
        system.debug('product stock: '+p.product_stock);
        system.debug('product code: '+p.product_code);
    }
    
}