package com.twogoms.woodcraft.dto.wcrf;

import com.twogoms.woodcraft.dto.cmm.BaseEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class WcrfDto extends BaseEntity {
    private String wcrfId;
    private String wcrfNm;
    private String wcrfDesc;
    private String wcrfAmt;
    private String artistNm;
    private String wcrfCnt;
    private String atchFileId;

}
