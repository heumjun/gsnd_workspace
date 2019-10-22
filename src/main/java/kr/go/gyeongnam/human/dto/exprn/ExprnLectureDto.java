package kr.go.gyeongnam.human.dto.exprn;

import kr.go.gyeongnam.human.dto.cmm.BaseEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 체험 일정 DTO
 */
@Data
@NoArgsConstructor
public class ExprnLectureDto extends BaseEntity {

    private String exprnLectureId;
    private String exprnId;
    private String exprnDay;
    private String exprnTime;
    private String reservationCnt;
    private String note;

    private String exprnNmpr;
    private String exprnReqCnt;
    private String exprnNm;
    private String exprnNmlc;

}
