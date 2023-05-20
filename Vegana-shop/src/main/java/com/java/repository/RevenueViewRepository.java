package com.java.repository;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class RevenueViewRepository {
    private final JdbcTemplate jdbcTemplate;

    public RevenueViewRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public double getTotalRevenue() {
        String sql = "SELECT total_revenue FROM revenue_view LIMIT 1";
        try {
            return jdbcTemplate.queryForObject(sql, Double.class);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }

}
