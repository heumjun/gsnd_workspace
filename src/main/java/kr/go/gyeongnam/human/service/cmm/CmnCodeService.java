package kr.go.gyeongnam.human.service.cmm;

import kr.go.gyeongnam.human.dto.cmm.DropDownItem;

import java.util.HashMap;
import java.util.List;

public interface CmnCodeService {
    List<DropDownItem> selectListCmnCodeDetl(String codeId) throws Exception;
    List<DropDownItem> selectListCmnCodeDetl(HashMap<String, Object> searchMap) throws Exception;

}
