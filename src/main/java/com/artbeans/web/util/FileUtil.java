package com.artbeans.web.util;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.ConstructorBinding;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.artbeans.web.entity.FileInfo;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

/*
 * 파일공통입니다. 
 */
@Slf4j
@Component
public class FileUtil {
	
	private static String root;
	
	private static String editorPath;
	
	@Value("${fileUtil.path.root}")
    public void setRoot(String root) {
		FileUtil.root = root;

    }
	
	@Value("${fileUtil.path.editor}")
    public void setEditorPath(String editor) {
		FileUtil.editorPath = editor;
    }
	
	public static void fileInsert(FileInfo fileInfo, String fiType) throws Exception {
		String fiName = fileInfo.getFiFile().getOriginalFilename();
		String fiSize = (fileInfo.getFiFile().getSize()) + "Byte";
 		if(fiName==null) {
			throw new Exception("파일은 필수 항목입니다!");
		}
 		log.info("fiName => {}", fiName);
		int idx = fiName.lastIndexOf(".");
		String extName = fiName.substring(idx);
		String path = "/" + System.nanoTime() + extName;
		fileInfo.setFiOriginalname(fiName);
		fileInfo.setFiSize(fiSize);
		fileInfo.setFiPath(path);
		fileInfo.setFiType(fiType);
		log.info("fileInfo=>{}", fileInfo);
		File file = new File(root + fiType + path);
		fileInfo.getFiFile().transferTo(file);
		
	}
	
	public static Map<String,String> ckeditorUploadImg(MultipartFile upload){
		String fileName = upload.getOriginalFilename();
		File target = new File(editorPath + fileName);
		log.info("fileName=>{}",fileName);
		try {
			upload.transferTo(target);
			Map<String,String> rMap = new HashMap<>();
			rMap.put("uploaded","true");
			rMap.put("url", "/upload/" + fileName);
			log.info("rMap=>{}",rMap);
			return rMap;
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
}