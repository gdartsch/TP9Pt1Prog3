<%-- 
    Document   : index
    Created on : Nov 4, 2021, 11:27:25 AM
    Author     : choco
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>TP9 Programación 3 Parte 1</h1>
        <form action="reults.jsp">
            <p>Ingrese el país</p><input type="text" name="pais" id="pais"/>
            <p>Ingrese la región</p>
                        <select name="region" id="region">
                            <option value="Caribbean">Caribbean</option>
                            <option value="Eastern Africa">Eastern Africa</option>  
                            <option value="Eastern Asia">Eastern Asia</option>
                            <option value="Central America">Central America</option>                            
                        </select>
            <p>Desea recibir un archivo de tipo:</p>
                        <select name="archivo" id="archivo">
                            <option value="pdf">Pdf</option>
                            <option value="excel">Excel</option>                          
                        </select>
            <br><br><br>
            <button type="submit">Enviar</button>
        </form>
    </body>
</html>
