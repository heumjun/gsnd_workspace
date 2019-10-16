package egovframework.com.cmm;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;
import org.springframework.web.context.ServletContextAware;

import javax.servlet.ServletContext;

/**
 * ImagePaginationRenderer.java 클래스
 *
 * @author 서준식
 * @since 2011. 9. 16.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2011. 9. 16.   서준식       이미지 경로에 ContextPath추가
 * </pre>
 */
public class ImagePaginationRenderer2 extends AbstractPaginationRenderer implements ServletContextAware{

	private ServletContext servletContext;

	public ImagePaginationRenderer2() {

	}

	public void initVariables(){

		firstPageLabel    = "<span class=\"m control first\"><a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \" title=\"맨앞 페이지\"><i class=\"ic\">&laquo;</i></a></span>&#160;";
        previousPageLabel = "<span class=\"m control prev\"><a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \" title=\"이전 페이지\"><i class=\"ic\">&lsaquo;</i></a></span>&#160;";

        currentPageLabel  = "<span class=\"m pages on\"><a title=\"현재 {0} 페이지\">{0}</a></span>&#160;";
        otherPageLabel    = "<span class=\"m pages\"><a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \" title=\"{2} 페이지\">{2}</a></span>&#160;";

        nextPageLabel     = "<span class=\"m control next\"><a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \" title=\"다음 페이지\"><i class=\"ic\">&rsaquo;</i></a></span>&#160;";
        lastPageLabel     = "<span class=\"m control last\"><a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \" title=\"맨끝 페이지\"><i class=\"ic\">&raquo;</i></a></span>&#160;";
	}

	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}

}
