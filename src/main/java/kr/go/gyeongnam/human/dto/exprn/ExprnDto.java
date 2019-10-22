package kr.go.gyeongnam.human.dto.exprn;

import kr.go.gyeongnam.human.dto.cmm.BaseEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 체험 DTO
 */
@Data
@NoArgsConstructor
public class ExprnDto extends BaseEntity {

    private String exprnId;
    private String exprnNm;
    private String bgnDe;
    private String endDe;
    private String exprnSe;
    private String exprnSeNm;
    private String exprnBaseAmt;
    private String exprnNmpr;
    private String exprnIntrcn;
    private String atchFileId;
    private String atchFileId2;
    private String exprnSttus;
    private String exprnSttusNm;
    private String teacherNm;
    private String exprnMtrAmt;

    private String typeCd;
    private String exprnTime;
    private String exprnDay;
    private String reqCnt;
}
