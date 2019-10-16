package com.twogoms.woodcraft.service.artist.impl;

import com.twogoms.woodcraft.dto.artist.ArtistDto;
import com.twogoms.woodcraft.dto.artist.criteria.ArtistCriteria;
import com.twogoms.woodcraft.repository.artist.ArtistRepository;
import com.twogoms.woodcraft.service.artist.ArtistService;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("artistService")
public class ArtistSerivceImpl implements ArtistService {

    @Resource(name = "artistSeqGnrService")
    private EgovIdGnrService artistSeqGnrService;

    @Autowired
    private ArtistRepository artistRepository;

    @Override
    public void saveArtist(ArtistDto artistDto) throws Exception {

        LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

        try{
            if(EgovStringUtil.isEmpty(artistDto.getArtistId())){
                artistDto.setArtistId("ART"+artistSeqGnrService.getNextStringId().substring(4,14));

                artistDto.setRgstrId(loginVO.getId());
                artistDto.setUpdtrId(loginVO.getId());
                artistRepository.insertArtist(artistDto);
            }else{
                artistDto.setUpdtrId(loginVO.getId());
                artistRepository.updateArtist(artistDto);
            }

        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public void deleteArtist(ArtistDto artistDto) throws Exception {
        try{
            artistRepository.deleteArtist(artistDto);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public List<ArtistDto> getArtistList(Map<String, Object> params) throws Exception {
        List<ArtistDto> retList = null;

        return retList;
    }

    @Override
    public Map<String, Object> getArtistListMap(ArtistCriteria artistCriteria) throws Exception {
        Map<String, Object> retMap = new HashMap<>();
        List<ArtistDto> retList = artistRepository.getArtistList(artistCriteria);
        int retCnt = artistRepository.getArtistListCount(artistCriteria);

        retMap.put("retList", retList);
        retMap.put("retCnt", retCnt);

        return retMap;
    }

    @Override
    public ArtistDto getArtist(ArtistDto artistDto) throws Exception {
        ArtistDto retDto = artistRepository.getArtist(artistDto);
        return retDto;
    }

    /**
     * 작가 전체 리스트
     * @param artistCriteria
     * @return
     * @throws Exception
     */
    @Override
    public Map<String, Object> getArtistAllListMap(ArtistCriteria artistCriteria) throws Exception {
        Map<String, Object> retMap = new HashMap<>();
        List<ArtistDto> retList = artistRepository.getArtistAllList(artistCriteria);
        int retCnt = artistRepository.getArtistListCount(artistCriteria);

        retMap.put("retList", retList);
        retMap.put("retCnt", retCnt);

        return retMap;
    }
}
