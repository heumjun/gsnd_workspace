package com.twogoms.woodcraft.service.wcrf.impl;

import com.twogoms.woodcraft.dto.exprn.ReqDto;
import com.twogoms.woodcraft.dto.mypage.BsktDto;
import com.twogoms.woodcraft.dto.wcrf.WcrfBuyDto;
import com.twogoms.woodcraft.dto.wcrf.WcrfDto;
import com.twogoms.woodcraft.repository.exprn.ReqRepository;
import com.twogoms.woodcraft.repository.mypage.BsktRepository;
import com.twogoms.woodcraft.repository.wcrf.WcrfBuyRepository;
import com.twogoms.woodcraft.service.wcrf.WcrfBuyService;
import egovframework.com.cmm.LoginVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("wcrfBuyService")
public class WcrfBuySerivceImpl implements WcrfBuyService {

    @Resource(name = "wcrfBuyMstSeqGnrService")
    private EgovIdGnrService wcrfBuyMstSeqGnrService;

    @Resource(name = "wcrfBuySeqGnrService")
    private EgovIdGnrService wcrfBuySeqGnrService;

    @Resource(name = "wcrfBuyTotSeqGnrService")
    private EgovIdGnrService wcrfBuyTotSeqGnrService;

    @Resource(name = "wcrfBuyAddrSeqGnrService")
    private EgovIdGnrService wcrfBuyAddrSeqGnrService;

    @Resource(name = "wcrfOrerSeqGnrService")
    private EgovIdGnrService wcrfOrerSeqGnrService;

    @Resource(name = "wcrfPaySeqGnrService")
    private EgovIdGnrService wcrfPaySeqGnrService;

    @Autowired
    private WcrfBuyRepository wcrfBuyRepository;

    @Autowired
    private BsktRepository bsktRepository;

    @Autowired
    private ReqRepository reqRepository;

    @Override
    public WcrfBuyDto saveWcrfList(WcrfBuyDto wcrfBuyDto, LoginVO loginVO) throws Exception {
        try{

            String purshMstId = "PUR_MST"+wcrfBuyMstSeqGnrService.getNextStringId().substring(4,14);

            wcrfBuyDto.setPurchsMstId(purshMstId);
            wcrfBuyRepository.insertWcrfBuyMst(wcrfBuyDto);

            int sum = 0;

            if (!EgovStringUtil.isEmpty(wcrfBuyDto.getBsktIdList())) {

                String wcrfNm = "";

                String bsktIdList = wcrfBuyDto.getBsktIdList();
                String[] array = bsktIdList.split(",");

                for (String bsktId : array) {

                    if (EgovStringUtil.isEmpty(bsktId)) continue;

                    BsktDto bsktDto = new BsktDto();
                    bsktDto.setBsktId(bsktId);
                    WcrfDto wcrfDto = bsktRepository.getBskt(bsktDto);
                    WcrfBuyDto WcrfBuyDto2 = new WcrfBuyDto();

                    WcrfBuyDto2.setPurchsId("PUR_"+wcrfBuySeqGnrService.getNextStringId().substring(4,14));
                    WcrfBuyDto2.setPurchsMstId(purshMstId);
                    WcrfBuyDto2.setWcrfId(wcrfDto.getWcrfId());
                    WcrfBuyDto2.setQy(wcrfDto.getWcrfCnt());
                    WcrfBuyDto2.setPurchsAmt(wcrfDto.getWcrfAmt());
                    WcrfBuyDto2.setDscntAmt("0");
                    WcrfBuyDto2.setRgstrId(loginVO.getId());
                    WcrfBuyDto2.setUpdtrId(loginVO.getId());
                    WcrfBuyDto2.setCashReceiptsOpt(wcrfBuyDto.getCashReceiptsOpt());

                    // 무통장일경우
                    if (WcrfBuyDto2.getSetleSe().equals("02")) {
                        if (EgovStringUtil.isEmpty(wcrfBuyDto.getRcpmnyNm())) {
                            WcrfBuyDto2.setRcpmnyNm(wcrfBuyDto.getByerNm());
                        } else {
                            WcrfBuyDto2.setRcpmnyNm(wcrfBuyDto.getRcpmnyNm());
                        }
                        WcrfBuyDto2.setRcpmnyBank("301-0232-4310-31(농협) 진주시청");
                        WcrfBuyDto2.setRcpmnyAmt(wcrfDto.getWcrfAmt());
                    }

                    wcrfBuyRepository.insertWcrfBuy(WcrfBuyDto2);

                    sum = sum + Integer.parseInt(wcrfDto.getWcrfAmt())*Integer.parseInt(wcrfDto.getWcrfCnt());
                    wcrfNm = wcrfDto.getWcrfNm();
                }

                if (array.length > 1) {
                    wcrfBuyDto.setPurchsDesc(wcrfNm + " 외 " + String.valueOf(array.length-1) + "종");
                } else {
                    wcrfBuyDto.setPurchsDesc(wcrfNm);
                }

            } else {
                wcrfBuyDto.setPurchsId("PUR_"+wcrfBuySeqGnrService.getNextStringId().substring(4,14));
                wcrfBuyDto.setDscntAmt("0");
                wcrfBuyRepository.insertWcrfBuy(wcrfBuyDto);

                wcrfBuyDto.setPurchsDesc(wcrfBuyDto.getWcrfNm());

                sum = Integer.parseInt(wcrfBuyDto.getPurchsAmt())*Integer.parseInt(wcrfBuyDto.getQy());
            }

            wcrfBuyDto.setPurchsLstId("TOT_"+wcrfBuyTotSeqGnrService.getNextStringId().substring(4,14));
            wcrfBuyDto.setSetleSe(wcrfBuyDto.getSetleSe());
            wcrfBuyDto.setPurchsProgrsSttus("01");
            wcrfBuyDto.setPurchsAllAmt(String.valueOf(sum));
            wcrfBuyRepository.insertWcrfBuyTot(wcrfBuyDto);

            wcrfBuyDto.setPurchsAddrId("ADDR_"+wcrfBuyAddrSeqGnrService.getNextStringId().substring(4,14));

            wcrfBuyDto.setByerTelNo(wcrfBuyDto.getByerTelNo()+"-"+wcrfBuyDto.getByerTelNoMid()+"-"+wcrfBuyDto.getByerTelNoLast());
            wcrfBuyDto.setOrerTelNo(wcrfBuyDto.getOrerTelNo()+"-"+wcrfBuyDto.getOrerTelNoMid()+"-"+wcrfBuyDto.getOrerTelNoLast());
            wcrfBuyDto.setOrerHp(wcrfBuyDto.getOrerHp()+"-"+wcrfBuyDto.getOrerHpMid()+"-"+wcrfBuyDto.getOrerHpLast());

            wcrfBuyRepository.insertWcrfBuyAddr(wcrfBuyDto);

            wcrfBuyDto.setSetleId("PAY_"+wcrfPaySeqGnrService.getNextStringId().substring(4,14));
            wcrfBuyDto.setSetleSe(wcrfBuyDto.getSetleSe());
            wcrfBuyDto.setStoreDelngId("ORDR_"+wcrfOrerSeqGnrService.getNextStringId().substring(4,14));
            wcrfBuyRepository.insertWcrfPay(wcrfBuyDto);

        }catch (Exception e){
            e.printStackTrace();
        }

        return wcrfBuyDto;
    }

