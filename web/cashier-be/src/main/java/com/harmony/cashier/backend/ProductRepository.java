package com.harmony.cashier.backend;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRepository extends JpaRepository<ProductEntry, Long> {

}
