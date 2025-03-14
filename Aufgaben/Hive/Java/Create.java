import java.sql.*;
public class Create{
	private static String driverName = "org.apache.hive.jdbc.HiveDriver";
	public static void main(String... args)throws SQLException{

		try{
			Class.forName(driverName);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.exit(1);
		}

		Connection con = DriverManager.getConnection(
				"jdbc:hive2://172.17.0.4:10000/", "hadoop", "");
		Statement stmt = con.createStatement();
		String tableName = "Laptops";
		stmt.execute("drop table if exists " + tableName);
		stmt.execute("create table " + tableName +" (id INT, Model STRING, SerielNumber STRING)");
		String sql = "insert into " + tableName + " values (1,\"MacBook Pro 13\", \"abc\"),(2,\"MacBook Air 13\", \"aby\"),(3,\"MacBook Air 13\", \"abz\")";
		stmt.execute(sql);
		tableName = "Software";
		stmt.execute("drop table if exists " + tableName);
		stmt.execute("create table " + tableName +" (id INT, Name STRING, Version STRING)");
		sql = "insert into " + tableName + " values (1,\"Word\", \"2022H2\"),(2,\"Power Point\", \"2022H2\"),(3,\"nvim\", \"12\")";
		stmt.execute(sql);

	}
}


