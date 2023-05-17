package com.java.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import com.java.entity.*;
import com.java.repository.*;
import com.java.service.CartService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import com.java.service.SendMailService;
import com.java.service.ShoppingCartService;
import com.java.service.WishListService;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class ShoppingCartController extends CommonController {

	@Autowired
	ProductRepository productRepository;

	@Autowired
	OrderRepository orderRepository;

	@Autowired
	OrderDetailRepository orderDetailRepository;

	@Autowired
	CustomersRepository customersRepository;

	@Autowired
	ShoppingCartService shoppingCartService;
	
	@Autowired
	WishListService wishListService;

	@Autowired
	SendMailService sendMailService;

	@Autowired
	HttpSession session;

	@Autowired
	CartRepository cartRepository;

	@Autowired
	CartService cartService;

	@Autowired
	CartProductViewRepository cartProductViewRepository;

	public ShoppingCartController(ProductRepository productRepository, OrderRepository orderRepository,
			OrderDetailRepository orderDetailRepository, ShoppingCartService shoppingCartService,
			CustomersRepository customersRepository, SendMailService sendMailService, WishListService wishListService) {
		this.productRepository = productRepository;
		this.orderRepository = orderRepository;
		this.orderDetailRepository = orderDetailRepository;
		this.shoppingCartService = shoppingCartService;
		this.customersRepository = customersRepository;
		this.sendMailService = sendMailService;
		this.wishListService = wishListService;
	}

/*	@GetMapping(value = "/carts")
	public String shoppingCart(Model model) {
		Collection<CartItem> cartItems = shoppingCartService.getCartItems();
		model.addAttribute("cartItems", cartItems);
		model.addAttribute("total", shoppingCartService.getAmount());
		double totalPrice = 0;
		for (CartItem cartItem : cartItems) {
			double price = cartItem.getQuantity() * cartItem.getProduct().getPrice();
			totalPrice += price - (price * cartItem.getProduct().getDiscount() / 100);
		}

		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("totalCartItemWishs", wishListService.getCount());
		model.addAttribute("totalCartItems", shoppingCartService.getCount());
		
		return "site/shoppingCart";
	}*/

	@GetMapping(value = "/carts")
	public String shoppingCart(Model model) {
		// Tải giỏ hàng từ cơ sở dữ liệu
		Collection<CartProductViewDTO> cartProductViewDTO = cartProductViewRepository.getCartProductViewByCustomerId("khai00");

		// Thêm giỏ hàng vào mô hình
		model.addAttribute("cartProductViewDTO", cartProductViewDTO);


		// Tính toán tổng giá trị giỏ hàng
		double thanhtien = 0;
		for (CartProductViewDTO cart : cartProductViewDTO) {
			double price = cart.getTotalPrice();
			thanhtien += price;
		}
		model.addAttribute("totalPrice", thanhtien);

		// Các thông tin khác (nếu cần)
		//model.addAttribute("totalCartItemWishs", wishListService.getCount());
	  //model.addAttribute("totalCartItems", shoppingCartService.getCount());

		return "site/shoppingCart";
	}


/*	@GetMapping(value = "/addToCart")
	public String add(@RequestParam("productId") Integer productId, @RequestParam("customerId") String customerId, HttpServletRequest request, Model model) {

		Product product = productRepository.findById(productId).orElse(null);
		session = request.getSession();
		Collection<CartItem> cartItems = shoppingCartService.getCartItems();
		if (product != null) {
			CartItem item = new CartItem();
			BeanUtils.copyProperties(product, item);
			item.setQuantity(1);
			item.setProduct(product);
			item.setProductId(productId);
			item.setCustomerId(customerId);
			shoppingCartService.add(item);
		}
		session.setAttribute("cartItems", cartItems);
		model.addAttribute("totalCartItemWishs", wishListService.getCount());
		model.addAttribute("totalCartItems", shoppingCartService.getCount());

		return "redirect:/carts";
	}*/




	@GetMapping(value = "/addToCart")
	public String add(@RequestParam("productId") Integer productId, HttpServletRequest request, Model model) {

		Product product = productRepository.findById(productId).orElse(null);
		session = request.getSession();


		Cart cart = new Cart("khai00",productId,1,product.getPrice());
		cartRepository.updateOrInsertIntoCart("khai00",productId);
		if (product != null) {
			Cart item = new Cart();
			BeanUtils.copyProperties(product, item);
			item.setQuantity(1);
			item.setProductId(product.getProductId());
			item.setProductId(productId);
			item.setCustomerId("khai00");
		}
		session.setAttribute("cart", cart);
		//model.addAttribute("totalCartItemWishs", wishListService.getCount());
		//model.addAttribute("totalCartItems", shoppingCartService.getCount());

		return "redirect:" + request.getHeader("Referer");
	}



	@PutMapping(value = "/updateCart")
	public String updateCart(@RequestBody CartProductViewDTO[] cartProductViewDTOs, Model model,
							 RedirectAttributes rs) {
		// Duyệt qua danh sách các sản phẩm trong giỏ hàng để cập nhật
		for (CartProductViewDTO item : cartProductViewDTOs) {
			// Thực hiện cập nhật giỏ hàng cho từng sản phẩm
			cartService.updateCart(item);
		}
		// Sau khi cập nhật thành công, bạn có thể thực hiện các thao tác khác, ví dụ: điều hướng người dùng đến trang giỏ hàng hoặc trang khác
		return "site/shoppingCart"; // Điều hướng người dùng đến trang giỏ hàng sau khi cập nhật
	}




	// delete cartItem
	@SuppressWarnings("unlikely-arg-type")
	@GetMapping(value = "/remove/{id}")
	public String remove(@PathVariable("id") Integer id, HttpServletRequest request, Model model) {
		Product product = productRepository.findById(id).orElse(null);

		Collection<CartItem> cartItems = shoppingCartService.getCartItems();
		session = request.getSession();
		if (product != null) {
			CartItem item = new CartItem();
			BeanUtils.copyProperties(product, item);
			item.setProduct(product);
			cartItems.remove(session);
			shoppingCartService.remove(item);
		}
		model.addAttribute("totalCartItemWishs", wishListService.getCount());
		model.addAttribute("totalCartItems", shoppingCartService.getCount());
		
		return "redirect:/carts";
	}

	// show check out
	@GetMapping(value = "/checkout")
	public String checkOut(Model model) {

		Order order = new Order();
		model.addAttribute("order", order);

		Collection<CartItem> cartItems = shoppingCartService.getCartItems();
		model.addAttribute("cartItems", cartItems);
		model.addAttribute("total", shoppingCartService.getAmount());
		model.addAttribute("NoOfItems", shoppingCartService.getCount());
		double totalPrice = 0;
		for (CartItem cartItem : cartItems) {
			double price = cartItem.getQuantity() * cartItem.getProduct().getPrice();
			totalPrice += price - (price * cartItem.getProduct().getDiscount() / 100);
		}

		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("totalCartItemWishs", wishListService.getCount());
		model.addAttribute("totalCartItems", shoppingCartService.getCount());

		return "site/checkOut";
	}

	// submit checkout
	@PostMapping(value = "/checkout")
	@Transactional
	public String checkedOut(Model model, Order order, HttpServletRequest request, Principal principal) {

		session = request.getSession();
		Collection<CartItem> cartItems = shoppingCartService.getCartItems();
		
		Customer c = customersRepository.FindByEmail(principal.getName()).get();

		double totalPrice = 0;

		for (CartItem cartItem : cartItems) {

			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setQuantity(cartItem.getQuantity());
			orderDetail.setOrder(order);
			orderDetail.setProduct(cartItem.getProduct());

			double price = cartItem.getQuantity() * cartItem.getProduct().getPrice();
			totalPrice += price - (price * cartItem.getProduct().getDiscount() / 100);

			double unitPrice = cartItem.getProduct().getPrice();

			orderDetail.setTotalPrice(price - (price * cartItem.getProduct().getDiscount() / 100));
			orderDetail.setPrice(unitPrice);
			orderDetail.setStatus("Đang Chờ Xử Lý");
			orderDetailRepository.save(orderDetail);

		}

		order.setTotalPrice(totalPrice);
		Date date = new Date();
		order.setOrderDate(date);
		order.setAmount(shoppingCartService.getAmount());
		order.setCustomer(c);

		orderRepository.save(order);
		order.getOrderId();

		sendMailService.sendMail(c.getEmail(), "Vegana Store",
				"<h3>Hi: " + order.getReceiver() + " !</h3> Bạn có một đơn đặt hàng từ Vegana Store!\r\n <br>"
						+ "<br>"
						+ "Ngày đặt hàng : " + "<h4 style=\"color: black;\">"+ order.getOrderDate() + "</h4>"
						+ "<br>"
						+ "Tổng số tiền là: "
						+ "<h4 style=\"color: red;\">$" + order.getTotalPrice() + "</h4>"
						+ "<br>"
						+ "Cảm ơn bạn đã mua sắm trong cửa hàng của chúng tôi!\r\n ");

		shoppingCartService.clear();
		wishListService.clear();
		session.removeAttribute("cartItems");
		model.addAttribute("orderId", order.getOrderId());
		model.addAttribute("totalCartItemWishs", wishListService.getCount());
		model.addAttribute("totalCartItems", shoppingCartService.getCount());

		return "site/checkout_success";
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		sdf.setLenient(true);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
	}

}
