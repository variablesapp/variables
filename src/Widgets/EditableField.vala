public class Variables.EditableField : Gtk.Widget {
    private Gtk.EditableLabel editable_label;
    private Gtk.Entry entry_field;
    private Gtk.Button edit_button;
    private Gtk.Box label_box;

    static construct {
        set_layout_manager_type (typeof (Gtk.BoxLayout));
    }

    construct {
        var box_layout = (Gtk.BoxLayout)this.layout_manager;
        box_layout.orientation = Gtk.Orientation.VERTICAL;

        this.halign = Gtk.Align.START;

        this.editable_label = new Gtk.EditableLabel ("New Label") {
            halign = Gtk.Align.START,
            editable = false,
        };

        this.entry_field = new Gtk.Entry () {
            hexpand = true
        };

        this.edit_button = new Gtk.Button.from_icon_name ("edit-symbolic") {
            halign = Gtk.Align.START
        };
        
        this.label_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 4);
        this.label_box.append (this.editable_label);
        this.label_box.append (this.edit_button); 

        this.label_box.set_parent (this);
        this.entry_field.set_parent (this);
    }

    protected override void dispose () {
        this.label_box.unparent ();
        this.entry_field.unparent ();

        base.dispose ();
    }
}