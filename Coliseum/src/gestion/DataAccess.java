package gestion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DataAccess {
	public static void conexionAbierta(){
	try {
		String sourceURL = "jdbc:sqlserver://localhost";
		String usuario = "PapiGavi";
		String password = "BadBunnyElMejor";
		Connection connexionBaseDatos =DriverManager.getConnection(sourceURL, usuario, password);
	}catch(SQLException e) {
		System.out.println("pececito");
	}
	
}			

}
