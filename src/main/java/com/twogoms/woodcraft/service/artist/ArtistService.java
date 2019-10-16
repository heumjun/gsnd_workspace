package com.twogoms.woodcraft.service.artist;

import com.twogoms.woodcraft.dto.artist.ArtistDto;
import com.twogoms.woodcraft.dto.artist.criteria.ArtistCriteria;

import java.util.List;
import java.util.Map;

public interface ArtistService {
    /**
     * 작가 저장/수정
     * @param artistDto
     * @throws Exception
     */
    void saveArtist(ArtistDto artistDto) throws Exception;

    /**
     * 작가 삭제
     * @param artistDto
     * @throws Exception
     */
    void deleteArtist(ArtistDto artistDto) throws Exception;

    /**
     * 작가 리스트
     * @param params
     * @return
     * @throws Exception
     */
    List<ArtistDto> getArtistList(Map<String, Object> params) throws Exception;

    /**
     * 작가 리스트
     * @param artistCriteria
     * @return
     * @throws Exception
     */
    Map<String,Object> getArtistListMap(ArtistCriteria artistCriteria) throws Exception;

    /**
     * 작가 전체 리스트
     * @param artistCriteria
     * @return
     * @throws Exception
     */
    Map<String,Object> getArtistAllListMap(ArtistCriteria artistCriteria) throws Exception;

    /**
     * 작가 상세
     * @param artistDto
     * @return
     * @throws Exception
     */
    ArtistDto getArtist(ArtistDto artistDto) throws Exception;
}
