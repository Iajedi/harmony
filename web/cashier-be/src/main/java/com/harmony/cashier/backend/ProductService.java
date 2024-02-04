package com.harmony.cashier.backend;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Service;

import java.net.http.HttpResponse;
import java.util.concurrent.ExecutionException;

// CRUD operations
@Service
public class ProductService {
    public static final String COL_NAME = "products";

    public Product getProductDetails(String barcodeID) throws
            InterruptedException, ExecutionException {
        Firestore dbFirestore = FirestoreClient.getFirestore();
        ApiFuture<DocumentSnapshot> future = dbFirestore.collection(COL_NAME).document(barcodeID).get();
        DocumentSnapshot document = future.get();
        if (document.exists()) {
            return document.toObject(Product.class);
        } else {
            return null;
        }
    }

//    public int uploadProducts(String barcodeID) throws
//            InterruptedException, ExecutionException {
//        Firestore dbFirestore = FirestoreClient.getFirestore();
//        ApiFuture
//    }

}