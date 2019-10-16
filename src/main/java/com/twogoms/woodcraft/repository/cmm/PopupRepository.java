package com.twogoms.woodcraft.repository.cmm;

import com.twogoms.woodcraft.dto.cmm.PopupDto;
import com.twogoms.woodcraft.dto.cmm.criteria.PopupCriteria;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("popupRepository")
public interface PopupRepository {
    /**
     * 목록
     * @param popupCriteria
     * @return
     */
    List<PopupDto> getPopupList(PopupCriteria popupCriteria);

    /**
     * 목록건수
     * @param popupCriteria
     * @return
     */
    int getPopupListCount(PopupCriteria popupCriteria);

    /**
     * 상세
     * @param popupDto
     * @return
     */
    PopupDto getPopup(PopupDto popupDto);

    /**
     * 등록
     * @param popupDto
     */
    void insertPopup(PopupDto popupDto);

    /**
     * 수정
     * @param popupDto
     */
    void updatePopup(PopupDto popupDto);

    /**
     * 삭제
     * @param popupDto
     */
    void deletePopup(PopupDto popupDto);
}
