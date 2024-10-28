package net.board.action;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.comment.action.Action;
import net.comment.action.ActionForward;

public class BoardFileDownAction implements Action {

	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String fileName = req.getParameter("filename");
		System.out.println("filename = " + fileName);
		
		String savePath = "boardupload";
		
		//servlet 실행 환경 정보 담고 있는 객체를 리턴.
		ServletContext context = req.getServletContext();
		String sDownloadPath = context.getRealPath(savePath);
		
		String sFilePath = sDownloadPath + File.separator + fileName;
		System.out.println(sFilePath);
		
		byte b[] = new byte[4096];
		
		//sFilePath에 있는 file의 MimeType을 get
		String sMimeType = context.getMimeType(sFilePath);
		System.out.println("sMimeType>>> " + sMimeType);
		
		if(sMimeType == null)
			sMimeType = "application/octet-stream";
		
		resp.setContentType(sMimeType);
		
		//한글 파일명 깨짐 방지
		String sEncoding = new String(fileName.getBytes("utf-8"), "ISO-8859-1");
		System.out.println("sEncoding : " + sEncoding);
		
		//Content-Disposition : attachment : browser에서 download 하기 위해 사용.
		resp.setHeader("Content-Disposition", "attachment; filename=" + sEncoding);
		
		try(
			//web browser로의 출력 stream 생성.	
			BufferedOutputStream out2 = new BufferedOutputStream(resp.getOutputStream());
			//sFilePath로 지정한 file에 대한 입력 stream 생성.
			BufferedInputStream in = new BufferedInputStream(new FileInputStream(sFilePath));
				){
			int numRead;
			// read(b,0,b.length) : byte 배열 b의 0~b.length 크기 만큼 읽어옴.
			while((numRead = in.read(b,0,b.length)) != -1)//읽을 데이터가 존재시
				//byte 배열 b의 0~b.length 크기 만큼 출력.
				out2.write(b,0,numRead);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
 		return null;
	}

}
