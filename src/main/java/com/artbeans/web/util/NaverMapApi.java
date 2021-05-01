package com.artbeans.web.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.artbeans.web.api.Result;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Component
public class NaverMapApi {
	
	@Autowired
	private ObjectMapper om;

	private final static String API_URI = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=";
	private final static String ID_HEADER = "x-ncp-apigw-api-key-id";
	private final static String CLIENT_ID = "";
	private final static String SECRET_HEADER = "x-ncp-apigw-api-key";
	private final static String CLIENT_SECRET = "";
	private final static String ACCEPT_HEADER = "Accept";
	private final static String VALUE_ACCEPT = "application/json";

	public Result getResult(String addrParam) {
		String json = getResultString(addrParam);
		Result result = null;
		try {
			result = om.readValue(json, Result.class);
		} catch (JsonParseException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}

	public HttpURLConnection getHttpURLConnection(String addrParam) {
		HttpURLConnection conn = null;
		try {
			String value = URLEncoder.encode(addrParam,"utf-8");
			URL url = new URL(API_URI+value);
			conn = (HttpURLConnection) url.openConnection();
			return conn;
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	private String getResultString(String addrParam) {
		HttpURLConnection conn = null;
		
		    try {
		        conn = getHttpURLConnection(addrParam);
		        conn.setRequestMethod("GET");
		        conn.setRequestProperty("Content-Type", "application/json");
		        conn.setRequestProperty(ID_HEADER, CLIENT_ID);
		        conn.setRequestProperty(SECRET_HEADER, CLIENT_SECRET);
		        conn.setRequestProperty(ACCEPT_HEADER, VALUE_ACCEPT);
		        conn.connect();
		        
		        StringBuffer sb = new StringBuffer();
		        InputStreamReader in = new InputStreamReader(conn.getInputStream(), "utf-8");
				BufferedReader br = new BufferedReader(in);
				
				String line = null;
				while ((line = br.readLine()) != null) {
					sb.append(line);
				}				
				return sb.toString();
		       
		    } catch (IOException e) {
				e.printStackTrace();

			}

		return "";
	}
}
