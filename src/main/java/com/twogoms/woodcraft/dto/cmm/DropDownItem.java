package com.twogoms.woodcraft.dto.cmm;

public class DropDownItem {
    private String Text;
    private String Value;

    public DropDownItem(String Text, String Value) {
        this.Text = Text;
        this.Value = Value;
    }

    public DropDownItem() {
        this.Text = "";
        this.Value = "";
    }

    public String getText() {
        return Text;
    }

    public void setText(String text) {
        this.Text = text;
    }

    public String getValue() {
        return Value;
    }

    public void setValue(String value) {
        this.Value = value;
    }
}
