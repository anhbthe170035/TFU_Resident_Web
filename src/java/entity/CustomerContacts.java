/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Admin
 */
public class CustomerContacts {
    private int contactId; 
    private Customer customerId;
    private String phone;
    private String email;
    private int isPrimary;
    private String ContactType;

    public CustomerContacts() {
    }
    
    public CustomerContacts(int contactId, Customer customerId, String phone, String email, int isPrimary, String ContactType) {
        this.contactId = contactId;
        this.customerId = customerId;
        this.phone = phone;
        this.email = email;
        this.isPrimary = isPrimary;
        this.ContactType = ContactType;
    }

    public int getContactId() {
        return contactId;
    }

    public void setContactId(int contactId) {
        this.contactId = contactId;
    }

    public Customer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Customer customerId) {
        this.customerId = customerId;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getIsPrimary() {
        return isPrimary;
    }

    public void setIsPrimary(int isPrimary) {
        this.isPrimary = isPrimary;
    }

    public String getContactType() {
        return ContactType;
    }

    public void setContactType(String ContactType) {
        this.ContactType = ContactType;
    }
}
