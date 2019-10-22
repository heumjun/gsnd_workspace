package kr.go.gyeongnam.human.dto.exprn;

import kr.go.gyeongnam.human.dto.cmm.BaseEntity;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 달력 DTO
 */
@Data
@NoArgsConstructor
public class CalendarDto extends BaseEntity {

    private String year;
    private String yearMonth;
    private String sun;
    private String mon;
    private String tue;
    private String wed;
    private String thu;
    private String fri;
    private String sat;
    private String ym;
}
