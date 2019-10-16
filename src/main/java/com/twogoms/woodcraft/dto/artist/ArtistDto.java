package com.twogoms.woodcraft.dto.artist;

import com.twogoms.woodcraft.dto.cmm.BaseEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ArtistDto extends BaseEntity {
    private String artistId;
    private String artistNm;
    private String crfShopNm;
    private String adres;
    private String roadAdres;
    private String dtlAdres;
    private String telNo;
    private String hpNo;
    private String hmpg;
    private String email;
    private String artistDesc;
    private String supGoods;
    private String atchFileId;
    private String atchFileId2;
    private String etcCn;
}
