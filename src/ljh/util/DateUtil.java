//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package ljh.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class DateUtil {
    private static SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
    private static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    public DateUtil() {
    }

    public static String getDate() {
        String s = dateFormat.format(Calendar.getInstance().getTime());
        return s;
    }

    public static void main(String[] args) {
        System.out.println(DateUtil.getNow());
    }

    public static String getTime() {
        String s = timeFormat.format(Calendar.getInstance().getTime());
        return s;
    }


    public static String getRandom() {
        String s = getDate().substring(0, 4) + getDate().substring(5, 7) + getDate().substring(8);
        s = s + getTime().substring(0, 2) + getTime().substring(3, 5) + getTime().substring(6);
        return s;
    }

    public static String getNow() {
        return getDate() + " " + getTime();
    }

    public static String getAPM() {
        String s = "PM";
        if (Integer.parseInt(getTime().substring(0, 2)) < 13 && Integer.parseInt(getTime().substring(0, 2)) > 5) {
            s = "AM";
        }

        if (Integer.parseInt(getTime().substring(0, 2)) < 24 && Integer.parseInt(getTime().substring(0, 2)) > 12) {
            s = "PM";
        }

        return s;
    }

    public static String getDate(String time) {
        String s = dateFormat.format(new Date(time));
        return s;
    }

    public String getTime(String time) {
        String s = dateFormat.format(time);
        return s;
    }

    public String getAPM(String time) {
        String s = "PM";
        if (Integer.parseInt(this.getTime(time).substring(0, 2)) < 13 && Integer.parseInt(this.getTime(time).substring(0, 2)) > 5) {
            s = "AM";
        }

        if (Integer.parseInt(this.getTime(time).substring(0, 2)) < 24 && Integer.parseInt(this.getTime(time).substring(0, 2)) > 12) {
            s = "PM";
        }

        return s;
    }

    public static String getNextWeek(int i) {
        String date = getDate();
        int year = Integer.parseInt(date.substring(0, 4));
        int month = Integer.parseInt(date.substring(5, 7));
        int day = Integer.parseInt(date.substring(9));
        Calendar calendar = new GregorianCalendar(year, month - 1, day);
        calendar.add(5, i * 7);
        String nextDay = getDate(calendar.getTime().toString());
        return nextDay;
    }

    public static String getWeekScope(String date) {
        int year = Integer.parseInt(date.substring(0, 4));
        int month = Integer.parseInt(date.substring(5, 7));
        int day = Integer.parseInt(date.substring(8));
        Calendar calendar = new GregorianCalendar(year, month - 1, day);
        int day_of_week = calendar.get(7) - 1;
        calendar.add(5, -day_of_week);
        String sunday = getDate(calendar.getTime().toString());
        calendar.add(5, day_of_week);
        calendar.add(5, 7 - day_of_week - 1);
        String saturday = getDate(calendar.getTime().toString());
        return sunday + " -- " + saturday;
    }

    public static String getNextMonth(int i) {
        String date = getDate();
        int year = Integer.parseInt(date.substring(0, 4));
        int month = Integer.parseInt(date.substring(5, 7));
        int day = Integer.parseInt(date.substring(8));
        Calendar calendar = new GregorianCalendar(year, month - 1, day);
        calendar.add(2, i);
        String nextDay = getDate(calendar.getTime().toString());
        return nextDay.substring(0, 7);
    }

    public static String getNextMonth() {
        return getNextMonth(1);
    }

    public static int getWeek() {
//        int s = false;
        String date = getDate();
        int year = Integer.parseInt(date.substring(0, 4));
        int month = Integer.parseInt(date.substring(5, 7));
        int day = Integer.parseInt(date.substring(8));
        Calendar calendar = new GregorianCalendar(year, month - 1, day);
        int s = calendar.get(7) - 1;
        return s;
    }
}
