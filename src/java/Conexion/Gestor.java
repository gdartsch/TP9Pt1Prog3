package Conexion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Gestor {

    BaseDeDatos bd = new BaseDeDatos();
    Connection conexion = bd.estableceConexion();

    public void cerrarConexion() {
        try {
            conexion.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<Consulta> consulta(String region, String pais) throws SQLException{
        PreparedStatement ps1 = null;
        ResultSet rs = null;
        Consulta consuta;
        List<Consulta> consultas = new ArrayList<Consulta>();
        
        try {
                ps1 = conexion.prepareStatement("SELECT ciudad.name, ciudad.population, pais.name, pais.region FROM city ciudad INNER JOIN \n" +
                                                "country pais ON ciudad.CountryCode = pais.code WHERE pais.region = '"+ region +"' AND \n" +
                                                "pais.name LIKE '%"+ pais +"%' ORDER BY pais.name");
                
                rs = ps1.executeQuery();        
                
                while (rs.next()) {
                consuta = new Consulta();

                consuta.setCiudad(rs.getString(1));
                consuta.setPoblacion(rs.getString(2));
                consuta.setPais(rs.getString(3));
                consuta.setRegion(rs.getString(4));

                consultas.add(consuta);

            }
                
        }catch (SQLException ex) {
                conexion.rollback();
                Logger.getLogger(BaseDeDatos.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            if (ps1 != null){
                ps1.close();
            }
        }
        return consultas;
    }
}
