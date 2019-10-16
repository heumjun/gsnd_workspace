package com.twogoms.woodcraft.service.mypage.impl;

import com.twogoms.woodcraft.dto.mypage.BsktDto;
import com.twogoms.woodcraft.dto.mypage.criteria.BsktCriteria;
import com.twogoms.woodcraft.dto.wcrf.WcrfBuyDto;
import com.twogoms.woodcraft.dto.wcrf.WcrfDto;
import com.twogoms.woodcraft.dto.wcrf.criteria.WcrfBuyCriteria;
import com.twogoms.woodcraft.dto.wcrf.criteria.WcrfCriteria;
import com.twogoms.woodcraft.repository.mypage.BsktRepository;
import com.twogoms.woodcraft.repository.wcrf.WcrfRepository;
import com.twogoms.woodcraft.service.mypage.BsktService;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("BsktService")
public class BsktSerivceImpl implements BsktService {

    @Resource(name = "bsktSeqGnrService")
    private EgovIdGnrService bsktSeqGnrService;

    @Autowired
    private BsktRepository bsktRepository;

    @Override
    public void saveBskt(BsktDto bsktDto) throws Exception {
        try{
            if(EgovStringUtil.isEmpty(bsktDto.getBsktId())){
                bsktDto.setBsktId("Bskt"+bsktSeqGnrService.getNextStringId().substring(4,14));
                bsktRepository.insertBskt(bsktDto);
            }else{
                bsktRepository.updateBskt(bsktDto);
            }

        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public void deleteBskt(BsktDto bsktDto) throws Exception {
        try{
            bsktRepository.deleteBskt(bsktDto);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public List<BsktDto> getBsktList(BsktCriteria bsktCriteria) throws Exception {
        List<BsktDto> retList = bsktRepository.getBsktList(bsktCriteria);

        return retList;
    }

    @Override
    public WcrfDto getBskt(BsktDto bsktDto) throws Exception {
        WcrfDto dto = bsktRepository.getBskt(bsktDto);

        return dto;
    }

    @Override
    public Map<String, Object> getWcrfBuyListMap(WcrfBuyCriteria wcrfBuyCriteria) throws Exception {
        Map<String, Object> retMap = new HashMap<>();
        List<WcrfBuyDto> retList = bsktRepository.getWcrfBuyList(wcrfBuyCriteria);
        int retCnt = bsktRepository.getWcrfBuyListCount(wcrfBuyCriteria);

        retMap.put("retList", retList);
        retMap.put("retCnt", retCnt);

        return retMap;
    }

    @Override
    public Map<String, Object> getExprnReqListMap(WcrfBuyCriteria wcrfBuyCriteria) throws Exception {
        Map<String, Object> retMap = new HashMap<>();
        List<WcrfBuyDto> retList = bsktRepository.getExprnReqList(wcrfBuyCriteria);
        int retCnt = bsktRepository.getExprnReqListCount(wcrfBuyCriteria);

        retMap.put("retList", retList);
        retMap.put("retCnt", retCnt);

        return retMap;
    }

}
