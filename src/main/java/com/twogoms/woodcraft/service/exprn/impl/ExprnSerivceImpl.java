package com.twogoms.woodcraft.service.exprn.impl;

import com.twogoms.woodcraft.dto.exprn.CalendarDto;
import com.twogoms.woodcraft.dto.exprn.ExprnDto;
import com.twogoms.woodcraft.dto.exprn.ExprnLectureDto;
import com.twogoms.woodcraft.dto.exprn.ReqDto;
import com.twogoms.woodcraft.dto.exprn.criteria.ExprnCriteria;
import com.twogoms.woodcraft.repository.exprn.ExprnRepository;
import com.twogoms.woodcraft.service.exprn.ExprnService;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("exprnService")
public class ExprnSerivceImpl implements ExprnService {

    @Resource(name = "exprnSeqGnrService")
    private EgovIdGnrService exprnSeqGnrService;

    @Autowired
    private ExprnRepository exprnRepository;

    @Override
    public void saveExprn(ExprnDto exprnDto) throws Exception {
        try{
            if(EgovStringUtil.isEmpty(exprnDto.getExprnId())){
                exprnDto.setExprnId("EXPRN"+exprnSeqGnrService.getNextStringId().substring(4,14));
                exprnRepository.insertExprn(exprnDto);
            }else{
                exprnRepository.updateExprn(exprnDto);
            }

        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public void deleteExprn(ExprnDto exprnDto) throws Exception {
        try{
            exprnRepository.deleteExprn(exprnDto);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public Map<String, Object> getExprnListMap(ExprnCriteria exprnCriteria) throws Exception {
        Map<String, Object> retMap = new HashMap<>();
        List<ExprnDto> retList = exprnRepository.getExprnList(exprnCriteria);
        int retCnt = exprnRepository.getExprnListCount(exprnCriteria);

        retMap.put("retList", retList);
        retMap.put("retCnt", retCnt);

        return retMap;
    }

    @Override
    public Map<String, Object> getExprnPgmListMap(ExprnCriteria exprnCriteria) throws Exception {
        Map<String, Object> retMap = new HashMap<>();
        exprnCriteria.setExprnSe("01");
        List<ExprnDto> retList01 = exprnRepository.getExprnPgmList(exprnCriteria);
        int retListCnt01 = exprnRepository.getExprnPgmListCount(exprnCriteria);
        exprnCriteria.setExprnSe("02");
        List<ExprnDto> retList02 = exprnRepository.getExprnPgmList(exprnCriteria);
        int retListCnt02 = exprnRepository.getExprnPgmListCount(exprnCriteria);
        exprnCriteria.setExprnSe("03");
        List<ExprnDto> retList03 = exprnRepository.getExprnPgmList(exprnCriteria);
        int retListCnt03 = exprnRepository.getExprnPgmListCount(exprnCriteria);

        retMap.put("retList01", retList01);
        retMap.put("retListCnt01", retListCnt01);

        retMap.put("retList02", retList02);
        retMap.put("retListCnt02", retListCnt02);

        retMap.put("retList03", retList03);
        retMap.put("retListCnt03", retListCnt03);

        return retMap;
    }

    @Override
    public ExprnDto getExprn(ExprnDto exprnDto) throws Exception {
        ExprnDto retDto = exprnRepository.getExprn(exprnDto);
        return retDto;
    }

    @Override
    public List<CalendarDto> getCalendarList(CalendarDto calendarDto) throws Exception {
        List<CalendarDto> retList = exprnRepository.getCalendarList(calendarDto);

        return retList;
    }

    @Override
    public List<ExprnLectureDto> getExprnLectureList(ExprnCriteria exprnCriteria) throws Exception {
        List<ExprnLectureDto> retList = exprnRepository.getExprnLectureList(exprnCriteria);

        return retList;
    }

    @Override
    public void saveExprnLecture(ExprnLectureDto exprnLectureDto) throws Exception {
        try{
            if(EgovStringUtil.isEmpty(exprnLectureDto.getExprnLectureId())){
                exprnLectureDto.setExprnLectureId("LECTURE"+exprnSeqGnrService.getNextStringId().substring(4,14));
                exprnRepository.insertExprnLecture(exprnLectureDto);
            }else{
                exprnRepository.updateExprnLecture(exprnLectureDto);
            }

        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public void deleteExprnLecture(ExprnLectureDto exprnLectureDto) throws Exception {
        try{
            exprnRepository.deleteExprnLecture(exprnLectureDto);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public Map<String, Object> getExprnLectureListMap(ExprnCriteria exprnCriteria) throws Exception {
        Map<String, Object> retMap = new HashMap<>();
        List<ExprnLectureDto> retList = exprnRepository.getExprnLectureListView(exprnCriteria);
        int retCnt = exprnRepository.getExprnLectureListCount(exprnCriteria);

        retMap.put("retList", retList);
        retMap.put("retCnt", retCnt);

        return retMap;
    }

    @Override
    public ExprnLectureDto getExprnLecture(ExprnLectureDto exprnLectureDto) throws Exception {
        ExprnLectureDto retDto = exprnRepository.getExprnLecture(exprnLectureDto);
        return retDto;
    }

    /**
     * ryan added
     *
     * @param ExprnLectureDto
     * @return
     * @throws Exception
     */
    @Override
    public Map<String, Object> getExprnLectureReqListMap(ExprnLectureDto ExprnLectureDto) throws Exception {
        Map<String, Object> retMap = new HashMap<>();
        List<ReqDto> retList = exprnRepository.getExprnLectureReqList(ExprnLectureDto);
        int retCnt = exprnRepository.getExprnLectureReqListCnt(ExprnLectureDto);

        retMap.put("retList", retList);
        retMap.put("retCnt", retCnt);

        return retMap;
    }

    /**
     * david.cho added
     *
     * @param prgmDto
     * @return
     * @throws Exception
     */
    @Override
    public Map<String, Object> getExprnPrgmReqListMap(ExprnDto prgmDto) throws Exception {
        Map<String, Object> retMap = new HashMap<>();
        List<ReqDto> retList = exprnRepository.getExprnPrgmReqList(prgmDto);
        int retCnt = exprnRepository.getExprnPrgmReqListCnt(prgmDto);

        retMap.put("retList", retList);
        retMap.put("retCnt", retCnt);
        return retMap;
    }


}
