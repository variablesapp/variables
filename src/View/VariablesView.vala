public class Variables.VariablesView : Gtk.Widget {
    public Variables.VariablesViewModel view_model { get; construct; }

    private Gtk.ListView list_view;
    private Variables.EditableField example_field;

    static construct {
        set_layout_manager_type (typeof (Gtk.BoxLayout));
    }

    construct {
        var box_layout = (Gtk.BoxLayout)this.layout_manager;
        box_layout.orientation = Gtk.Orientation.VERTICAL;

        this.hexpand = true;
        this.view_model = (Variables.VariablesViewModel) Variables.Application.container().get (typeof(Variables.VariablesViewModel));        

        var list_item_factory = new Gtk.SignalListItemFactory ();
        list_item_factory.setup.connect (on_item_setup);
        list_item_factory.bind.connect (on_item_bind);

        list_view = new Gtk.ListView (this.view_model.selection_model, list_item_factory);
        list_view.set_parent (this);
    }

    protected override void dispose () {
        this.list_view.unparent ();
        this.example_field.unparent ();
    }

    private void on_item_setup (Gtk.ListItem list_item) {
        list_item.child = new Variables.EditableField () {
            halign = Gtk.Align.START
        };
    }

    private void on_item_bind (Gtk.ListItem list_item) {
        Variables.Variable variable = list_item.item as Variables.Variable;
        var child = (Variables.EditableField) list_item.child;

        if (variable == null) {
            child.label_name = "Invalid";
            child.entry_text = "Invalid entry text";
            return;
        }

        child.label_name = variable.name;
        child.entry_text = variable.value;
    }
}