    @Override
    public WcrfBuyDto getWcrfBuyTot(WcrfBuyDto wcrfBuyDto) throws Exception {
        WcrfBuyDto retDto = wcrfBuyRepository.getWcrfBuyTot(wcrfBuyDto);
        return retDto;
    }

    @Override
    public void savePayComplete(WcrfBuyDto wcrfBuyDto) throws Exception {

        wcrfBuyRepository.updateWcrfPay(wcrfBuyDto);

        if ("EXPRN".equals(wcrfBuyDto.getCmd())) {
            //
            ReqDto reqDto = new ReqDto();
            reqDto.setExprnReqstId(wcrfBuyDto.getPurchsLstId());
            reqDto.setReqSttus(wcrfBuyDto.getPurchsProgrsSttus());
            reqDto.setUpdtrId(wcrfBuyDto.getUpdtrId());

            reqRepository.updateReq(reqDto);

        } else {
            wcrfBuyRepository.updateWcrfBuyTot(wcrfBuyDto);

            // 구매완료 품목 장바구니에서 삭제
            if (!EgovStringUtil.isEmpty(wcrfBuyDto.getBsktIdList())) {

                String bsktIdList = wcrfBuyDto.getBsktIdList();
                String[] array = bsktIdList.split(",");

                for (String bsktId : array) {

                    if (EgovStringUtil.isEmpty(bsktId)) continue;

                    BsktDto bsktDto = new BsktDto();
                    bsktDto.setBsktId(bsktId);
                    bsktRepository.deleteBskt(bsktDto);
                }
            }
        }
    }

    @Override
    public List<WcrfDto> getWcrfBuyList(WcrfBuyDto wcrfBuyDto) throws Exception {
        List<WcrfDto> retList = wcrfBuyRepository.getWcrfBuyList(wcrfBuyDto);

        return retList;
    }

    @Override
    public void updateWcrfBuyTot(WcrfBuyDto wcrfBuyDto) throws Exception {

        wcrfBuyRepository.updateWcrfBuyTot(wcrfBuyDto);
    }

    public void updateWcrfPay(WcrfBuyDto wcrfBuyDto) throws Exception {

        wcrfBuyRepository.updateWcrfPay(wcrfBuyDto);
    }
}
