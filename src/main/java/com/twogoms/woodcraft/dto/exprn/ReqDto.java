package com.twogoms.woodcraft.dto.exprn;

import com.twogoms.woodcraft.dto.cmm.BaseEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 체험예약 DTO
 */
@Data
@NoArgsConstructor
public class ReqDto extends BaseEntity {

    private String exprnReqstId;
    private String exprnId;
    private String mberId;
    private String exprnNmpr;
    private String exprnAmt;
    private String reqSttus;
    private String reqDt;
    private String reqNm;
    private String reqEmail;
    private String telNo;
    private String telNoMid;
    private String telNoLast;
    private String groupNm;
    private String groupTelNo;
    private String groupTelNoMid;
    private String groupTelNoLast;
    private String exprnDay;
    private String exprnTime;
    private String exprnNm;
    private String setleSe;
    private String cashReceiptsOpt;

    private String storeDelngId;
    private String rcpmnyNm;

}
