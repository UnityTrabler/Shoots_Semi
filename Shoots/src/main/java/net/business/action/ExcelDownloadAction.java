package net.business.action;

import java.io.IOException;
import java.io.OutputStream;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.core.Action;
import net.core.ActionForward;
import net.match.db.MatchBean;
import net.match.db.MatchDAO;
import net.pay.db.PaymentDAO;

public class ExcelDownloadAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		MatchDAO dao = new MatchDAO();
		
		PaymentDAO pdao = new PaymentDAO();

		HttpSession session = req.getSession();
		int idx = (int) session.getAttribute("idx");
		System.out.println("로그인 = " + idx);
		
		LocalDate now = LocalDate.now();
	    int year = now.getYear(); 
	    int month = now.getMonthValue();
	    
	    int selectedYear = now.getYear();
	    req.setAttribute("selectedYear", selectedYear);
	    
	    int selectedMonth = now.getMonthValue();
	    req.setAttribute("selectedMonth", selectedMonth);
	    
	    if (req.getParameter("year") != null) {
	        try {
	            year = Integer.parseInt(req.getParameter("year"));
	        } catch (NumberFormatException e) {
	            year = now.getYear();
	        }
	    }

	    if (req.getParameter("month") != null) {
	        try {
	            month = Integer.parseInt(req.getParameter("month"));
	        } catch (NumberFormatException e) {
	            month = now.getMonthValue();
	        }
	    }
	    
		List<MatchBean> list = new ArrayList<MatchBean>();
		
		int listcount = dao.getListCount(idx, year, month);
		list = dao.getMatchListById(idx, year, month);
		
		int rowNum = 1;
		int total = 0;
		int totalPlayerCount = 0;
	    int totalSales = 0;
	    String previousDate = "";  
        int rowspanCount = 1;      
        int dailyTotal = 0;      
        
		for (MatchBean match : list) {
	        int playerCount = pdao.getPaymentCountById(match.getMatch_id());
	        match.setPlayerCount(playerCount);
	        	        
	        int price = match.getPrice();
	        
	        total = price * playerCount;
	        match.setTotal(total);
	        
	        totalPlayerCount += playerCount;
            totalSales += total;
		}
			
		Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("매출 내용");

        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("날짜");
        headerRow.createCell(1).setCellValue("시간");
        headerRow.createCell(2).setCellValue("가격");
        headerRow.createCell(3).setCellValue("참가인원수");
        headerRow.createCell(4).setCellValue("매출");

        Row blankRow = sheet.createRow(rowNum++);
        blankRow.createCell(0).setCellValue("");
        blankRow.createCell(1).setCellValue(""); 
        blankRow.createCell(2).setCellValue(""); 
        blankRow.createCell(3).setCellValue(""); 
        blankRow.createCell(4).setCellValue(""); 
        
        for (MatchBean match : list) {
            String matchDate = match.getMatch_date().substring(0, 10);

            if (!matchDate.equals(previousDate)) {
            	
                if (!previousDate.isEmpty() && rowspanCount > 1) {
                    sheet.addMergedRegion(new CellRangeAddress(rowNum - rowspanCount, rowNum - 1, 0, 0)); 
                }

                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(matchDate.replace('-', '/')); 
                row.createCell(1).setCellValue(match.getMatch_time());
                row.createCell(2).setCellValue(match.getPrice());
                row.createCell(3).setCellValue(match.getPlayerCount());
                row.createCell(4).setCellValue(match.getTotal());

                dailyTotal = match.getPrice() * match.getPlayerCount();
                rowspanCount = 1; 
            } else {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(""); 
                row.createCell(1).setCellValue(match.getMatch_time());
                row.createCell(2).setCellValue(match.getPrice());
                row.createCell(3).setCellValue(match.getPlayerCount());
                row.createCell(4).setCellValue(match.getTotal());

                rowspanCount++;
                dailyTotal += (match.getPrice() * match.getPlayerCount());
            }

            previousDate = matchDate;
        }

        if (!previousDate.isEmpty() && rowspanCount > 1) {
            sheet.addMergedRegion(new CellRangeAddress(rowNum - rowspanCount, rowNum - 1, 0, 0)); 
        }
        
        Row blankRow2 = sheet.createRow(rowNum++);
        blankRow2.createCell(0).setCellValue("");
        blankRow2.createCell(1).setCellValue(""); 
        blankRow2.createCell(2).setCellValue(""); 
        blankRow2.createCell(3).setCellValue(""); 
        blankRow2.createCell(4).setCellValue(""); 
        
        Row totalRow = sheet.createRow(rowNum++);
        totalRow.createCell(0).setCellValue("합계");
        totalRow.createCell(3).setCellValue(totalPlayerCount);
        totalRow.createCell(4).setCellValue(totalSales);


        resp.setContentType("application/vnd.ms-excel");
        resp.setHeader("Content-Disposition", "attachment;filename=sales_report.xlsx");

        try (OutputStream out = resp.getOutputStream()) {
            workbook.write(out);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                workbook.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        
        return null;
	}

}
