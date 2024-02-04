package com.harmony.cashier.backend;

public class Nutrition {

    private int energy; // kcal
    private double fat; // g
    private double carbs; // g
    private double protein; // g

    public Nutrition() {
    }

    public int getEnergy() {
        return energy;
    }

    public double getFat() {
        return fat;
    }

    public double getCarbs() {
        return carbs;
    }

    public double getProtein() {
        return protein;
    }

    public void setEnergy(int energy) {
        this.energy = energy;
    }

    public void setFat(double fat) {
        this.fat = fat;
    }

    public void setCarbs(double carbs) {
        this.carbs = carbs;
    }

    public void setProtein(double protein) {
        this.protein = protein;
    }
}
