package Bean;

public class Distance {
    private String fromArea;  // Represents the starting area
    private String toArea;    // Represents the destination area
    private double distanceKm; // Represents the distance in kilometers

    // Getters and Setters
    public String getFromArea() {
        return fromArea;
    }

    public void setFromArea(String fromArea) {
        this.fromArea = fromArea;
    }

    public String getToArea() {
        return toArea;
    }

    public void setToArea(String toArea) {
        this.toArea = toArea;
    }

    public double getDistanceKm() {
        return distanceKm;
    }

    public void setDistanceKm(double distanceKm) {
        this.distanceKm = distanceKm;
    }

    @Override
    public String toString() {
        return "Distance{" +
                "fromArea='" + fromArea + '\'' +
                ", toArea='" + toArea + '\'' +
                ", distanceKm=" + distanceKm +
                '}';
    }
}