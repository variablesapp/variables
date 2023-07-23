public class Variables.TemplatesView : Gtk.Box {
    public Variables.TemplatesViewModel view_model { get; construct;}
    
    construct {
        this.orientation = Gtk.Orientation.VERTICAL;
        this.hexpand = true;

        view_model = (Variables.TemplatesViewModel) Variables.Application.container().get (typeof(Variables.TemplatesViewModel));

        var list_item_factory = new Gtk.SignalListItemFactory ();
        list_item_factory.setup.connect (on_item_setup);
        list_item_factory.bind.connect (on_item_bind);


        this.append (new Gtk.Label ("Templates") {
            halign = Gtk.Align.START
        });

        var templates_list_view = new Gtk.ListView (this.view_model.selection_model, list_item_factory);
        this.append (templates_list_view);
    }

    private void on_item_setup (Gtk.ListItem list_item) {
        list_item.child = new Gtk.Label (null) {
            halign = Gtk.Align.START
        };
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