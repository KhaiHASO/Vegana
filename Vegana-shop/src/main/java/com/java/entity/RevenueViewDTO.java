package com.java.entity;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RevenueViewDTO {
    private double revenue;
    @Override
    public String toString() {
        return "Revenue{" +
                "revenue=" + revenue +
                '}';
    }

}
