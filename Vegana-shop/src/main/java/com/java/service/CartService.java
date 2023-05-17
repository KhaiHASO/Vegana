package com.java.service;

import com.java.entity.Cart;
import com.java.entity.CartProductViewDTO;


import java.util.Collection;
import java.util.List;
import java.util.Optional;

public interface CartService {
    Cart saveCart(Cart cart);
    Collection<Cart> getAllCarts();
    Optional<Cart> getCartById(int id);
    List<Cart> getCartsByCustomerId(String customerId);
    Cart updateCart(Cart cart, int id);
    void deleteByCustomerIdAndProductId(String customerId, Integer productId);
    void updateCart(CartProductViewDTO cartProductViewDTO);
    void emptyCart(String customerId);

}
