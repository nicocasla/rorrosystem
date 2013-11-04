package com.songs;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.GenericServlet;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class SongManager extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	List<String> songs = new ArrayList<String>();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		if (req.getParameter("operation").equals("addSong")){
			songs.add(req.getParameter("songName"));
		}
		if (req.getParameter("operation").equals("getSongs")){
			PrintWriter out = resp.getWriter();
			out.print(songs);
			out.close();
		}
		if (req.getParameter("operation").equals("removeSong")){
			songs.remove(req.getParameter("songName"));
		}
	}

}
