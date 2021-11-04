<%@page import="com.lowagie.text.Rectangle"%>
<%@page import="com.lowagie.text.PageSize"%>
<%@page import="com.lowagie.text.pdf.PdfPTable"%>
<%@page import="com.lowagie.text.pdf.PdfPCell"%>
<%@page import="com.lowagie.text.Font"%>
<%@page import="com.lowagie.text.Phrase"%>
<%@page import="java.io.IOException"%>
<%@page import="com.lowagie.text.DocumentException"%>
<%@page import="java.util.Date"%>
<%@page import="com.lowagie.text.Paragraph"%>
<%@page import="com.lowagie.text.pdf.PdfWriter"%>
<%@page import="com.lowagie.text.Document"%>
<%@page import="org.apache.poi.ss.usermodel.IndexedColors"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="org.apache.poi.xssf.streaming.SXSSFCell"%>
<%@page import="org.apache.poi.xssf.streaming.SXSSFRow"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFCellStyle"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFFont"%>
<%@page import="org.apache.poi.xssf.streaming.SXSSFSheet"%>
<%@page import="org.apache.poi.xssf.streaming.SXSSFWorkbook"%>
<%@page import="org.apache.poi.ss.usermodel.FillPatternType"%>
<%@page import="Conexion.BaseDeDatos"%>
<%@page import="Conexion.Gestor"%>
<%@page import="Conexion.Consulta"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%
    
    String tipoArchivo = "", pais = "", region = "";

    if(request.getParameter("archivo") != null){
        tipoArchivo = request.getParameter("archivo");
    }
    if(request.getParameter("region") != null){
        region = request.getParameter("region");
    }
    if(request.getParameter("pais") != null){
        pais = request.getParameter("pais");
    }
    
    Gestor gestor = new Gestor();
    List<Consulta> consultas = new ArrayList<Consulta>();
    
    consultas = gestor.consulta(region, pais);
    
    if (tipoArchivo.equals("pdf")) {
        response.setContentType("application/pdf");
    
        Font titulo = new Font(Font.COURIER, 14, Font.BOLD);
        Font textoBold = new Font(Font.COURIER, 11, Font.BOLD);
        Font texto = new Font(Font.COURIER, 11, Font.NORMAL);

        Document document = new Document(PageSize.A4, 30, 30, 50, 30);//float marginLeft, float marginRight, float marginTop, float marginBottom
        //metadata
        document.addTitle("PROG3TP9");
        document.addSubject("PROG3TP9");
        document.addKeywords("PROG3TP9");
        document.addAuthor("GDARTSCH");
        document.addCreator("GDARTSCH");

        PdfWriter.getInstance(document, response.getOutputStream()); // Code 2
        document.open();

        Paragraph paragraph = new Paragraph("Resultados", titulo);
        document.add(paragraph);

        PdfPTable table = new PdfPTable(4);
        table.setWidthPercentage(100);
        
        PdfPCell celda1 = new PdfPCell(new Phrase("Ciudad", textoBold));
        celda1.setBorder(Rectangle.NO_BORDER);
        PdfPCell celda2 = new PdfPCell(new Phrase("Población", textoBold));
        celda2.setBorder(Rectangle.NO_BORDER);
        PdfPCell celda3 = new PdfPCell(new Phrase("Pais:", textoBold));
        celda3.setBorder(Rectangle.NO_BORDER);
        PdfPCell celda4 = new PdfPCell(new Phrase("Región", textoBold));
        celda4.setBorder(Rectangle.NO_BORDER);
        table.addCell(celda1);
        table.addCell(celda2);
        table.addCell(celda3);
        table.addCell(celda4);
        
        for (Consulta consulta : consultas) {
                PdfPCell celda5 = new PdfPCell(new Phrase(consulta.getCiudad(), texto));
                celda1.setBorder(Rectangle.NO_BORDER);
                PdfPCell celda6 = new PdfPCell(new Phrase(consulta.getPoblacion(), texto));
                 celda2.setBorder(Rectangle.NO_BORDER);
                PdfPCell celda7 = new PdfPCell(new Phrase(consulta.getPais(), texto));
                celda3.setBorder(Rectangle.NO_BORDER);
                PdfPCell celda8 = new PdfPCell(new Phrase(consulta.getRegion(), texto));
                celda4.setBorder(Rectangle.NO_BORDER);
                table.addCell(celda5);
                table.addCell(celda6);
                table.addCell(celda7);
                table.addCell(celda8);
            }

        document.add(table);

        document.close();
    }else{
        
        //creo el libro excel
        SXSSFWorkbook libro = new SXSSFWorkbook(50);
        //estilos
        XSSFFont font = (XSSFFont) libro.createFont();
        font.setBold(true);
        XSSFCellStyle style = (XSSFCellStyle) libro.createCellStyle();
        style.setFont(font);
        XSSFCellStyle styleGris = (XSSFCellStyle) libro.createCellStyle();
        styleGris.setFont(font);
        styleGris.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
        styleGris.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        XSSFCellStyle styleGreen = (XSSFCellStyle) libro.createCellStyle();
        styleGreen.setFont(font);
        styleGreen.setFillForegroundColor(IndexedColors.SEA_GREEN.index);
        styleGreen.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        XSSFCellStyle styleRed = (XSSFCellStyle) libro.createCellStyle();
        styleRed.setFont(font);
        styleRed.setFillForegroundColor(IndexedColors.RED.index);
        styleRed.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        XSSFCellStyle styleNaranja = (XSSFCellStyle) libro.createCellStyle();
        styleNaranja.setFont(font);
        styleNaranja.setFillForegroundColor(IndexedColors.TAN.index);
        styleNaranja.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        XSSFCellStyle styleTurquesa = (XSSFCellStyle) libro.createCellStyle();
        styleTurquesa.setFont(font);
        styleTurquesa.setFillForegroundColor(IndexedColors.LIGHT_TURQUOISE.index);
        styleTurquesa.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        XSSFCellStyle styleRosa = (XSSFCellStyle) libro.createCellStyle();
        styleRosa.setFont(font);
        styleRosa.setFillForegroundColor(IndexedColors.ROSE.index);
        styleRosa.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        XSSFCellStyle styleAmarillo = (XSSFCellStyle) libro.createCellStyle();
        styleAmarillo.setFont(font);
        styleAmarillo.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.index);
        styleAmarillo.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        XSSFCellStyle styleOro = (XSSFCellStyle) libro.createCellStyle();
        styleOro.setFont(font);
        styleOro.setFillForegroundColor(IndexedColors.GOLD.index);
        styleOro.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        XSSFCellStyle styleOroObservado = (XSSFCellStyle) libro.createCellStyle();
        styleOroObservado.setFont(font);
        styleOroObservado.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        styleOroObservado.setBottomBorderColor(IndexedColors.RED.index);
        styleOroObservado.setFillForegroundColor(IndexedColors.YELLOW.index);
        XSSFCellStyle styleVerdeClaro = (XSSFCellStyle) libro.createCellStyle();
        styleVerdeClaro.setFont(font);
        styleVerdeClaro.setFillForegroundColor(IndexedColors.LIGHT_GREEN.index);
        styleVerdeClaro.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        XSSFCellStyle styleVerdeObservacion = (XSSFCellStyle) libro.createCellStyle();
        styleVerdeObservacion.setFont(font);
        styleVerdeObservacion.setFillForegroundColor(IndexedColors.BRIGHT_GREEN.index);
        styleVerdeObservacion.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        styleVerdeObservacion.setBottomBorderColor(IndexedColors.RED.index);
        XSSFCellStyle styleAzul = (XSSFCellStyle) libro.createCellStyle();
        styleAzul.setFont(font);
        styleAzul.setFillForegroundColor(IndexedColors.PALE_BLUE.index);
        styleAzul.setFillPattern(FillPatternType.SOLID_FOREGROUND);


        // Se crea una hoja dentro del libro
        SXSSFSheet hoja = libro.createSheet();

        int nroColumna = 0;
        // Se crea una fila dentro de la hoja
        SXSSFRow row = hoja.createRow(0);
        // Se crea una celda dentro de la fila
        SXSSFCell cell = row.createCell(nroColumna);
        cell.setCellValue("Ciudad");
        cell.setCellStyle(styleGris);
        cell = row.createCell(++nroColumna);
        cell.setCellValue("Población");
        cell.setCellStyle(styleGris);
        cell = row.createCell(++nroColumna);
        cell.setCellValue("País");
        cell.setCellStyle(styleGris);
        cell = row.createCell(++nroColumna);
        cell.setCellValue("Región");
        cell.setCellStyle(styleGris);


        int nroFila = 1;
        nroColumna = 0;
        for(Consulta consulta : consultas) {

            nroColumna = 0;
            row = hoja.createRow(nroFila);
            ++nroFila;
            cell = row.createCell(nroColumna);
            cell.setCellValue(consulta.getCiudad());
            if (Integer.parseInt(consulta.getPoblacion()) > 5000000 ) {
                cell.setCellStyle(styleAmarillo);
            }else if(Integer.parseInt(consulta.getPoblacion()) < 100000){
                cell.setCellStyle(styleVerdeObservacion);
            } 
            cell = row.createCell(++nroColumna);
            cell.setCellValue(consulta.getPoblacion());
            if (Integer.parseInt(consulta.getPoblacion()) > 5000000 ) {
                cell.setCellStyle(styleAmarillo);
            }else if(Integer.parseInt(consulta.getPoblacion()) < 100000){
                cell.setCellStyle(styleVerdeObservacion);
            } 
            cell = row.createCell(++nroColumna);
            cell.setCellValue(consulta.getPais());
            if (Integer.parseInt(consulta.getPoblacion()) > 5000000 ) {
                cell.setCellStyle(styleAmarillo);
            }else if(Integer.parseInt(consulta.getPoblacion()) < 100000){
                cell.setCellStyle(styleVerdeObservacion);
            } 
            cell = row.createCell(++nroColumna);
            cell.setCellValue(consulta.getRegion());
            if (Integer.parseInt(consulta.getPoblacion()) > 5000000 ) {
                cell.setCellStyle(styleAmarillo);
            }else if(Integer.parseInt(consulta.getPoblacion()) < 100000){
                cell.setCellStyle(styleVerdeObservacion);
            } 
        }
        // Se salva el libro.
        ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
        libro.write(outByteStream);
        byte [] outArray = outByteStream.toByteArray();
        response.setContentType("application/ms-excel");
        response.setContentLength(outArray.length);
        response.setHeader("Expires:", "0"); // eliminates browser caching
        response.setHeader("Content-Disposition", "attachment; filename=testxls.xls");
        OutputStream outStream = response.getOutputStream();
        outStream.write(outArray);
        outStream.flush();
    }
    
    
%>
