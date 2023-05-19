package com.java.service.impl;

import com.java.entity.Cart;
import com.java.entity.CartProductViewDTO;
import com.java.repository.CartRepository;
import com.java.service.CartService;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

@Service
public class CartServiceImpl implements CartService {

    private final CartRepository cartRepository;

    public CartServiceImpl(CartRepository cartRepository) {
        super();
        this.cartRepository = cartRepository;
    }

    @Override
    public Cart saveCart(Cart cart) {
        return cartRepository.save(cart);
    }

    @Override
    public Collection<Cart> getAllCarts() {
        return cartRepository.findAll();
    }

    @Override
    public Optional<Cart> getCartById(int id) {
        return cartRepository.findById(id);
    }

    @Override
    public List<Cart> getCartsByCustomerId(String customerId)
    {
        return cartRepository.getCartsByCustomerId(customerId);
    }

    @Override
    public Cart updateCart(Cart cart, int id) {
        Optional<Cart> existingCartOptional = cartRepository.findById(id);

        if (existingCartOptional.isPresent()) {
            Cart existingCart = existingCartOptional.get();
            existingCart.setCustomerId(cart.getCustomerId());
            existingCart.setProductId(cart.getProductId());
            existingCart.setQuantity(cart.getQuantity());

            return cartRepository.save(existingCart);
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Cart not found with Id: " + id);
        }
    }

    @Override
    public void deleteByCustomerIdAndProductId(String customerId, Integer productId) {
        cartRepository.deleteByCustomerIdAndProductId(customerId,productId);

    }


    @Override
    public void updateCart(CartProductViewDTO cartProductViewDTO) {
         cartRepository.updateCart(cartProductViewDTO);
    }

    @Override
    public void emptyCart(String customerId) {
        cartRepository.emptyCart(customerId);
    }




}
