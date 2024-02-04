package com.harmony.cashier.backend;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;
import com.google.firebase.database.GenericTypeIndicator;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
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

    private double updateAverage(double prev, double curr, int numPurchases) {
        return prev * numPurchases / (1 + numPurchases) + curr / numPurchases;
    }

    public ResponseEntity getUserNutrition(String userID) throws
            InterruptedException, ExecutionException {
        Firestore dbFirestore = FirestoreClient.getFirestore();
        ApiFuture<DocumentSnapshot> future = dbFirestore.collection("users").document(userID).get();
        DocumentSnapshot document = future.get();
        if (document.exists()) {
            User result = document.toObject(User.class);
            Nutrition nutrition = result.getNutritionData();
            int newEnergy = 200;
            double newCarbs = 50.0;
            double newFat = 20.0;
            double newProtein = 10.0;
            nutrition.setEnergy((int) updateAverage(nutrition.getEnergy(), newEnergy, result.getNum_purchases()));
            nutrition.setCarbs(updateAverage(nutrition.getCarbs(), newCarbs, result.getNum_purchases()));
            nutrition.setFat(updateAverage(nutrition.getFat(), newFat, result.getNum_purchases()));
            nutrition.setEnergy((int) updateAverage(nutrition.getProtein(), newProtein, result.getNum_purchases()));
            dbFirestore = FirestoreClient.getFirestore();
            ApiFuture<WriteResult> writeResult =
                    dbFirestore.collection("users").document(userID).set(result);
            if (writeResult.isDone()) {

                return ResponseEntity.ok().build();
            }
        }
        return null;
    }

}