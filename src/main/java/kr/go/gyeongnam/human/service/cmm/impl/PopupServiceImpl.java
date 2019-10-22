package kr.go.gyeongnam.human.service.cmm.impl;


import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import kr.go.gyeongnam.human.dto.cmm.PopupDto;
import kr.go.gyeongnam.human.dto.cmm.criteria.PopupCriteria;
import kr.go.gyeongnam.human.repository.cmm.PopupRepository;
import kr.go.gyeongnam.human.service.cmm.PopupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("popupService")
public class PopupServiceImpl implements PopupService {

    @Resource(name = "popupSeqGnrService")
    private EgovIdGnrService popupSeqGnrService;

    @Autowired
    private PopupRepository popupRepository;

    @Override
    public void savePopup(PopupDto popupDto) throws Exception {
        LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

        try{
            if(EgovStringUtil.isEmpty(popupDto.getPopupId())){
                popupDto.setPopupId("POP"+popupSeqGnrService.getNextStringId().substring(4,14));
                popupDto.setRgstrId(loginVO.getId());
                popupDto.setUpdtrId(loginVO.getId());

                popupRepository.insertPopup(popupDto);
            }else{
                popupDto.setUpdtrId(loginVO.getId());
                popupRepository.updatePopup(popupDto);
            }

        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public void deletePopup(PopupDto popupDto) throws Exception {
        try{
            popupRepository.deletePopup(popupDto);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public List<PopupDto> getPopupList(Map<String, Object> params) throws Exception {
        return null;
    }

    @Override
    public Map<String, Object> getPopupListMap(PopupCriteria popupCriteria) throws Exception {
        Map<String, Object> retMap = new HashMap<>();
        List<PopupDto> retList = popupRepository.getPopupList(popupCriteria);
        int retCnt = popupRepository.getPopupListCount(popupCriteria);

        retMap.put("retList", retList);
        retMap.put("retCnt", retCnt);

        return retMap;
    }

    @Override
    public PopupDto getPopup(PopupDto popupDto) throws Exception {
        PopupDto retDto = popupRepository.getPopup(popupDto);
        return retDto;
    }
}