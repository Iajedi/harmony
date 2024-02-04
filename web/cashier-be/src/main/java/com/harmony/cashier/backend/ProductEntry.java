package com.harmony.cashier.backend;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "product")
public class ProductEntry {

    @Id
    private long id;

    private String name;

    private double price;

    private long nutrition;

    public ProductEntry() {
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getId() {
        return id;
    }

    public double getPrice() {
        return price;
    }

    public String getName() {
        return name;
    }

    public ProductEntry(long id, String name, double price) {
        this.id = id;
        this.name = name;
        this.price = price;
    }
}
