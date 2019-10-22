package kr.go.gyeongnam.human.dto.exprn;

import kr.go.gyeongnam.human.dto.cmm.BaseEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 체험상세 DTO
 */
@Data
@NoArgsConstructor
public class ExprnDetailDto extends BaseEntity {

    private String day;
    private String code;
    private String time;
    private String text;
    private String flag;
    private String style;
    private String text2;
    private String text3;
    private String text4;

    private String index;

    // 신규추가 (체험ID, 체험명)
    private String exprnId;
    private String exprnNm;

}
