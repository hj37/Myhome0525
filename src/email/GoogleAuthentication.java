package email;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator{
	PasswordAuthentication passAuth;
	
	public GoogleAuthentication() {
		passAuth = new PasswordAuthentication("ycool37", "kzitukadvsqoowed");
	
	}
	
	public PasswordAuthentication getPasswordAuthentication() {
		return passAuth;
	}
}
