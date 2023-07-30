public class Variables.TemplatesView : Gtk.Widget {
    public Variables.TemplatesViewModel view_model { get; construct;}

    private Gtk.Label page_title_label;
    private Gtk.ListView templates_list_view;

    static construct {
        set_layout_manager_type (typeof (Gtk.BoxLayout));
    }

    construct {
        var box_layout = (Gtk.BoxLayout)this.layout_manager;
        box_layout.orientation = Gtk.Orientation.VERTICAL;

        this.hexpand = true;

        view_model = (Variables.TemplatesViewModel) Variables.Application.container.get (typeof (Variables.TemplatesViewModel));

        var list_item_factory = new Gtk.SignalListItemFactory ();
        list_item_factory.setup.connect (on_item_setup);
        list_item_factory.bind.connect (on_item_bind);

        page_title_label = new Gtk.Label ("Templates") {
            halign = Gtk.Align.START
        };

        page_title_label.set_parent (this);

        templates_list_view = new Gtk.ListView (this.view_model.selection_model, list_item_factory);
        templates_list_view.set_parent (this);
    }

    private void on_item_setup (Gtk.ListItem list_item) {
        list_item.child = new Gtk.Label (null) {
            halign = Gtk.Align.START
        };
    }

    protected override void dispose () {
        page_title_label.unparent ();
        templates_list_view.unparent ();

        base.dispose ();
    }

    private void on_item_bind (Gtk.ListItem list_item) {
        Variables.Template template = list_item.item as Variables.Template;
        Gtk.Label child = (Gtk.Label) list_item.child;

        if (template == null) {
            child.label = "Invalid Template Item";
            return;
        }

        child.label = template.name;
    }
}