package kr.go.gyeongnam.human.dto.cmm;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PopupDto  extends BaseEntity {
    private String popupId;
    private String popupNm;
    private String strtDe;
    private String endDe;
    private String urlType;
    private String linkUrl;
    private String useYn;
    private String atchFileId;
}
