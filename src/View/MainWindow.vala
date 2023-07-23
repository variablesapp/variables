public class Variables.MainWindow : Gtk.ApplicationWindow {
    public Variables.MainViewModel view_model { get; construct set; }
    public Vdi.Container container { get; set; }

    public MainWindow (Gtk.Application app) {
        Object (
            application: app
        );
    }

    static construct {
        var css_provider = new Gtk.CssProvider ();
        css_provider.load_from_resource (Constants.APP_PATH + "style.css");

        Gtk.StyleContext.add_provider_for_display (Gdk.Display.get_default (),
            css_provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        );
    }

    construct {
        this.container = new Vdi.Container ();
        this.view_model = new MainViewModel (container);

        var header_bar = new Gtk.HeaderBar ();
        this.set_titlebar (header_bar);

        var layout_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);

        layout_box.append (new Variables.TemplatesView ());
        layout_box.append (new Variables.VariablesView ());
        layout_box.append (new Variables.TemplateEditor ());

        this.set_child (layout_box);
    }
}
