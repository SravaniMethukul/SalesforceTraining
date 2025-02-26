public class ProductCollection {
    public integer product_code, product_stock;
    public string product_name;
    public decimal product_price, product_discount;
    public ProductCollection(integer code, string name, decimal price, integer stock, decimal discount){
        this.product_code = code;
        this.product_name = name;
        this.product_price = price;
        this.product_stock = stock;
        this.product_discount = discount;
    }
}