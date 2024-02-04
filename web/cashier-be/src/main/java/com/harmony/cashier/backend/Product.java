package com.harmony.cashier.backend;


public class Product {

    private String category;
    private String name;
    private double price;
    private Nutrition nutrition;

    public Product() {

    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }

    public Nutrition getNutrition() {
        return nutrition;
    }

    public String getCategory() {
        return category;
    }
}
