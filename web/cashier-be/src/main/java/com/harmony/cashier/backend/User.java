package com.harmony.cashier.backend;

public class User {
    private int age;
    private String gender;
    private long membership_no;
    private String name;
    private int num_purchases;
    private Nutrition nutritionData;
    private int weight;

    public User() {

    }

    public User(int age, String gender, long membership_no, String name, int num_purchases, Nutrition nutritionData, int weight) {
        this.age = age;
        this.gender = gender;
        this.membership_no = membership_no;
        this.name = name;
        this.num_purchases = num_purchases;
        this.nutritionData = nutritionData;
        this.weight = weight;
    }

    public int getAge() {
        return age;
    }

    public String getGender() {
        return gender;
    }

    public long getMembership_no() {
        return membership_no;
    }

    public String getName() {
        return name;
    }

    public int getNum_purchases() {
        return num_purchases;
    }

    public Nutrition getNutritionData() {
        return nutritionData;
    }

    public int getWeight() {
        return weight;
    }
}
