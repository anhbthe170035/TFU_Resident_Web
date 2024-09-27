/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.time.LocalTime;

/**
 *
 * @author Admin
 */
public class Pharmacy {
    private int pharmacyId;
    private String name;
    private String address;
    private String phone;
    private LocalTime openingHours;
    private LocalTime closingHours;
    private String description;
    private String imageUrl;
    private String isActive;
    private String city;
    private String region;
    private String zipCode;

    public Pharmacy() {
    }

    public Pharmacy(int pharmacyId, String name, String address, String phone, LocalTime openingHours, LocalTime closingHours, String description, String imageUrl, String isActive, String city, String region, String zipCode) {
        this.pharmacyId = pharmacyId;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.openingHours = openingHours;
        this.closingHours = closingHours;
        this.description = description;
        this.imageUrl = imageUrl;
        this.isActive = isActive;
        this.city = city;
        this.region = region;
        this.zipCode = zipCode;
    }

    public int getPharmacyId() {
        return pharmacyId;
    }

    public void setPharmacyId(int pharmacyId) {
        this.pharmacyId = pharmacyId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public LocalTime getOpeningHours() {
        return openingHours;
    }

    public void setOpeningHours(LocalTime openingHours) {
        this.openingHours = openingHours;
    }

    public LocalTime getClosingHours() {
        return closingHours;
    }

    public void setClosingHours(LocalTime closingHours) {
        this.closingHours = closingHours;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getIsActive() {
        return isActive;
    }

    public void setIsActive(String isActive) {
        this.isActive = isActive;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }
}
