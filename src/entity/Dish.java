package entity;

//商品类
public class Dish {

    private int id; // 菜品编号等于菜编号+窗口编号
    private String name; // 商品名称
    private String wname; // 窗口名
    private float salty; // 库存
    private float sweet; // 库存
    private float sour; // 库存
    private float hot; // 库存
    private float price; // 价格
    private String imgurl; // 商品图片

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

    public String getWname() {
        return wname;
    }

    public void setWname(String wname) {
        this.wname = wname;
    }

    public float getSalty() {
        return (float) Math.round(salty * 1000) / 1000;
    }

    public void setSalty(float salty) {
        this.salty = salty;
    }

    public float getSweet() {
        return (float) Math.round(sweet * 1000) / 1000;
    }

    public void setSweet(float sweet) {
        this.sweet = sweet;
    }

    public float getSour() {
        return (float) Math.round(sour * 1000) / 1000;
    }

    public void setSour(float sour) {
        this.sour = sour;
    }

    public float getHot() {
        return (float) Math.round(hot * 1000) / 1000;
    }

    public void setHot(float hot) {
        this.hot = hot;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getImgurl() {
        return imgurl;
    }

    public void setImgurl(String imgurl) {
        this.imgurl = imgurl;
    }
}