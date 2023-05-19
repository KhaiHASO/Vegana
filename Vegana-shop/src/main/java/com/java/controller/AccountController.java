package com.java.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.java.entity.Customer;
import com.java.entity.Order;
import com.java.repository.CustomersRepository;
import com.java.repository.OrderRepository;

@Controller
public class AccountController extends CommonController {

	@Autowired
	CustomersRepository customersRepository;

	@Autowired
	OrderRepository orderRepository;


	@GetMapping(value = "/account")
	public String account(Model model, Principal principal) {

		model.addAttribute("customer", new Customer());
		Customer customer = customersRepository.FindByEmail(principal.getName()).get();
		model.addAttribute("customer", customer);

		List<Order> listO2 = orderRepository.findByCustomerId(customer.getCustomerId());
		model.addAttribute("orders2", listO2);

		return "site/account";
	}

}
