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
        header_bar.add_css_class (Granite.STYLE_CLASS_FLAT);
        header_bar.title_widget = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        this.set_titlebar (header_bar);

        var layout_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);

        layout_box.append (new Variables.TemplatesView (this));
        layout_box.append (new Variables.VariablesView (this));
        layout_box.append (new Variables.TemplateEditor (this));

        this.set_child (layout_box);
    }
}
