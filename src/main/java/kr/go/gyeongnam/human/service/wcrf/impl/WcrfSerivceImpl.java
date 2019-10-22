package kr.go.gyeongnam.human.service.wcrf.impl;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import kr.go.gyeongnam.human.dto.wcrf.WcrfDto;
import kr.go.gyeongnam.human.dto.wcrf.criteria.WcrfCriteria;
import kr.go.gyeongnam.human.repository.wcrf.WcrfRepository;
import kr.go.gyeongnam.human.service.wcrf.WcrfService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("wcrfService")
public class WcrfSerivceImpl implements WcrfService {

    @Resource(name = "wcrfSeqGnrService")
    private EgovIdGnrService wcrfSeqGnrService;

    @Autowired
    private WcrfRepository wcrfRepository;

    @Override
    public void saveWcrf(WcrfDto wcrfDto) throws Exception {
        try{
            if(EgovStringUtil.isEmpty(wcrfDto.getWcrfId())){
                wcrfDto.setWcrfId("WCRF"+wcrfSeqGnrService.getNextStringId().substring(4,14));
                wcrfRepository.insertWcrf(wcrfDto);
            }else{
                wcrfRepository.updateWcrf(wcrfDto);
            }

        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public void deleteWcrf(WcrfDto wcrfDto) throws Exception {
        try{
            wcrfRepository.deleteWcrf(wcrfDto);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public Map<String, Object> getWcrfListMap(WcrfCriteria wcrfCriteria) throws Exception {
        Map<String, Object> retMap = new HashMap<>();
        List<WcrfDto> retList = wcrfRepository.getWcrfList(wcrfCriteria);
        int retCnt = wcrfRepository.getWcrfListCount(wcrfCriteria);

        retMap.put("retList", retList);
        retMap.put("retCnt", retCnt);

        return retMap;
    }

    @Override
    public WcrfDto getWcrf(WcrfDto wcrfDto) throws Exception {
        WcrfDto retDto = wcrfRepository.getWcrf(wcrfDto);
        return retDto;
    }

}
