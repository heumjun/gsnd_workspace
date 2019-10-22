package kr.go.gyeongnam.human.dto.cmm.criteria;

import kr.go.gyeongnam.human.dto.cmm.PopupDto;
import lombok.Data;

@Data
public class PopupCriteria extends PopupDto {

    /** 팝업명 */
    private String searchPopupNm;

    /** 검색단어 */
    private String searchWrd = "";

    /** 정렬순서(DESC,ASC) */
    private long sortOrdr = 0L;

    /** 검색사용여부 */
    private String searchUseYn = "";


    private String searchStrtDe;

    private String searchEndDe;

    /** 현재페이지 */
    private int pageIndex = 1;

    /** 페이지갯수 */
    private int pageUnit = 10;

    /** 페이지사이즈 */
    private int pageSize = 10;

    /** 첫페이지 인덱스 */
    private int firstIndex = 1;

    /** 마지막페이지 인덱스 */
    private int lastIndex = 1;

    /** 페이지당 레코드 개수 */
    private int recordCountPerPage = 10;

    /** 레코드 번호 */
    private int rowNo = 0;
}
