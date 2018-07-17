package entity;

public class Evaluate {
    private int id;
    private String name;//用户名
    private int dishid;
    private int salty;
    private int sweet;
    private int sour;
    private int hot;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getDishid() {
        return dishid;
    }

    public void setDishid(int dishid) {
        this.dishid = dishid;
    }

    public int getSalty() {
        return salty;
    }

    public void setSalty(int salty) {
        this.salty = salty;
    }

    public int getSweet() {
        return sweet;
    }

    public void setSweet(int sweet) {
        this.sweet = sweet;
    }

    public int getSour() {
        return sour;
    }

    public void setSour(int sour) {
        this.sour = sour;
    }

    public int getHot() {
        return hot;
    }

    public void setHot(int hot) {
        this.hot = hot;
    }
}
