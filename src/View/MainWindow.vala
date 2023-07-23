public class Variables.MainWindow : Gtk.ApplicationWindow {
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
        var header_bar = new Gtk.HeaderBar ();
        header_bar.add_css_class (Granite.STYLE_CLASS_FLAT);
        header_bar.title_widget = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        this.set_titlebar (header_bar);

        var root_grid = new Gtk.Grid ();

        root_grid.attach (new Variables.TemplatesView (), 0, 0, 1, 1);
        root_grid.attach (new Variables.TemplateEditor (), 1, 0, 1, 1);

        this.set_child (root_grid);
    }
}
