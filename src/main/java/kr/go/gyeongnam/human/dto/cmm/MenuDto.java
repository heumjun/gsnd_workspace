package kr.go.gyeongnam.human.dto.cmm;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MenuDto {

    private String menuNm;
    private String progrmFileNm;
    private long menuNo;
    private long upperMenuNo;
    private int menuOrdr;
    private String menuDc;
    private String progrmStrePath;
    private String url;

}
