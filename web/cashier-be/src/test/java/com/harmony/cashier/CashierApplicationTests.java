package com.harmony.cashier;

import com.harmony.cashier.backend.Product;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class CashierApplicationTests {

    private final Product spinach = new Product(122370);
//    private final ShoppingCart cart = new ShoppingCart();

    @Test
    void contextLoads() {
    }

}
