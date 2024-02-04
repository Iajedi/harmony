package com.harmony.cashier.backend;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.concurrent.ExecutionException;

@RestController
public class ProductController {

    final
    ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/getProductDetails")
    public Product getProduct(@RequestParam String barcodeID) throws
            InterruptedException, ExecutionException {
        return productService.getProductDetails(barcodeID);
    }
}
