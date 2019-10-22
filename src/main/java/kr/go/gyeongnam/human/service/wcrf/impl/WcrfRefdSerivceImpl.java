package kr.go.gyeongnam.human.service.wcrf.impl;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import kr.go.gyeongnam.human.dto.wcrf.WcrfRefdDto;
import kr.go.gyeongnam.human.dto.wcrf.criteria.WcrfRefdCriteria;
import kr.go.gyeongnam.human.repository.wcrf.WcrfRefdRepository;
import kr.go.gyeongnam.human.service.wcrf.WcrfRefdService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("wcrfRefdService")
public class WcrfRefdSerivceImpl implements WcrfRefdService {

    @Resource(name = "wcrfRefdSeqGnrService")
    private EgovIdGnrService wcrfRefdSeqGnrService;

    @Autowired
    private WcrfRefdRepository wcrfRefdRepository;

    @Override
    public void saveWcrfRefd(WcrfRefdDto wcrfRefdDto) throws Exception {
        try{
            if(EgovStringUtil.isEmpty(wcrfRefdDto.getReturnId())){
                wcrfRefdDto.setReturnId("Refd"+wcrfRefdSeqGnrService.getNextStringId().substring(4,14));
                wcrfRefdRepository.insertWcrfRefd(wcrfRefdDto);
            }else{
                wcrfRefdRepository.updateWcrfRefd(wcrfRefdDto);
            }

        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public void deleteWcrfRefd(WcrfRefdDto wcrfRefdDto) throws Exception {
        try{
            wcrfRefdRepository.deleteWcrfRefd(wcrfRefdDto);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public Map<String, Object> getWcrfRefdListMap(WcrfRefdCriteria wcrfRefdCriteria) throws Exception {
        Map<String, Object> retMap = new HashMap<>();
        List<WcrfRefdDto> retList = wcrfRefdRepository.getWcrfRefdList(wcrfRefdCriteria);
        int retCnt = wcrfRefdRepository.getWcrfRefdListCount(wcrfRefdCriteria);

        retMap.put("retList", retList);
        retMap.put("retCnt", retCnt);

        return retMap;
    }

    @Override
    public WcrfRefdDto getWcrfRefd(WcrfRefdDto wcrfRefdDto) throws Exception {
        WcrfRefdDto retDto = wcrfRefdRepository.getWcrfRefd(wcrfRefdDto);
        return retDto;
    }

    @Override
    public Map<String, Object> getExprnRefdListMap(WcrfRefdCriteria wcrfRefdCriteria) throws Exception {
        Map<String, Object> retMap = new HashMap<>();
        List<WcrfRefdDto> retList = wcrfRefdRepository.getExprnRefdList(wcrfRefdCriteria);
        int retCnt = wcrfRefdRepository.getExprnRefdListCount(wcrfRefdCriteria);

        retMap.put("retList", retList);
        retMap.put("retCnt", retCnt);

        return retMap;
    }

}
