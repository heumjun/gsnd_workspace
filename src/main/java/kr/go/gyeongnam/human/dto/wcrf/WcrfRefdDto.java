package kr.go.gyeongnam.human.dto.wcrf;

import kr.go.gyeongnam.human.dto.cmm.BaseEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class WcrfRefdDto extends BaseEntity {

    /** 반환ID */
    private String returnId;
    /** 구매목록ID */
    private String purchsLstId;
    /** 결제ID*/
    private String setleId;
    /** 환불방법 */
    private String refdSe;
    /** 반환일시 */
    private String returnDt;
    /** 반환금액 */
    private String returnAmt;
    /** 반환은행 */
    private String refdBank;
    /** 반환은행예금주 */
    private String refdBankOwr;
    /** 반환계좌 */
    private String refdAccNo;
    /** 반품신청일시 */
    private String refdReqDt;
    /** 반품사유코드 */
    private String refdResnCd;
    /** 반품사유 */
    private String returnCn;
    /** 취소반품진행상태 */
    private String refdSttusCd;
    /** 처리내용 */
    private String refdRsltCn;

    private String purchsProgrsSttus;

    private String refdSeNm;
    private String refdResnCdNm;
    private String refdSttusCdNm;

    private String purchsProgrsSttusNm;
    private String byerNm;
    private String purchsDt;

    private String typeCd;

    private String purchsDesc;

}
