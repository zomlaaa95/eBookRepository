package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import dao.EbookDAO;
import entities.Ebook;

public class BookPrepareAddEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private final Logger LOGGER = LogManager.getLogger(BookPrepareAddEditServlet.class);
	
	EbookDAO eBookDao;
	
	public BookPrepareAddEditServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getSession().getAttribute("admin") == null)
		{
			response.sendRedirect("/MenuVisitorServlet");
		}
		
		try
		{
			String idStr = request.getParameter("id");
			Ebook eBook = new Ebook();
			int idInt;
			
			try
			{
				idInt = Integer.parseInt(idStr);
				eBook = eBookDao.findById(idInt);
			}
			catch (NumberFormatException e)
			{
				request.setAttribute("action", "add");
			}
			
			request.setAttribute("eBookAddEdit", eBook);
			getServletContext().getRequestDispatcher("/BookAddEdit.jsp").forward(request, response);	
		}
		catch (ServletException e)
		{
			LOGGER.error(e);
			throw e;
		}
		catch (IOException e)
		{
			LOGGER.error(e);
			throw e;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}