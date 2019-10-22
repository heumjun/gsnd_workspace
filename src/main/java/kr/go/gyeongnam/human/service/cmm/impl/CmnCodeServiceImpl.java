package kr.go.gyeongnam.human.service.cmm.impl;

import kr.go.gyeongnam.human.dto.cmm.CmnCodeDto;
import kr.go.gyeongnam.human.dto.cmm.DropDownItem;
import kr.go.gyeongnam.human.repository.cmm.CmnCodeRepository;
import kr.go.gyeongnam.human.service.cmm.CmnCodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service("cmnCodeService")
public class CmnCodeServiceImpl implements CmnCodeService {

    @Autowired
    private CmnCodeRepository cmnCodeRepository;

    @Override
    public List<DropDownItem> selectListCmnCodeDetl(String codeId) throws Exception {
        HashMap<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("codeId", codeId);
        searchMap.put("useAt", "Y");

        return selectListCmnCodeDetl(searchMap);
    }

    @Override
    public List<DropDownItem> selectListCmnCodeDetl(HashMap<String, Object> searchMap) throws Exception {
        List<CmnCodeDto> cmnCodeDtos = cmnCodeRepository.selectListCmnCodeDetl(searchMap);
        List<DropDownItem> dropDownItems = new ArrayList<DropDownItem>();

        for(CmnCodeDto codeItem : cmnCodeDtos) {
            DropDownItem item = new DropDownItem();
            item.setText(codeItem.getCodeNm());
            item.setValue(codeItem.getCode());

            dropDownItems.add(item);
        }

        return dropDownItems;
    }
}
