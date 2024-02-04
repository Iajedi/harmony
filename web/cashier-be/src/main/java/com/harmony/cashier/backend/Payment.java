package com.harmony.cashier.backend;

public class Payment {

    private PaymentMethod method;
    private final double totalPrice;

    public Payment(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public void setMethod(PaymentMethod method) {
        this.method = method;
    }

    public void processPayment() {
        if (method == PaymentMethod.CARD) {
            System.out.println("Please tap or insert card: ");
            // CardReader.connect(totalPrice);
        } else {
            System.out.println("Please insert cash: £" + totalPrice);
        }
    }

}
