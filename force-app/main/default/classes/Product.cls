public class Product {
	integer product_Code1,product_Code2,product_Code3;
    string product_name1,product_name2,product_name3;
    decimal product_price1, product_price2, product_price3;
    decimal product_discount1,product_discount2,product_discount3;
    private integer product_stock1,product_stock2,product_stock3;
    
    public void get_Details_Of_Product(integer product_code, string product_name,decimal product_price,decimal product_discount,integer product_stock, integer product_no){
        if(product_no==1){
            product_Code1=product_code;
            product_name1=product_name;
            product_price1=product_price;
            product_discount1=product_discount;
            product_stock1=product_stock;
        }
        else if(product_no==2){
            product_Code2=product_code;
            product_name2=product_name;
            product_price2=product_price;
            product_discount2=product_discount;
            product_stock2=product_stock;
        }
        else if(product_no==3){
            product_Code3=product_code;
            product_name3=product_name;
            product_price3=product_price;
            product_discount3=product_discount;
            product_stock3=product_stock;
        }
        else{
            System.debug('----Invalid product number----');
        }
    }
    public void billing(integer quantity, integer product_code){
        
        decimal bill_amount=0;
        if(product_code==product_Code1)
        {
            if(product_stock1>=quantity){
                bill_amount=(product_discount1>0)?(quantity*(product_price1-(product_discount1/100))):(quantity*product_price1);
                product_stock1-=1;
                System.debug('product code: '+product_Code1);
                System.debug('product name: '+product_name1);
                System.debug('product price: '+product_price1);
                System.debug('product discount: '+product_discount1);
                System.debug('Total Bill Amount: '+bill_amount);
            }
            else{
                System.debug('The required number of quantity stock not available');
                System.debug('available stock is: '+product_stock1);
            }
        }
        else if(product_code==product_Code2)
        {
            if(product_stock2>=quantity){
                bill_amount=(product_discount2>0)?(quantity*(product_price2-(product_discount1/100))):(quantity*product_price2);
                product_stock2-=1;
                System.debug('product code: '+product_Code2);
                System.debug('product name: '+product_name2);
                System.debug('product price: '+product_price2);
                System.debug('product discount: '+product_discount2);
                System.debug('Total Bill Amount: '+bill_amount);
            }
            else{
                System.debug('The required number of quantity stock not available');
                System.debug('available stock is: '+product_stock2);
            }
        }
        else if(product_code==product_Code3)
        {
            if(product_stock3>=quantity){
                bill_amount=(product_discount3>0)?(quantity*(product_price3-(product_discount3/100))):(quantity*product_price3);
                product_stock3-=1;
                System.debug('product code: '+product_Code3);
                System.debug('product name: '+product_name3);
                System.debug('product price: '+product_price3);
                System.debug('product discount: '+product_discount3);
                System.debug('Total Bill Amount: '+bill_amount);
            }
            else{
                System.debug('The required number of quantity stock not available');
                System.debug('available stock is: '+product_stock3);
            }
        }
        else{
            System.debug('-----The Product code is not available.-----');
        }
    }
    
    public void searchByCode(integer product_code){
        if(product_code==product_Code1){
            System.debug('product name: '+product_name1);
            System.debug('product stock available: '+product_stock1);
        }
        else if(product_code==product_Code2){
            System.debug('product name: '+product_name2);
            System.debug('product stock available: '+product_stock2);
        }
        else if(product_code==product_Code3){
            System.debug('product name: '+product_name3);
            System.debug('product stock available: '+product_stock3);
        }
        else{
            System.debug('-----The Product code is not available to search.-----');
        }
    }
    
    public void reOrderProduct(){
        if(product_stock1>20 && product_stock2>20 && product_stock3>20){
            System.debug('----No products needs to be re-ordered-----');
        }
        else{
            System.debug('------List of products to be reordered------');
            System.debug('----products needed to be restocked details below-----');
            if(product_stock1<=20){
                searchByCode(product_Code1);
            }
            if(product_stock2<=20){
                searchByCode(product_Code2);
            }
            if(product_stock3<=20){
                searchByCode(product_Code3);
            }
        }
    }
}