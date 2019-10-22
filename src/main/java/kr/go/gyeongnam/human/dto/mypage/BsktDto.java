package kr.go.gyeongnam.human.dto.mypage;

import kr.go.gyeongnam.human.dto.cmm.BaseEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BsktDto extends BaseEntity {
    private String bsktId;
    private String wcrfId;
    private String mberId;
    private String qy;
    private String atchFileId;
    private String wcrfDesc;
    private String wcrfNm;
    private String wcrfAmt;
    private String wcrfCnt;

}
