public class SuperMarket {
	public List<ProductCollection> prodList = new List<ProductCollection>();
    
    public void displayProduct(ProductCollection p){
        System.debug('product name: '+p.product_name);
        System.debug('product stock available: '+p.product_stock);
    }
    
    public void billing(integer product_code, integer quantity){
        for(ProductCollection p:prodList)
        {
            if(p.product_code==product_code){
        		if(p.product_stock>=quantity){
        			decimal bill_amount=(p.product_discount>0)?(quantity*(p.product_price-(p.product_discount/100))):(quantity*p.product_price);
        			p.product_stock-=1;
        			System.debug('product code: '+p.product_code);
        			System.debug('product name: '+p.product_name);
        			System.debug('product price: '+p.product_price);
        			System.debug('product discount: '+p.product_discount);
        			System.debug('Total Bill Amount: '+bill_amount);
        		}
        		else{
            		System.debug('---- Product stock unavailable-----');
        		}
            }
        }
    }
    
    public void reOrderProduct(){
        for(ProductCollection p:prodList){
        	if(p.product_stock>20){
            	System.debug('----No products needs to be re-ordered-----');
        	}
        	else{
            	System.debug('----products needed to be restocked details below-----');
            	displayProduct(p);
        	}
        }
    }
}