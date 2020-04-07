import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class BCryptPasswordEncoderTest {
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String zcc = encoder.encode("12345");
        boolean matches = encoder.matches("12345", "$2a$10$WvLzjg7awscKnxzKXfXFzeEVVpEaXRCt1gEuav9/WOZ53J8Inf2Ta");
        System.out.println(zcc+"===="+matches);
    }
}
