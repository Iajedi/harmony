package com.harmony.cashier.backend;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;
import com.google.firebase.database.GenericTypeIndicator;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ExecutionException;

import static com.fasterxml.jackson.databind.type.LogicalType.Map;

@RestController
@RequestMapping("/purchase")
public class Purchase {
    private final ProductRepository repository;
    private final ProductService service;

    public Purchase(ProductRepository repository, ProductService service) {
        this.repository = repository;
        this.service = service;
    }

    @GetMapping
    public List<ProductEntry> getProducts() {
        return repository.findAll();
    }

    @GetMapping("/{id}")
    public ProductEntry getProduct(@PathVariable long id) {
        return repository.findById(id).orElseThrow(RuntimeException::new);
    }

    @DeleteMapping("/clear")
    public int clearRepository() {
        repository.deleteAll();
        return 200;
    }

    @GetMapping("/total")
    public double getTotal() {
        Optional<Double> result;
        result = getProducts().stream().map(ProductEntry::getPrice).reduce(Double::sum);
        if (result.isPresent()) {
            return result.get();
        }
        return 0;
    }

    // GETS THE THING FROM FIREBASE!!!!!
    @PostMapping("/{id}")
    public Product createProduct (@PathVariable long id) throws URISyntaxException {
        String query = String.valueOf(id);
        Product product;
        try {
            product = service.getProductDetails(query);
        } catch (InterruptedException | ExecutionException e) {
            throw new RuntimeException(e);
        }
        ProductEntry entry = new ProductEntry(id, product.getName(), product.getPrice());
        repository.save(entry);
        return product;
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity deleteProduct(@PathVariable long id) {
        repository.deleteById(id);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/pay/{cid}")
    public ResponseEntity uploadPurchase(@PathVariable long cid) {
        ResponseEntity result;
        String query = String.valueOf(cid);
        try {
            result = service.getUserNutrition(query);
            if (result == null) {
                return ResponseEntity.notFound().build();
            }
            return result;
        } catch (ExecutionException | InterruptedException e) {
            throw new RuntimeException(e);
        }
    }
}
