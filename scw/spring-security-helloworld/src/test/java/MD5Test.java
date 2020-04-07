import com.atguigu.security.service.MD5Util;

public class MD5Test {
    public static void main(String[] args) {
        String digest = MD5Util.digest("zcc");
        System.out.println(digest);
    }
}
