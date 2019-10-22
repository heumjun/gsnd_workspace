package kr.go.gyeongnam.human.service.exprn.impl;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import kr.go.gyeongnam.human.dto.exprn.ReqDto;
import kr.go.gyeongnam.human.dto.exprn.criteria.ReqCriteria;
import kr.go.gyeongnam.human.dto.wcrf.WcrfBuyDto;
import kr.go.gyeongnam.human.repository.exprn.ReqRepository;
import kr.go.gyeongnam.human.repository.wcrf.WcrfBuyRepository;
import kr.go.gyeongnam.human.service.exprn.ReqService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("reqService")
public class ReqSerivceImpl implements ReqService {

    @Resource(name = "reqSeqGnrService")
    private EgovIdGnrService reqSeqGnrService;

    @Resource(name = "wcrfPaySeqGnrService")
    private EgovIdGnrService wcrfPaySeqGnrService;

    @Autowired
    private WcrfBuyRepository wcrfBuyRepository;

    @Autowired
    private ReqRepository reqRepository;

    @Override
    public void saveReq(ReqDto reqDto) throws Exception {
        try{
            if(EgovStringUtil.isEmpty(reqDto.getExprnReqstId())){
                reqDto.setExprnReqstId("REQ"+reqSeqGnrService.getNextStringId().substring(4,14));
                reqDto.setReqSttus("01");

                String telNo = reqDto.getTelNo()+reqDto.getTelNoMid()+reqDto.getTelNoLast();
                reqDto.setTelNo(telNo);

                telNo = reqDto.getGroupTelNo()+"-"+reqDto.getGroupTelNoMid()+"-"+reqDto.getGroupTelNoLast();
                reqDto.setGroupTelNo(telNo);

                reqRepository.insertReq(reqDto);

                WcrfBuyDto wcrfBuyDto = new WcrfBuyDto();

                wcrfBuyDto.setSetleId("PAY_"+wcrfPaySeqGnrService.getNextStringId().substring(4,14));
                wcrfBuyDto.setPurchsLstId(reqDto.getExprnReqstId());
                wcrfBuyDto.setSetleSe(reqDto.getSetleSe());
                wcrfBuyDto.setStoreDelngId(reqDto.getStoreDelngId());
                wcrfBuyDto.setRgstrId(reqDto.getRgstrId());
                wcrfBuyDto.setUpdtrId(reqDto.getRgstrId());

                if (EgovStringUtil.isEmpty(reqDto.getRcpmnyNm())) {
                    wcrfBuyDto.setRcpmnyNm(reqDto.getReqNm());
                } else{
                    wcrfBuyDto.setRcpmnyNm(reqDto.getRcpmnyNm());
                }

                wcrfBuyDto.setCashReceiptsOpt(reqDto.getCashReceiptsOpt());

                wcrfBuyDto.setByerNm(reqDto.getReqNm());
                wcrfBuyDto.setByerEmail(reqDto.getReqEmail());
                wcrfBuyDto.setByerTelNo(reqDto.getTelNo());

                wcrfBuyRepository.insertWcrfPay(wcrfBuyDto);

            }else{
                reqRepository.updateReq(reqDto);
            }

        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public void deleteReq(ReqDto reqDto) throws Exception {
        try{
            reqRepository.deleteReq(reqDto);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public Map<String, Object> getReqListMap(ReqCriteria reqCriteria) throws Exception {
        Map<String, Object> retMap = new HashMap<>();
        List<ReqDto> retList = reqRepository.getReqList(reqCriteria);
        int retCnt = reqRepository.getReqListCount(reqCriteria);

        retMap.put("retList", retList);
        retMap.put("retCnt", retCnt);

        return retMap;
    }

    @Override
    public ReqDto getReq(ReqDto reqDto) throws Exception {
        ReqDto retDto = reqRepository.getReq(reqDto);
        return retDto;
    }

    @Override
    public WcrfBuyDto getReqPay(ReqDto reqDto) throws Exception {
        WcrfBuyDto retDto = reqRepository.getReqPay(reqDto);
        return retDto;
    }

    @Override
    public void updateReq(ReqDto reqDto) throws Exception {

        reqRepository.updateReq(reqDto);
    }

    @Override
    public int getReqSumByDay(ReqCriteria reqCriteria) throws Exception {
        int retCnt = reqRepository.getReqSumByDay(reqCriteria);

        return retCnt;
    }
}
