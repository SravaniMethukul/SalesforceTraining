public class ProductUsingConstructor {
	integer product_code, product_stock, product_no;
    string product_name;
    decimal product_price, product_discount;
    
    public ProductUsingConstructor(integer product_code, string product_name,decimal product_price,decimal product_discount,integer product_stock, integer product_no){
        this.product_code = product_code;
        this.product_name = product_name;
        this.product_price = product_price;
        this.product_discount=product_discount;
        this.product_stock = product_stock;
        this.product_no = product_no;
    }
    
    public void displayProduct(){
        System.debug('product name: '+this.product_name);
        System.debug('product stock available: '+this.product_stock);
    }
    
    public void billing(integer quantity){
        if(product_stock>=quantity){
        	decimal bill_amount=(product_discount>0)?(quantity*(product_price-(product_discount/100))):(quantity*product_price);
        	product_stock-=1;
        	System.debug('product code: '+product_code);
        	System.debug('product name: '+product_name);
        	System.debug('product price: '+product_price);
        	System.debug('product discount: '+product_discount);
        	System.debug('Total Bill Amount: '+bill_amount);
        }
        else{
            System.debug('---- Product stock unavailable-----');
            reOrderProduct();
        }
    }
    
    public void reOrderProduct(){
        if(product_stock>20){
            System.debug('----No products needs to be re-ordered-----');
        }
        else{
            System.debug('----products needed to be restocked details below-----');
            displayProduct();
        }
    }
}