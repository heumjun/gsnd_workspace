package kr.go.gyeongnam.human.service.cmm;

import kr.go.gyeongnam.human.dto.cmm.PopupDto;
import kr.go.gyeongnam.human.dto.cmm.criteria.PopupCriteria;

import java.util.List;
import java.util.Map;

public interface PopupService {

    /**
     * 팝업저장
     * @param popupDto
     * @throws Exception
     */
    void savePopup(PopupDto popupDto) throws Exception;

    /**
     * 팝업삭제
     * @param popupDto
     * @throws Exception
     */
    void deletePopup(PopupDto popupDto) throws Exception;

    /**
     *
     * @param params
     * @return
     * @throws Exception
     */
    List<PopupDto> getPopupList(Map<String, Object> params) throws Exception;

    /**
     *
     * @param popupCriteria
     * @return
     * @throws Exception
     */
    Map<String, Object> getPopupListMap(PopupCriteria popupCriteria) throws Exception;

    /**
     *
     * @param popupDto
     * @return
     * @throws Exception
     */
    PopupDto getPopup(PopupDto popupDto) throws Exception;

}
