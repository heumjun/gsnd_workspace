package kr.go.gyeongnam.human.dto.wcrf;

import kr.go.gyeongnam.human.dto.cmm.BaseEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class WcrfBuyDto extends BaseEntity {

    private String purchsAddrId;
    private String byerNm;
    private String byerEmail;
    private String byerTelNo;
    private String byerTelNoMid;
    private String byerTelNoLast;
    private String orerNm;
    private String orerTelNo;
    private String orerTelNoMid;
    private String orerTelNoLast;
    private String orerHp;
    private String orerHpMid;
    private String orerHpLast;
    private String orerZip;
    private String orerAddr;
    private String orerAddrDtl;
    private String orderMessCn;

    private String purchsMstId;
    private String mberId;

    private String purchsId;
    private String wcrfId;
    private String qy;
    private String dscntAmt;
    private String purchsAmt;
    private String wcrfNm;

    private String purchsLstId;
    private String setleSe;
    private String purchsAllAmt;
    private String purchsProgrsSttus;
    private String cashReceiptsOpt;
    private String setleSeAccount;
    private String purchsDt;
    private String purchsDesc;

    private String setleId;
    private String storeDelngId;
    private String setleDt;
    private String cardConfmNo;
    private String setleAmt;
    private String virAccNo;
    private String rcpmnyBank;
    private String rcpmnyAmt;
    private String rcpmnyNm;

    private String setleSeNm;
    private String cashReceiptsOptNm;
    private String purchsProgrsSttusNm;

    private String bsktIdList;
    private String invoiceNumber;

    private String cmd;
    private String typeCd;
    private String exprnSeNm;

    private String bgnDe;
    private String endDe;
    private String exprnDay;
    private String exprnTime;
    private String exprnTime2;

}
