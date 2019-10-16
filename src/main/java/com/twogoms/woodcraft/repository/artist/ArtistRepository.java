package com.twogoms.woodcraft.repository.artist;

import com.twogoms.woodcraft.dto.artist.ArtistDto;
import com.twogoms.woodcraft.dto.artist.criteria.ArtistCriteria;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository("artistRepository")
public interface ArtistRepository {

    /**
     * 목록
     * @param
     * @return
     */
    List<ArtistDto> getArtistList(ArtistCriteria artistCriteria);

    /**
     * 목록 페이징 제외
     * @param artistCriteria
     * @return
     */
    List<ArtistDto> getArtistAllList(ArtistCriteria artistCriteria);

    /**
     * 목록건수
     * @param
     * @return
     */
    int getArtistListCount(ArtistCriteria artistCriteria);

    /**
     * 상세
     * @param artistDto
     * @return
     */
    ArtistDto getArtist(ArtistDto artistDto);

    /**
     * 등록
     * @param artistDto
     */
    void insertArtist(ArtistDto artistDto);

    /**
     * 수정
     * @param artistDto
     */
    void updateArtist(ArtistDto artistDto);

    /**
     * 삭제
     * @param artistDto
     */
    void deleteArtist(ArtistDto artistDto);


}
