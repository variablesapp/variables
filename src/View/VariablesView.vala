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

        list_view = new Gtk.ListView (this.view_model.selection_model, list_item_factory);

        example_field = new Variables.EditableField ();
        example_field.set_parent (this);
    }

    protected override void dispose () {
        this.list_view.unparent ();
        this.example_field.unparent ();
    }
}