package Bean;

import java.sql.Timestamp;

public class Billing {
    private int billId;
    private int bookingId;
    private String billNumber;
    private String customerName;
    private String customerPhone;
    private String driverName;
    private String driverPhone;
    private String pickupLocation;
    private String dropLocation;
    private double distance;
    private double startingMeter;
    private double endingMeter;
    private double finalAmount;
    private String paymentMethod;
    private String paymentStatus;
    private Timestamp billDate;

    // Getters and Setters
    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public String getBillNumber() {
        return billNumber;
    }

    public void setBillNumber(String billNumber) {
        this.billNumber = billNumber;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getDriverName() {
        return driverName;
    }

    public void setDriverName(String driverName) {
        this.driverName = driverName;
    }

    public String getDriverPhone() {
        return driverPhone;
    }

    public void setDriverPhone(String driverPhone) {
        this.driverPhone = driverPhone;
    }

    public String getPickupLocation() {
        return pickupLocation;
    }

    public void setPickupLocation(String pickupLocation) {
        this.pickupLocation = pickupLocation;
    }

    public String getDropLocation() {
        return dropLocation;
    }

    public void setDropLocation(String dropLocation) {
        this.dropLocation = dropLocation;
    }

    public double getDistance() {
        return distance;
    }

    public void setDistance(double distance) {
        this.distance = distance;
    }

    public double getStartingMeter() {
        return startingMeter;
    }

    public void setStartingMeter(double startingMeter) {
        this.startingMeter = startingMeter;
    }

    public double getEndingMeter() {
        return endingMeter;
    }

    public void setEndingMeter(double endingMeter) {
        this.endingMeter = endingMeter;
    }


    public double getFinalAmount() {
        return finalAmount;
    }

    public void setFinalAmount(double finalAmount) {
        this.finalAmount = finalAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public Timestamp getBillDate() {
        return billDate;
    }

    public void setBillDate(Timestamp billDate) {
        this.billDate = billDate;
    }

    @Override
    public String toString() {
        return "Billing{" +
                "billId=" + billId +
                ", bookingId=" + bookingId +
                ", billNumber='" + billNumber + '\'' +
                ", customerName='" + customerName + '\'' +
                ", customerPhone='" + customerPhone + '\'' +
                ", driverName='" + driverName + '\'' +
                ", driverPhone='" + driverPhone + '\'' +
                ", pickupLocation='" + pickupLocation + '\'' +
                ", dropLocation='" + dropLocation + '\'' +
                ", distance=" + distance +
                ", startingMeter=" + startingMeter +
                ", endingMeter=" + endingMeter +
                ", finalAmount=" + finalAmount +
                ", paymentMethod='" + paymentMethod + '\'' +
                ", paymentStatus='" + paymentStatus + '\'' +
                ", billDate=" + billDate +
                '}';
    }
}