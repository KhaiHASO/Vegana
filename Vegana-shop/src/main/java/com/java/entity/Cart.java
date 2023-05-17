package com.java.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "carts")
public class Cart {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int cartId;
    private String customerId;
    private int productId;
    private int quantity;
    private double price;

    public Cart(String customerId, int productId, int quantity, double price) {
        this.customerId = customerId;
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
    }

}
