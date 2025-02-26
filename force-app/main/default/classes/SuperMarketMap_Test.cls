@isTest
public class SuperMarketMap_Test {
        
    @isTest
    public static void Test_billing(){
        SuperMarketMap s = new SuperMarketMap();
        integer productCode = 101;
        integer quantity = 14;
        // for in stock product
        integer initialStock = s.maplist.get(productCode).product_stock;
        s.billing(productCode, quantity);
        integer newStock = s.maplist.get(productCode).product_stock;
        System.assertEquals(initialStock - quantity, newStock, 
                            'The product stock should be decreased by the billed quantity');
        // for out of stock product
        productCode = 102;
        quantity = 25;
        integer initialstock1 = s.maplist.get(productCode).product_stock;
        s.billing(productCode, quantity);
        integer newstock1 = s.maplist.get(productCode).product_stock;
        System.assertEquals(initialstock1, newstock1, 
                           'Stock should remain the same as billing quantity exceeds stock');
        s.reOrderProduct();
        List<Integer> expectedProductsToRestock = new List<Integer>{101, 103};
        System.assertEquals(expectedProductsToRestock, s.productsToRestock, 
            'The productsToRestock list should include the correct product codes for restocking.');
    }
}