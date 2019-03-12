package commons;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class Downloadview extends AbstractView{
	private File file;
	
	public Downloadview(File file) {
		this.file = file;
		//�쓳�떟 ���엯�쓣 �떎�슫濡쒕뱶濡� 蹂�寃�
		setContentType("application/download; utf-8");
	}
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		//�뙆�씪�떞�븘�꽌 二쇰㈃ �맖
				response.setContentType(getContentType());
				response.setContentLength((int)file.length());
				
				
				
				//UUID留� �뾾�븻 �뙆�씪 �씠由꾩쓣 留뚮뱾�뼱�빞 �븿
				String fullName = file.getName();
				int idx = fullName.indexOf("_")+1;
				String tmpName = fullName.substring(idx);
				
				String fileName = null;
				//釉뚮씪�슦���뿉 �뵲�씪�꽌 �떎瑜닿쾶 �씤肄붾뵫
				//�슂泥� �뿤�뜑�뿉�꽌 user-agent �냽�꽦 媛��졇���꽌
				//�빐�떦 �냽�꽦�쓽 媛믪쓣 �솗�씤
				String userAgent = request.getHeader("User-Agent");
				//userAgent媛� 'MSIE' �씪�뒗 臾몄옄�뿴�쓣 �룷�븿�븯硫� ie �씠�떎.  
				boolean isIE = userAgent.indexOf("MSIE") > -1;
				if(isIE) {
					fileName 
					= URLEncoder.encode(tmpName,"utf-8");
				}else {
					fileName 
					= new String(tmpName.getBytes("UTF-8"),"ISO-8859-1");
				}
				//留뚮뱾�뼱�궦 �뙆�씪�씠由꾩쓣 �쓳�떟�빐�뜑�뿉 �떍湲�
				response.setHeader("Content-Disposition",
						"attachment; filename=\""+fileName+"\";");
								//fileName = "test.txt";
				response.setHeader("Content-Transfer-Encoding","binary");
				//�뙆�씪�쓣 �뒪�듃由쇱쑝濡� �씫�뼱���꽌 �쓳�떟�뿉�꽌 outstream�쑝濡� �궡蹂대궡湲� 
				OutputStream out = response.getOutputStream();
				FileInputStream fis = null;
				try{
					fis = new FileInputStream(file);
					FileCopyUtils.copy(fis,out);
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(fis != null) fis.close();
				}
				out.flush();
			}
		}

