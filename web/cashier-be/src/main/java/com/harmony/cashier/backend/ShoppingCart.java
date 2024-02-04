package com.harmony.cashier.backend;

import java.net.URISyntaxException;
import java.util.List;

public class ShoppingCart {

    private final ProductRepository repository;
    private final ProductService service;

    private final Purchase purchase;
    private double totalPrice;

    public ShoppingCart(ProductRepository repository, ProductService service) {
        this.repository = repository;
        this.service = service;
        this.purchase = new Purchase(repository, service);
    }

    public void addProduct(Product product) throws URISyntaxException {
//        purchase.createProduct(new ProductEntry(product.getBarcodeID(), product.getName(), product.getPrice()));
        totalPrice += product.getPrice();
    }

    public void removeProduct(Product product) {
//        purchase.deleteProduct(product.getBarcodeID());
        totalPrice -= product.getPrice();
    }

    /* Sent to Harmony to load cart details and update farm. */
    public List<ProductEntry> getCart() {
        return repository.findAll();
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    /* Should be called in CashierApplication */
    public Payment pay(ShoppingCart cart) {
        return new Payment(cart.getTotalPrice());
    }
}
