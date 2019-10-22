package kr.go.gyeongnam.human.dto.cmm;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
public class BaseEntity  implements Serializable {

    private static final long serialVersionUID = -1279717461725310159L;

    private String rgstrId;
    private String updtrId;
    private Date rgstDt;
    private Date updtDt;

    private String menuNo;

}
